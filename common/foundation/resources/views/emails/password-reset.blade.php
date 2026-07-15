<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{{ __('Reset Password Notification') }}</title>
</head>
<body style="font-family: sans-serif; line-height: 1.5; color: #333;">
    <p>{{ __('You are receiving this email because we received a password reset request for your account.') }}</p>
    <p>
        <a href="{{ $resetUrl }}" style="display:inline-block;padding:10px 16px;background:#2563eb;color:#fff;text-decoration:none;border-radius:4px;">
            {{ __('Reset Password') }}
        </a>
    </p>
    <p>{{ __('This password reset link will expire in :count minutes.', ['count' => $expire]) }}</p>
    <p>{{ __('If you did not request a password reset, no further action is required.') }}</p>
    <p style="font-size:12px;color:#666;">{{ $appName }}</p>
</body>
</html>
