<?php
namespace App\operations;
use App\models\StandoffProperty;
use App\models\Work;

class WorkManager
{
    /**
     * @return array|mixed
     */
    public static function all(){
        $works=Work::with("chunks")->get()->toArray();
        $works=self::getChunkProperties($works);
        return $works;
    }

    /**
     * @param $works
     * @return mixed
     */
    private static function getChunkProperties($works){
        for ($i=0; $i < count($works); $i++){
            for ($j=0; $j < count($works[$i]["chunks"]); $j++){
                $works[$i]["chunks"][$j]["occurrences"]=StandoffProperty::with("transcription_page", "faksimile_page")->where("property_name", "=", "chunk")
                    ->where("property_value", "=", $works[$i]["chunks"][$j]["id"])
                    ->get()
                    ->toArray();
            }
        }
        return $works;
    }

}