<?php
namespace App\operations;
use App\models\Document;

class DocumentManager
{
    /**
     * @return array|mixed
     */
    public static function all(){
        $documents=Document::with("transcriptions", "faksimile")->get()->toArray();
        return $documents;
    }
}