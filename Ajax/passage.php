<?php
require '../includes/config.inc.php';
require MYSQLI ;
// adding passage to a course
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	extract($_POST);
	$content = escape_data($content, $dbc);
	$title = escape_data($title, $dbc);
	$q = "INSERT INTO passage ( lecturer_id, course_id, title, content) VALUES 
	( $lecturer_id, $course_id, '$title', '$content')";
	$r = mysqli_query($dbc, $q);
	if ($r){
		echo 'Passage Successfully added.';
	}else {
		echo 'Could not add passage. Please try again.';
	}
	exit();
}