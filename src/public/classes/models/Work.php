<?php

namespace App\models;

class Work extends BaseModel
{
    protected $fillable = [
    ];

    public function chunks()
    {
        return $this->hasMany('App\models\Chunk', "work_id", "id");
    }


    protected $table = "works";
    protected $primaryKey ="id";
    public $timestamps = false;

}