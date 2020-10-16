<?php
namespace App\operations;



use App\models\Chunk;
use App\models\Document;
use App\models\Faksimile;
use App\models\StandoffProperty;
use App\models\Transcription;

class ComparisonManager
{

    public static function getData($chunkId, $params){
        error_log(print_r($params, true));
        // erhalte Informtionen über den Chunk
        $data["chunkInfo"]=Chunk::with("work")
            ->where("id", "=", $chunkId)->first()->toArray();

        if ($data["chunkInfo"]!=null){
            // wenn Info zum Chunk vorhanden ist, der Chunk existiert. Hole alle Chunks des Werkes
            $data["chunks"]=Chunk::where("work_id", "=", $data["chunkInfo"]["work"]["id"])
                ->get()
                ->toArray();
            $data["occurrences"]=self::getOccurrencesByChunkId($chunkId, $params);
            if (isset($params["occurrence"])){
                // wenn ein Vorkommen als Parameter mitgegeben wurde. Erschaffe eine Hauptreferenz
                $data["mainOccurrence"]=StandoffProperty::with("transcription_page", "faksimile_page")
                    ->where("id", "=", $params["occurrence"])
                    ->first()
                    ->toArray();
                if ($data["mainOccurrence"]!=null){
                    if ($data["mainOccurrence"]["type"]=="text"){
                        $data["mainBox"]="text";
                        $data["mainOccurrence"]=self::createTextBox($data["mainOccurrence"]);
                    } else {
                        $data["mainBox"]="faksimile";
                        $data["mainOccurrence"]=self::createImageBox($data["mainOccurrence"]);
                    }
                }
            }
        } else {
            $data = array();
        }


        return $data;
    }



    private static function getOccurrencesByChunkId($chunkId, $params){
        if (isset($params["occurrence"])){
            $mainOccurenceId=$params["occurrence"];
        } else {
            $mainOccurenceId=false;
        }
        $occurrences=array();
        $properties=StandoffProperty::with("transcription_page", "faksimile_page")
            ->where("property_name", "=", "chunk")
            ->where("property_value", "=", $chunkId)
            ->get()
            ->toArray();

        // MainOccurence mit 'aktiv'-Flag JS? oder raus PHP?
        // Gewählte mit sekundärer 'aktiv'-Flag JS? JS!
        // Merging von gleichen Dokumenten, PHP!
        $availableTranscriptions=array();
        $availableFaksimiles=array();
        for ($i=0; $i < count($properties); $i++){
            if($properties[$i]["transcription_page"]!=null){
                if (!in_array($properties[$i]["transcription_page"]["transcription_id"], $availableTranscriptions)){
                    array_push($availableTranscriptions, $properties[$i]["transcription_page"]["transcription_id"]);
                    array_push($occurrences, $properties[$i]);
                }
            }
            if($properties[$i]["faksimile_page"]!=null){
                if (!in_array($properties[$i]["faksimile_page"]["faksimile_id"], $availableFaksimiles)){
                    array_push($availableFaksimiles, $properties[$i]["faksimile_page"]["faksimile_id"]);
                    array_push($occurrences, $properties[$i]);
                }
            }
        }
        return $occurrences;

    }

    private static function createTextBox($mainOccurrence){
        $mainOccurrence=self::getOccurrencesWithinTranscription($mainOccurrence["property_value"], $mainOccurrence["transcription_page"]["transcription_id"]);

        //error_log(print_r($mainOccurrence, true));
        return $mainOccurrence;
    }

    /**
     * Es wird überprüft, ob in der gleichen Transkription weitere Seiten den gewählten Chunk besitzen.
     * Zurückgebeben wird ein Array mit allen Vorkommen eines Chunks innerhalb des gewählten Dokuments
     * @param $chunk_id
     * @param $transcription_id
     * @return array
     */
    private static function getOccurrencesWithinTranscription($chunk_id, $transcription_id){
        // Hole alle Seiten der Transkription
        $transcription=Transcription::with("pages")
            ->where("id", "=", $transcription_id)
            ->first()
            ->toArray();
        $mainOccurrences = array();
        // Iteriere über alle verfügbaren Seiten und prüfe, ob diese eine Property besitzen, die auf den gewählten Chunk verweist
        for ($i=0; $i<count($transcription["pages"]); $i++) {
            $properties = StandoffProperty::with("transcription_page_with_text", "text_property")
                ->where("property_name", "=", "chunk")
                ->where("property_value", "=", $chunk_id)
                ->where("transc_page_id", "=", $transcription["pages"][$i]["id"])
                ->get()
                ->toArray();
            // Insofern ein oder mehrere Vorkommen pro Seite sind, beschneide den Plaintext, wie die jeweilige Property es auszeichnet
            if ($properties!=null){
                foreach ($properties as $property)
                    $property["chunk_text"]=substr($property["transcription_page_with_text"]["plaintext"]["content"], $property["text_property"]["index"], $property["text_property"]["length"] );
                    array_push($mainOccurrences, $property);

            }
        }
        return $mainOccurrences;


    }

    private static function createImageBox($mainOccurrence){
        //error_log(print_r($mainOccurrence, true));
        $mainOccurrence=self::getOccurrencesWithinFaksimile($mainOccurrence["property_value"], $mainOccurrence["faksimile_page"]["faksimile_id"]);
        return $mainOccurrence;
    }
    private static function getOccurrencesWithinFaksimile($chunk_id, $faksimile_id){
        $faksimile=Faksimile::with("pages")
            ->where("id", "=", $faksimile_id)
            ->first()
            ->toArray();
        $mainOccurrences=array();
        for ($i=0; $i<count($faksimile["pages"]); $i++) {
            $properties = StandoffProperty::with( "faksimile_page", "faksimile_property")
                ->where("property_name", "=", "chunk")
                ->where("property_value", "=", $chunk_id)
                ->where("fak_page_id", "=", $faksimile["pages"][$i]["id"])
                ->get()
                ->toArray();

            if ($properties!=null){
                foreach ($properties as $property)
                $property["coordinates"]=$property;
                array_push($mainOccurrences, $property);
            }
        }
        return $mainOccurrences;
    }



}