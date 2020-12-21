<?php
namespace App\models;
class FaksimilePage extends BaseModel
{
    protected $fillable = [
    ];

    public function faksimile()
    {
        return $this->hasOne('App\models\Faksimile', "id", "faksimile_id")->with("document");
    }

    protected $table = "faksimile_pages";
    protected $primaryKey ="id";
    public $timestamps = false;
}

