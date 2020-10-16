<?php
namespace App\controllers;



use App\models\Chunk;
use App\models\Faksimile;
use App\models\FaksimilePage;
use App\models\Plaintext;
use App\models\StandoffProperty;
use App\models\TranscriptionPage;

use App\operations\ComparisonManager;
use App\operations\DocumentManager;
use App\operations\WorkManager;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

/**
 * Class SiteController
 * @package App\controllers
 */
class SiteController extends BaseController {


    /**
     * @param Request $request
     * @param Response $response
     *
     * GET-Request
     */
    function showStart(Request $request, Response $response){
        $webInfo["baseurl"]=$this->baseUrl;
        $data=array();
        //$data=TranscriptionPage::where("transcription_id", "=", 2)->first()->toArray();
        $data["properties"]=StandoffProperty::where("property_name", "=", "chunk")->where("property_value", "=", 1)->get()->toArray();
        /*for ($i=0; $i<count($data["properties"]); $i++){
            $transcription = TranscriptionPage::where("id", "=", $data["properties"][$i]["transcription_page_id"])->first()->toArray();
            $data["properties"][$i]["chunk_text"] = substr($transcription["content"],$data["properties"][$i]["start_index"], $data["properties"][$i]["length"]);

        }*/
        $data["documents"]=DocumentManager::all();

        $data["works"]=WorkManager::all();
        $this->view->render($response, 'view/start.twig', ["webInfo" => $webInfo, "data" => $data]);
    }



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

    function getPlaintext(Request $request, Response $response){
        $plaintextId=$request->getAttributes()["plaintext_id"];
        $data=Plaintext::where("id", "=", $plaintextId)->first();
        //error_log(print_r($data, true));
        $this->view->render($response, 'view/textbox.twig', ["data" => $data]);
    }

    function getFaksimile(Request $request, Response $response){
        $webInfo["baseurl"]=$this->baseUrl;
        $faksimileId=$request->getAttributes()["faksimile_id"];
        $data=FaksimilePage::where("id", "=", $faksimileId)->first();
        error_log(print_r($data, true));
        $this->view->render($response, 'view/imgbox.twig', ["webInfo" => $webInfo, "data" => $data]);
    }











}
