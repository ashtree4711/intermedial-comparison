<?php
namespace App\controllers;
use App\models\Document;
use App\models\FaksimilePage;
use App\models\Plaintext;
use App\models\StandoffProperty;
use App\operations\ComparisonManager;
use App\operations\WorkManager;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

/**
 * Class SiteController
 * @package App\controllers
 */
class SiteController extends BaseController {


    /**
     * Gibt die Sammlung der Daten in Auftrag und rendert die Startseite. Notiz: Insofern die Daten ohne weitere
     * Verarbeitung über die ORM geholt werden können, geschieht dies bereits im Controller
     * @param Request $request
     * @param Response $response
     *
     * GET-Request "/"
     */
    function showStart(Request $request, Response $response){
        $webInfo["baseurl"]=$this->baseUrl;
        $data=array();
        $data["properties"]=StandoffProperty::where("property_name", "=", "chunk")->where("property_value", "=", 1)->get()->toArray();
        $data["documents"]=Document::with("transcriptions", "faksimile")->get()->toArray();
        $data["works"]=WorkManager::all();
        $this->view->render($response, 'view/start.twig', ["webInfo" => $webInfo, "data" => $data]);
    }

    /**
     * Liest Attribute und Parameter aus (Chunk-Id, optional: Occurrence-Id). Gibt Sammlung der Daten in Auftrag
     * und rendet den Einstieg in das Vergleichstool
     * @param Request $request
     * @param Response $response
     *
     * GET-Request "/chunks/{chunk_id}"
     */
    function showComparison(Request $request, Response $response){
        $webInfo["baseurl"]=$this->baseUrl;
        $chunkId = $request->getAttributes()["chunk_id"];
        $params = $request->getQueryParams();
        $data=ComparisonManager::getData($chunkId, $params);
        if ($data["chunkInfo"]!=null){
            $webInfo["comparison"]=true;
        }
        $this->view->render($response, 'view/chunkviewer.twig', ["webInfo" => $webInfo, "data" => $data]);
    }

    /**
     * Wird über HTMX-Request (ajax) angesprochen und gibt die Sammlung der Daten eines bestimmten Vorkommens in Auftrag.
     * Rendert anschließend, je nach Typ, entweder einen Text- oder einen Image-Container.
     * @param Request $request
     * @param Response $response
     *
     * GET-Request "/chunks/{chunk_id}/{occurrence_id}"
     */
    function getOccurrence(Request $request, Response $response){
        $webInfo["baseurl"]=$this->baseUrl;
        $chunkId = $request->getAttributes()["chunk_id"];
        $occId = $request->getAttributes()["occurrence_id"];
        $data = ComparisonManager::getOccurrenceById($chunkId, $occId);
        if ($data[0]["type"]=="text"){
            $this->view->render($response, 'view/text-container.secondary.twig', ["webInfo" => $webInfo, "data" => $data]);
        } else {
            $this->view->render($response, 'view/map-container.secondary.twig', ["webInfo" => $webInfo, "data" => $data]);
        }

    }

    /**
     * Holt direkt Daten eines Plaintextes und rendert diese in eine Textbox
     * @param Request $request
     * @param Response $response
     *
     * GET-Request "/plaintexts/{plaintext_id}"
     */
    function getPlaintext(Request $request, Response $response){
        $plaintextId=$request->getAttributes()["plaintext_id"];
        $data=Plaintext::where("id", "=", $plaintextId)->first();
        $this->view->render($response, 'view/textbox.twig', ["data" => $data]);
    }

    /**
     * Holt direkt die Daten einer Faksimile-Seite und rendert diese in eine Image Box.
     * @param Request $request
     * @param Response $response
     *
     * GET-Request "/faksimile/{page_id}"
     */
    function getFaksimile(Request $request, Response $response){
        $webInfo["baseurl"]=$this->baseUrl;
        $pageId=$request->getAttributes()["page_id"];
        $data=FaksimilePage::where("id", "=", $pageId)
            ->first()
            ->toArray();
        $this->view->render($response, 'view/imgbox.twig', ["webInfo" => $webInfo, "data" => $data]);
    }











}
