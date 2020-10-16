<?php
namespace App\operations;



use App\models\Chunk;
use App\models\Document;
use App\models\StandoffProperty;

class DocumentManager
{

    public static function all(){
        $documents=Document::with("transcriptions", "faksimile")->get()->toArray();

        //$documents=self::getChunks($documents);

        return $documents;
    }

    private static function getChunks($documents){
        for ($i=0; $i < count($documents); $i++){
            for ($j=0; $j < count($documents[$i]["transcriptions"][0]["pages"]); $j++){
                $documents[$i]["transcriptions"][0]["pages"][$j]["chunks"]=StandoffProperty::where("property_name", "=", "chunk")
                    ->where("transcription_page_id", "=", $documents[$i]["transcriptions"][0]["pages"][$j]["id"])
                    ->get()
                    ->toArray();
                for ($k=0; $k < count($documents[$i]["transcriptions"][0]["pages"][$j]["chunks"]); $k++){
                    error_log($documents[$i]["transcriptions"][0]["pages"][$j]["chunks"][$k]["property_value"]);
                    $documents[$i]["transcriptions"][0]["pages"][$j]["chunks"][$k]["chunk-data"]=Chunk::where("id", "=", $documents[$i]["transcriptions"][0]["pages"][$j]["chunks"][$k]["property_value"])
                        ->with("work")
                        ->get()
                        ->toArray();
                }

                error_log(print_r($documents[$i]["transcriptions"][0]["pages"][$j]["chunks"], true));
                }
            }
        return $documents;
        }

}