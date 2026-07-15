<?php

namespace Common\Settings\Mail;

use GuzzleHttp\Client;
use Illuminate\Support\Facades\Lang;
use RuntimeException;

class BrevoApiMailer
{
    public function apiKey(): ?string
    {
        $key = getenv('BREVO_API_KEY') ?: env('BREVO_API_KEY');

        return $key ?: null;
    }

    public function isConfigured(): bool
    {
        return (bool) $this->apiKey();
    }

    public function sendPasswordReset(string $to, string $resetUrl): void
    {
        $subject = Lang::get('Reset Password Notification');
        $appName = config('app.name', 'Areen');
        $expire = config(
            'auth.passwords.' .
                config('auth.defaults.passwords') .
                '.expire',
            60,
        );

        $html = view('common::emails.password-reset', [
            'resetUrl' => $resetUrl,
            'appName' => $appName,
            'expire' => $expire,
        ])->render();

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
        $fromName =
            config('mail.from.name') ?: env('MAIL_FROM_NAME') ?: config('app.name');

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
