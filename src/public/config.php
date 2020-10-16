<?php
$config = [
    // Slim Settings
    'determineRouteBeforeAppMiddleware' => false,
    'displayErrorDetails' => true,
    'db' => [
        'driver' => 'mysql',
        'host' => 'localhost:3306',
        'database' => 'ict',
        'username' => 'ict',
        'password' => 'ict',
        'charset'   => 'utf8mb4',
        'collation' => 'utf8mb4_unicode_ci',
        'prefix'    => '',
    ]

];

$config['baseurl']='http://localhost:8000/';

$config['maintenance']=true;
