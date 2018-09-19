<?php
require '../includes/config.inc.php';
require MYSQLI ;

if ($_SERVER['REQUEST_METHOD'] === 'GET' && $_GET['action'] === 'delete') {
	$question_id = $_GET['id'];
	$q = "DELETE FROM questions WHERE id =  $question_id";
	$r = mysqli_query($dbc, $q);
	if ($r) {
		// echo 'Question with ID <strong>'. $question_id . '</strong> successfully deleted';
		$result = 'Success';
		exit();
	}else {
		//echo 'Could not delete question, Please try again later.';
		$result = 'failure';
	}
	
	$JSON = '[
							{"result":"$result"}
						]';
						echo $JSON;
}