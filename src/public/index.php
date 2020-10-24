<?php

require './vendor/autoload.php';
require_once 'config.php';
$app = new \Slim\App(["settings" => $config]);
$container=$app->getContainer();
$container['view'] = function ($container) {
    $view = new \Slim\Views\Twig('templates', [
        'cache' => false
    ]);
    return $view;
};
$container["baseurl"]=$config["baseurl"];
$container['view']->twigTemplateDirs = array(
    './templates'
);

$capsule = new Illuminate\Database\Capsule\Manager;
$capsule->addConnection($container['settings']['db']);
$capsule->setAsGlobal();
$capsule->bootEloquent();

$app->get('/', '\App\controllers\SiteController:showStart');
$app->get('/chunks/{chunk_id}', '\App\controllers\SiteController:showComparison');
$app->get('/chunks/{chunk_id}/{occurrence_id}', '\App\controllers\SiteController:getOccurrence');

$app->get('/plaintexts/{plaintext_id}', '\App\controllers\SiteController:getPlaintext' );
$app->get('/plaintexts/{plaintext_id}/edit', '\App\controllers\SiteController:getPlaintextEdit' );
$app->get('/faksimile/{page_id}', '\App\controllers\SiteController:getFaksimile' );


$app->run();


