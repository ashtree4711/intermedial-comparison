<?php


/*error_reporting(E_ALL);
set_error_handler(function ($severity, $message, $file, $line) {
    if (error_reporting() & $severity) {
        throw new \ErrorException($message, 0, $severity, $file, $line);
    }
});*/

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
    './templates/viewer'
);

// Comment this area for slim error
if ($config["maintenance"]==false){
    $container['notFoundHandler'] = function ($c) {
        return function ($request, $response) use ($c) {
            return $c['view']->render($response->withStatus(404), 'viewer/404.twig', [
                "message" => "The requested URL was not found on this server"
            ]);
        };
    };

    $container['errorHandler'] = function ($c) {
        return function ($request, $response) use ($c) {
            return $c['view']->render($response->withStatus(500), 'viewer/500.twig', [
                "message" => "An internal error has occurred. "
            ]);
        };
    };

    $container['phpErrorHandler'] = function ($container) {
        return $container['errorHandler'];
    };
}



// Service factory for the ORM, move into bootstrap file
$capsule = new Illuminate\Database\Capsule\Manager;
$capsule->addConnection($container['settings']['db']);
$capsule->setAsGlobal();
$capsule->bootEloquent();







$app->get('/', '\App\controllers\SiteController:showStart');
$app->get('/chunks/{chunk_id}', '\App\controllers\SiteController:showComparison');
$app->get('/chunks/{chunk_id}/{occurrence_id}', '\App\controllers\SiteController:getOccurrence');

$app->get('/plaintexts/{plaintext_id}', '\App\controllers\SiteController:getPlaintext' );
$app->get('/faksimile/{page_id}', '\App\controllers\SiteController:getFaksimile' );




$app->run();


