<?php


namespace App\models;


class Plaintext extends BaseModel
{
    protected $fillable = [
    ];



    protected $table = "plaintexts";
    protected $primaryKey ="id";
    public $timestamps = false;
}