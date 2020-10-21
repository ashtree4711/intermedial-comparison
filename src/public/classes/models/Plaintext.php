<?php


namespace App\models;


class Plaintext extends BaseModel
{
    protected $fillable = [
    ];

    public function transcription_page()
    {
        return $this->hasOne('App\models\TranscriptionPage', "id", "id")->with("transcription");
    }



    protected $table = "plaintexts";
    protected $primaryKey ="id";
    public $timestamps = false;
}