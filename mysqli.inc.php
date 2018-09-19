<?php
 
if ($_SERVER['SERVER_NAME'] == "localhost"){
    define('DB_HOST', 'localhost');
    define('DB_NAME', 'cbt');
    define('DB_USER', 'root');
    define('DB_PASSWORD', '');
}
else
{
    define('DB_HOST', 'localhost');
    define('DB_NAME', 'betagra1_exam');
    define('DB_USER', 'betagra1_exam_u');
    define('DB_PASSWORD', 'BetaGrades2018');
}


$dbc = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

mysqli_set_charset($dbc, 'utf8');

require_once 'license.php';