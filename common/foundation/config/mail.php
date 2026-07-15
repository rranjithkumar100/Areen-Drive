<?php

return [
    'mailers' => [
        'gmailApi' => [
            'transport' => 'gmailApi',
        ],
        'mailgun' => [
            'transport' => 'mailgun',
        ],
        'brevo' => [
            'transport' => 'brevo',
            'key' => env('BREVO_API_KEY'),
        ],
    ],
    'enable_contact_page' => env('ENABLE_CONTACT_PAGE', false),
];
