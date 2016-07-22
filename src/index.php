<?php

//Header
require_once(__DIR__.'/engineAPI/engine/engineAPI/latest/engine.php');

$engine = EngineAPI::singleton();
errorHandle::errorReporting(errorHandle::E_ALL);

// Set localVars and engineVars variables
$localvars  = localvars::getInstance();
$enginevars = enginevars::getInstance();

templates::load("library2014-backpage");


echo "This file is being executed from:\t".__DIR__.'/engineAPI/engine/engineAPI/latest/engine.php';
