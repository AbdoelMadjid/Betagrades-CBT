<?php
require '../includes/config.inc.php';
require MYSQLI ;


if ($_GET['action'] === 'delete_student') {
	$id = $_GET['id'];
	    $sql = "DELETE FROM students WHERE id = $id";
        $r = mysqli_query($dbc, $sql);
        if ( mysqli_affected_rows($dbc) === 1 )
        {      
		}
		else
		{
		}
}
if ($_GET['page'] === 'get_profile') {
	$id = $_GET['id'];
	        $sql = "SELECT * FROM students WHERE id = $id";
        $r = mysqli_query($dbc, $sql);
        if ( mysqli_num_rows($r) === 1 )
        {
			$row = mysqli_fetch_array($r, MYSQLI_ASSOC);
			
            $thejson = array('response'=>1, 'data'=>$row);       
		}
		else
		{
			$thejson = array('response'=>0, 'data'=>'Sorry! Couldnt create plate');
		}
		//print_r($row);exit();
		$json = json_encode($thejson, JSON_FORCE_OBJECT);
        return $json;
}

if ($_GET['page'] === 'list') {

	extract($_GET);
	$q = 'SELECT * FROM `students` ORDER BY `id` DESC';
	if (isset($_GET['class'])) {
		$q = "SELECT * FROM students WHERE class ='" . $class . "' ORDER BY DESC ";
	}
	if (isset($_GET['a'])) {
		$q = 'SELECT * FROM `students` ORDER BY `id` DESC LIMIT 1';
	}
	$r = mysqli_query($dbc, $q);
	$PHPArray = array();
	
	if ($r) {
		
		while ($row = mysqli_fetch_array($r, MYSQLI_ASSOC)) {
			
			$PHPArray[] = $row;
			// converting PHP Array to JSON String
			$someJSONString = json_encode($PHPArray);
	
		}
			echo $someJSONString;
			//print_r($PHPArray);
	} else {
		//echo $q;
	}
}