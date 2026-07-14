<?php namespace Common\Settings;

use Dotenv\Dotenv;
use Dotenv\Repository\RepositoryBuilder;
use Illuminate\Support\Collection;
use Illuminate\Support\Str;

class DotEnvEditor
{
    public function __construct(protected string $fileName = '.env') {}

    public function load(): array
    {
        if (!file_exists(base_path($this->fileName))) {
            return $this->loadFromProcessEnvironment();
        }

        $dotEnv = Dotenv::create(
            RepositoryBuilder::createWithNoAdapters()->make(),
            [base_path()],
            $this->fileName,
        );
        $values = $dotEnv->load();
        $lowercaseValues = [];

        foreach ($values as $key => $value) {
            $lowercaseValues[strtolower($key)] = $this->normalizeLoadedValue(
                $value,
            );
        }

        return $lowercaseValues;
    }

    protected function loadFromProcessEnvironment(): array
    {
        $lowercaseValues = [];
        $examplePath = base_path('.env.example');

        if (!file_exists($examplePath)) {
            foreach ($_ENV as $key => $value) {
                if (is_string($key)) {
                    $lowercaseValues[strtolower($key)] =
                        $this->normalizeLoadedValue($value);
                }
            }

            return $lowercaseValues;
        }

        foreach (
            file($examplePath, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES)
            as $line
        ) {
            $line = trim($line);
            if (
                $line === '' ||
                str_starts_with($line, '#') ||
                !str_contains($line, '=')
            ) {
                continue;
            }

            [$key] = explode('=', $line, 2);
            $key = trim($key);
            $lowercaseValues[strtolower($key)] = $this->normalizeLoadedValue(
                env($key),
            );
        }

        return $lowercaseValues;
    }

    private function normalizeLoadedValue(mixed $value): mixed
    {
        if (!is_string($value)) {
            return $value;
        }

        if (strtolower($value) === 'null') {
            return null;
        }
        if (strtolower($value) === 'false') {
            return false;
        }
        if (strtolower($value) === 'true') {
            return true;
        }
        if (preg_match('/\A([\'"])(.*)\1\z/', $value, $matches)) {
            return $matches[2];
        }

        return $value;
    }

    public function write(array|Collection $values = []): void
    {
        $path = base_path($this->fileName);

        if (!file_exists($path)) {
            $examplePath = base_path('.env.example');
            if (file_exists($examplePath)) {
                copy($examplePath, $path);
            } else {
                touch($path);
            }
        }

        $content = file_get_contents($path);

        foreach ($values as $key => $value) {
            $value = $this->formatValue($value);
            $key = strtoupper($key);
            $valueIsNull = $value === 'null';

            preg_match("/^($key=)(.*?)(\n|\Z)/msi", $content, $matches);

            // this key already exists in .env file
            if (!empty($matches)) {
                // if value is null, remove the key from .env file
                if ($valueIsNull) {
                    $content = str_replace($matches[0], '', $content);
                } else {
                    // otherwise replace the current value with the new one
                    $content = str_replace(
                        $matches[1] . $matches[2],
                        $matches[1] . $value,
                        $content,
                    );
                }
            } else {
                if (!$valueIsNull) {
                    $content .= "\n$key=$value";
                }
            }
        }

        // collapse multiple empty lines into one
        $content = preg_replace("/\n{3,}/", "\n", $content);

        file_put_contents(base_path($this->fileName), $content);
    }

    /**
     * Format specified value to be compatible with .env file
     */
    private function formatValue(mixed $value = null): string
    {
        if ($value === 0 || $value === false) {
            $value = 'false';
        }
        if ($value === 1 || $value === true) {
            $value = 'true';
        }
        if (!$value) {
            $value = 'null';
        }
        $value = trim($value);

        // wrap string in quotes, if it contains whitespace or special characters
        if (preg_match('/\s/', $value) || Str::contains($value, '#')) {
            //replace double quotes with single quotes
            $value = str_replace('"', "'", $value);

            //wrap string in quotes
            $value = '"' . $value . '"';
        }

        return $value;
    }
}
