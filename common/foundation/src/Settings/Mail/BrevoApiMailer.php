<?php

namespace Common\Settings\Mail;

use GuzzleHttp\Client;
use Illuminate\Support\Facades\Lang;
use RuntimeException;

class BrevoApiMailer
{
    public function apiKey(): ?string
    {
        foreach ($this->candidateKeys() as $key) {
            if ($this->isApiKey($key)) {
                return $key;
            }
        }

        return null;
    }

    /**
     * @return list<string|null>
     */
    private function candidateKeys(): array
    {
        $keys = [
            getenv('BREVO_API_KEY') ?: null,
            env('BREVO_API_KEY') ?: null,
            getenv('MAIL_PASSWORD') ?: null,
            env('MAIL_PASSWORD') ?: null,
            $this->readFromDotEnvFile('BREVO_API_KEY'),
            $this->readFromDotEnvFile('MAIL_PASSWORD'),
        ];

        return array_values(array_unique(array_filter($keys)));
    }

    private function isApiKey(?string $key): bool
    {
        return is_string($key) && str_starts_with($key, 'xkeysib-');
    }

    private function readFromDotEnvFile(string $name): ?string
    {
        $path = base_path('.env');
        if (!is_readable($path)) {
            return null;
        }

        foreach (file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $line) {
            $line = trim($line);
            if ($line === '' || str_starts_with($line, '#')) {
                continue;
            }

            if (!str_starts_with($line, "{$name}=")) {
                continue;
            }

            $value = substr($line, strlen($name) + 1);
            $value = trim($value, "\"'");

            return $value !== '' ? $value : null;
        }

        return null;
    }

    public function isConfigured(): bool
    {
        return (bool) $this->apiKey();
    }

    public function sendPasswordReset(string $to, string $resetUrl): void
    {
        $subject = Lang::get('Reset Password Notification');
        $expire = config(
            'auth.passwords.' .
                config('auth.defaults.passwords') .
                '.expire',
            60,
        );

        $html = '<p>' .
            e(
                Lang::get(
                    'You are receiving this email because we received a password reset request for your account.',
                ),
            ) .
            '</p><p><a href="' .
            e($resetUrl) .
            '">' .
            e(Lang::get('Reset Password')) .
            '</a></p><p>' .
            e(
                Lang::get(
                    'This password reset link will expire in :count minutes.',
                    ['count' => $expire],
                ),
            ) .
            '</p><p>' .
            e(
                Lang::get(
                    'If you did not request a password reset, no further action is required.',
                ),
            ) .
            '</p>';

        $text = implode("\n\n", [
            Lang::get(
                'You are receiving this email because we received a password reset request for your account.',
            ),
            Lang::get('Reset Password') . ': ' . $resetUrl,
            Lang::get(
                'This password reset link will expire in :count minutes.',
                ['count' => $expire],
            ),
            Lang::get(
                'If you did not request a password reset, no further action is required.',
            ),
        ]);

        $this->send($to, $subject, $html, $text);
    }

    public function send(
        string $to,
        string $subject,
        string $htmlContent,
        ?string $textContent = null,
    ): void {
        $apiKey = $this->apiKey();
        if (!$apiKey) {
            throw new RuntimeException('BREVO_API_KEY is not configured.');
        }

        $fromAddress =
            config('mail.from.address') ?:
            env('MAIL_FROM_ADDRESS') ?:
            'rranjithkumar100@gmail.com';
        $fromName = 'Areen';

        $payload = [
            'sender' => [
                'email' => $fromAddress,
                'name' => $fromName,
            ],
            'to' => [['email' => $to]],
            'subject' => $subject,
            'htmlContent' => $htmlContent,
        ];

        if ($textContent) {
            $payload['textContent'] = $textContent;
        }

        $response = (new Client(['timeout' => 15]))->post(
            'https://api.brevo.com/v3/smtp/email',
            [
                'headers' => [
                    'api-key' => $apiKey,
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                ],
                'json' => $payload,
                'http_errors' => false,
            ],
        );

        if ($response->getStatusCode() !== 201) {
            throw new RuntimeException(
                'Brevo API error: ' . $response->getBody()->getContents(),
            );
        }
    }
}
