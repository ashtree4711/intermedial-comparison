<?php


namespace App\models;


class TranscriptionPage extends BaseModel
{
    protected $fillable = [
    ];

    public function transcription()
    {
        return $this->hasOne('App\models\Transcription', "id", "transcription_id")->with("document");
    }

    public function plaintext()
    {
        return $this->hasOne('App\models\Plaintext', "id", "plaintext_id");
    }

    protected $table = "transcription_pages";
    protected $primaryKey ="id";
    public $timestamps = false;




}