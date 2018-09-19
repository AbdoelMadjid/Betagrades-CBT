<?php
require '../includes/config.inc.php';
require MYSQLI ;
require '../functions/functions.php';
/*
This script is use to upload any Excel file into database.
Here, you can browse your Excel file and upload it into
your database.
*/
?>

<?php

set_include_path(get_include_path() . PATH_SEPARATOR . 'Classes/');
include 'Classes/PHPExcel/IOFactory.php';

// This is the file path to be uploaded.
session_start();

// get file name from $_SESSION variable
// from upload_image.php
$inputFileName = $_SESSION['excel_file_name'];
$course_id = $_SESSION['excel_course_id'];

try {
	$objPHPExcel = PHPExcel_IOFactory::load($inputFileName);
} catch(Exception $e) {
	die('Error loading file "'.pathinfo($inputFileName,PATHINFO_BASENAME).'": '.$e->getMessage());
}


$allDataInSheet = $objPHPExcel->getActiveSheet()->toArray(null,true,true,true);
$arrayCount = count($allDataInSheet);  // Here get total count of row in that Excel sheet


for($i=2;$i<=$arrayCount;$i++){
	
	$question = trim($allDataInSheet[$i]["A"]);
	$op1 = trim($allDataInSheet[$i]["B"]);
	$op2 = trim($allDataInSheet[$i]["C"]);
	$op3 = trim($allDataInSheet[$i]["D"]);
	$op4 = trim($allDataInSheet[$i]["E"]);
	
	# the key should be random binary, use scrypt, bcrypt or PBKDF2 to
	# convert a string into a key
	# key is specified using hexadecimal
	$key = pack('H*', "bcb04b7e103a0cd8b54763051cef08bc55abe029fdebae5e1d417e2ffb2a00a3");

	$question = encrypt($question, $key);
	$op1 = encrypt($op1, $key);
	$op2 = encrypt($op2, $key);
	$op3 = encrypt($op3, $key);
	$op4 = encrypt($op4, $key);
		
	$answer_true = $op4;
	
	$ques = array($op1,$op2,$op3,$op4);
	shuffle($ques);
	list($op1, $op2, $op3, $op4) = $ques;
	
	$q = "INSERT INTO questions (course_id, question, option1, option2, option3, option4, answer_true)
			VALUES ('$course_id','$question', '$op1', '$op2', '$op3', '$op4', '$answer_true')";
	$r = mysqli_query($dbc, $q);
	if ($r) {
		$msg = 'Questions successfully uploaded';
	}else {
		$msg =  'Something went wrong. Please try again.';
	}
}
echo "<span>".$msg."</span>";

?>
