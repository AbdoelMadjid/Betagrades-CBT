<?php
require '../includes/config.inc.php';
require MYSQLI;

extract($_GET);

$q ="SELECT class FROM students WHERE exam_no = '$matricno'";
$r = mysqli_query($dbc, $q);

// if database returns result
if (mysqli_num_rows($r) === 1) {
	$row = mysqli_fetch_array($r, MYSQLI_ASSOC);
	$theClass = $row['class'];
}else {
	echo '<span style="color: #FF0066;;text-align:center" class="center-block">* Student Data Not Found *</span>';
	exit();
}


// query get list of courses from database
$q = "SELECT c.id, title, class, count(q.id) AS num FROM courses c
INNER JOIN questions q ON c.id = q.course_id
WHERE  class = '$theClass'
AND status = 'online' GROUP BY title ORDER BY id DESC";

// querying the database
$r = mysqli_query($dbc, $q);

// if database returns result
if (mysqli_num_rows($r) > 0) {
	echo '<label for="course">Select Subject</label>';
	echo '<select name="course">';

	// display result
	while ($row = mysqli_fetch_array($r, MYSQLI_ASSOC)) {

			echo '<option value=" ' . $row['id'] . ' ">' . $row['title'] . ' - ' . $row['class']. '</option>';
		
	}
	echo '</select>';
	echo '<button class="center-block remove" id="start_exam_button" type="submit">START</button>';
}  else  { // if databse doesnt return results

	echo '<span style="color: #FF0066;;text-align:center" class="center-block">There are no subjects online now. </span>';
}

