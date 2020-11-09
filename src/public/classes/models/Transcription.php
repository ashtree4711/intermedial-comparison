<?php


namespace App\models;


class Transcription extends BaseModel
{
    protected $fillable = [
    ];

    public function pages()
    {
        return $this->hasMany('App\models\TranscriptionPage', "transcription_id", "id")->orderBy("page_number", "asc");
    }

    public function document()
    {
        return $this->hasOne('App\models\Document', "identifier", "identifier");
    }


    protected $table = "transcriptions";
    protected $primaryKey ="id";
    public $timestamps = false;




}