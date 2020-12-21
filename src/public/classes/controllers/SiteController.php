<?php
namespace App\controllers;
use App\models\FaksimilePage;
use App\models\Plaintext;
use App\models\StandoffProperty;
use App\models\StandoffPropertyText;
use App\models\Work;
use App\operations\ComparisonManager;
use App\operations\DocumentManager;
use App\operations\TranscManager;
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
        $data["documents"]=DocumentManager::all();
        $data["works"]=WorkManager::all();
        $this->view->render($response, 'view/start.twig', ["webInfo" => $webInfo, "data" => $data]);
    }

    /**
     * Liest Attribute und Parameter aus (Chunk-Id, optional: Occurrence-Id). Gibt Sammlung der Daten in Auftrag
     * und rendet den Einstieg in das Vergleichstool
     * @param Request $request
     * @param Response $response
     *
     * GET-Request "/works/{work_id}/chunks/{chunk_no}?occurrence={occurrence_id}"
     */
    function showComparison(Request $request, Response $response){
        $webInfo["baseurl"]=$this->baseUrl;
        $chunkNo = $request->getAttributes()["chunk_no"];
        $workId = $request->getAttributes()["work_id"];
        $params = $request->getQueryParams();
        $data=ComparisonManager::getData($chunkNo, $workId, $params);
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
        error_log(print_r($data, true));
        if (isset($data[0][0]["type"])){
            if ($data[0][0]["type"]=="text"){
                $this->view->render($response, 'view/text-container.secondary.twig', ["webInfo" => $webInfo, "data" => $data]);
            } else {
                $this->view->render($response, 'view/map-container.secondary.twig', ["webInfo" => $webInfo, "data" => $data]);
            }

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
     * Holt den rohen Text einer Seite ohne Properties. Wird für den Editor genutzt.
     * @param Request $request
     * @param Response $response
     * GET-Request "/transc/{transc_id}/edit"
     */
    function getTranscription(Request $request, Response $response){
        $webInfo["baseurl"]=$this->baseUrl;
        $transcId=$request->getAttributes()["transc_id"];
        $data["id"]=$transcId;
        $data["page"]=Plaintext::where("id", "=", $transcId)->with("transcription_page")->first();
        $data["works"]=Work::with("chunks")->get()->toArray();
        $data["properties"]=StandoffProperty::where("transc_page_id", "=", $transcId)->get();
        $data["transc"]=TranscManager::generateTranscFragmentsPerPage($transcId);
        $this->view->render($response, 'view/transc-edit.twig', ["webInfo" => $webInfo, "data" => $data]);
    }

    /**
     * Holt die Text-Fragmente mit den Style-Properties
     * @param Request $request
     * @param Response $response
     * GET-Request "'/transc/{transc_id}'"
     */
    function  getStyledTranscription(Request $request, Response $response){
        $webInfo["baseurl"]=$this->baseUrl;
        $transcId=$request->getAttributes()["transc_id"];
        $data["id"]=$transcId;
        $data["page"]=Plaintext::where("id", "=", $transcId)->with("transcription_page")->first();
        $data["transc"]=TranscManager::generateTranscFragmentsPerPage($transcId);
        $this->view->render($response, 'view/transc.twig', ["webInfo" => $webInfo, "data" => $data]);
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

    /**
     * Erstellt eine neue Eigenschaft
     * @param Request $request
     * @param Response $response
     *
     * POST-REQUEST "/transc/{transc_id}/edit"
     */
    function setTextProperty(Request $request, Response $response){
        $params=$request->getParsedBody();
        if (isset($params["index"])){

            # Erstelle neue Property, fülle diese
            $property=new StandoffProperty();
            $property->property_name=$params["property"];
            if (isset($request->getQueryParams()["value"])){
                $property->property_value=$request->getQueryParams()["value"];
            }
            $property->type="text";
            $property->transc_page_id=$request->getAttributes()["transc_id"];
            $property->save();
            # Erstelle ebenfalls die Erweiterung mit der ID der gerade angelegten Property.
            $propertyExtension = new StandoffPropertyText();
            $propertyExtension->id=$property->id;
            $propertyExtension->index=$params["index"];
            $propertyExtension->length=$params["length"];
            $propertyExtension->save();
        }

        $this->getTranscription($request, $response);
    }

    /**
     * Löscht gewählte Eigenschaft
     * @param Request $request
     * @param Response $response
     *
     * DELETE-REQUEST "/transc/{transc_id}/edit"
     */
    function deleteTextProperty(Request $request, Response $response){
        $propertyId=$request->getQueryParams()["property_id"];
        StandoffProperty::find($propertyId)->delete();
        StandoffPropertyText::find($propertyId)->delete();
        $this->getTranscription($request, $response);
    }
}
