<?php

namespace App\models;

class Faksimile extends BaseModel
{
    protected $fillable = [
    ];

    public function pages(){
        return $this->hasMany('App\models\FaksimilePage', "faksimile_id", "id");
    }

    public function document()
    {
        return $this->hasOne('App\models\Document', "identifier", "identifier");
    }

    protected $table = "faksimile";
    protected $primaryKey ="id";
    public $timestamps = false;
}