<?php


namespace App\models;


class Document extends BaseModel
{
    protected $fillable = [
    ];


    public function transcriptions(){
        return $this->hasMany('App\models\Transcription', "identifier", "identifier")->with("pages");
    }

    public function faksimile(){
        return $this->hasMany('App\models\Faksimile', "identifier", "identifier")->with("pages");
    }




    protected $table = "documents";
    protected $primaryKey ="id";
    public $timestamps = false;




}