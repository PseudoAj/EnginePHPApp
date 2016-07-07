<?php

require_once '/home/engineAPP/phpincludes/engine/engineAPI/latest/engine.php';

$engine = EngineAPI::singleton();
errorHandle::errorReporting(errorHandle::E_ALL);

// Set localVars and engineVars variables
$localvars  = localvars::getInstance();
$enginevars = enginevars::getInstance();
