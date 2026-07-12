<?php

return [
    'upload_types' => [
        'bedrive' => [
            'visibility' => 'private',
            'dont_clean' => true,
            'supports_folders' => true,
            'supports_max_space_usage' => true,
            'max_space_usage_setting' => 'drive.default_available_space',
            'label' => 'Areen uploads',
            'description' => 'All files uploaded by users in Areen.',
            'defaults' => [
                'max_file_size' => '5242880',
            ],
        ],
    ],
];
