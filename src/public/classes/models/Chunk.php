<?php


namespace App\models;


class Chunk extends BaseModel
{
    protected $fillable = [
    ];

    public function work()
    {
        return $this->hasOne('App\models\Work', "id", "work_id");
    }



    protected $table = "chunks";
    protected $primaryKey ="id";
    public $timestamps = false;




}