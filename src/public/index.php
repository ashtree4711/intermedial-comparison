<?php

use Slim\App;
use Slim\Views\Twig;

require './vendor/autoload.php';
require_once 'config.php';
$app = new App(["settings" => $config]);
$container=$app->getContainer();
$container['view'] = function ($container) {
    $view = new Twig('templates', [
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
$app->get('/works/{work_id}/chunks/{chunk_no}', '\App\controllers\SiteController:showComparison');
$app->get('/transc/{transc_id}/edit', '\App\controllers\SiteController:getTranscription' );
$app->post('/transc/{transc_id}/edit', '\App\controllers\SiteController:setTextProperty' );
$app->delete('/transc/{transc_id}/edit', '\App\controllers\SiteController:deleteTextProperty' );
$app->get('/transc/{transc_id}', '\App\controllers\SiteController:getStyledTranscription' );
$app->get('/plaintexts/{plaintext_id}', '\App\controllers\SiteController:getPlaintext' );
$app->get('/faksimile/{page_id}', '\App\controllers\SiteController:getFaksimile' );
$app->run();


