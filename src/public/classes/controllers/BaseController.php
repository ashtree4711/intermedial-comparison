<?php

namespace App\controllers;


class BaseController {

    protected $ci;
    protected $view;

    function __construct($ci)
    {
        $this->ci=$ci;
        $this->view=$ci['view'];
        $this->baseUrl=$ci["baseurl"];
    }

}