<?php


namespace App\models;


class StandoffProperty extends BaseModel
{
    protected $fillable = [
    ];

    public function transcription_page(){
        return $this->hasOne('App\models\TranscriptionPage', "id", "transc_page_id")->with("transcription");
    }

    public function faksimile_page(){
        return $this->hasOne('App\models\FaksimilePage', "id", "fak_page_id")->with("faksimile");
    }

    public function transcription_page_with_text(){
        return $this->hasOne('App\models\TranscriptionPage', "id", "transc_page_id")->with("transcription", "plaintext");
    }

    public function text_property(){
        return $this->hasOne('App\models\StandoffPropertyText', "id", "id");
    }

    public function faksimile_property(){
        return $this->hasOne('App\models\StandoffPropertyFaksimile', "id", "id");
    }

    protected $table = "standoff_properties";
    protected $primaryKey ="id";
    public $timestamps = false;




}