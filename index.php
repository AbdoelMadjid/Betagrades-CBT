<?php
require 'includes/config.inc.php';
require(MYSQLI);
require 'functions/functions.php';
require_once 'classes/student.class.php';
/*$newSession = 'cl1uoa34ith4q9f2jgse0jhd44';
session_regenerate_id(true);
session_id($newSession);
session_start();
echo session_id();*/

// check_school_registered ($dbc);

//$_COOKIE['student_completed_exam'] = true;
//setcookie("student_completed_exam", true, time()+(60*60*24*1));

// grab the value of allocated time from database
$_SESSION['user_resume'] === 'false';

// check if previous student completed the exam
// if not resume student's last state
if ($_COOKIE['student_completed_exam'] === 'false') {
	/**
	Basically, this section of the code sends all information needed by exam.php to start an exam
	The only difference is they are the information of the previous student writing the exam at
	the point of hardware failure.

	There's no need for relogging in as the system takes the user to the last known point before
	the system failure.
	Users credentials along with current state and time is passed to exam.php
	**/

	// tell exam.php user is resume last session
	// grab the value of allocated time from cookie variables
	$_SESSION['user_resume'] === 'true';

	$_SESSION['time_started'] = time();

	// allocated time will be time left at the point of hardware failure
	$allocated_time = $_COOKIE['time_left'];
	$_SESSION['time_to_finish'] = time()+(60*$allocated_time);

	// grab student details from cookie
	$student_d =  explode('|', $_COOKIE['student_cookie_details']);
	$matricno = $student_d[0] ;
	$course = $student_d[1] ;
	$surname = $student_d[2] ;
	$cookie_que = array();
	$cookie_que = unserialize($_COOKIE['student_cookie_questions']);
	$_SESSION['generated_questions'] = array();
	
	// grabbing details of questions already answered
	// we will use this to display question navigation accordingly
	$_SESSION['row_of_que_already_answered'] = unserialize($_COOKIE['the__que_to_cookie']);

	// append details to session variables
	$_SESSION['course_id'] = $course ;	$_SESSION['generated_questions'] = $cookie_que;
	$_SESSION['matricno'] = $matricno ;
	$_SESSION['surname'] = $surname;

	$_SESSION['qn'] = $_COOKIE['qn'];

	// redirect user to the exam pageine the URL.
	
	header("Location: Exam");
	exit();
}

$page_title = 'HOME';
$login_errors = array();

// if student is trying to login
if ($_SERVER['REQUEST_METHOD'] === 'POST' ) {
	extract($_POST);

	// checking if data sent is valid
	if (isset($surname)&& !empty($surname)) {
		$surname = escape_data($surname, $dbc) ;
	} else {
		$login_errors['surname'] = 'Please enter a valid surname';
		echo 'Please enter a valid surname';
	}
	if (isset($matricno) && !empty($matricno)) {
		$matricno = escape_data($matricno, $dbc) ;
	} else {
		$login_errors['matricno'] = 'Please enter Examination Number appropriately';
		echo 'Please enter Examination Number appropriately';
	}
	if (isset($course)  && !empty($course)) {
		// validate if returned value is an integer
		if($course = filter_var($course, FILTER_VALIDATE_INT)){
		}else {
			$login_errors['course'] = 'there is a problem with form, please refresh page.';
			echo 'there is a problem with form, please refresh page.';
		}
		$course = escape_data($course, $dbc) ;
	} else {
		$login_errors['course'] = 'there is a problem with form, please refresh page';
		echo 'there is a problem with form, please refresh page';
	}
	
	if (empty($login_errors)) {
		// checking if student is registered on the system
		$q1 = "SELECT id FROM students WHERE exam_no = '$matricno'";
		$r1 = mysqli_query($dbc, $q1);
		if (mysqli_num_rows($r1) === 1 ) {	
			// if student is registered
			// check if student is eligible to take that particular
			// subject
			$row = mysqli_fetch_array($r1, MYSQLI_ASSOC);
			$student_id = $row['id'];
			$q2 = "SELECT surname, exam_no FROM students s
						INNER JOIN courses c ON c.class = s.class
						WHERE exam_no = '$matricno' 
						AND c.id = $course";
			$r2 = mysqli_query($dbc, $q2);
			if (mysqli_num_rows($r2) === 1 ) {	
			}else {
				$login_errors['not_registered'] = '*You are not registered to take this exam*';
				echo '*You are not registered to take this exam*';	
			}	
		}else {
			$login_errors['not_registered'] = '*Student Data not found*';	
			echo '*Student Data not found*';
		}

	}

	// if there are no errors with data sent, proceed to save in database
	if (empty($login_errors)) {

		 
		if (check_if_exam_taken($dbc, $student_id, $course)) {
			echo 'lg';exit();
		}

		// setting student info in SESSION
		$_SESSION['matricno'] = $matricno ;
		$_SESSION['course_id'] = $course ;
		$_SESSION['surname'] = $surname;

		// querying the database for the total number
		// of questions available for selected course
		// $num_of_questions = number_of_course_question($course);
		$q = "SELECT count(*) AS num_of_questions, IFNULL( questions_to_answer, count(*)) AS questions_to_answer FROM questions q INNER JOIN courses c ON q.course_id = c.id WHERE course_id = $course";
		$r = mysqli_query($dbc, $q);
		if ($r){
			$row = mysqli_fetch_array($r, MYSQLI_ASSOC);
			extract($row);
		}

		$_SESSION['generated_questions'] = array();
		$thearray = array();
		//$in = 0;
		while ( sizeof($thearray) < $questions_to_answer){ // while array lenght isnt 3
			$in = rand(0, $num_of_questions - 1);
			// if question has not already been selected, save it to the array
			if(!array_key_exists($in, $thearray)) $thearray[$in] = $in;
			//$in++;
		}
		
		$student_cookie_questions = array();
		foreach ($thearray as $key => $value){
			$_SESSION['generated_questions'][] = $value;

			// setting values to be saved in cookie in case of hardware failure
			$student_cookie_questions[] = $value;
		}

		// save generated question for the last user as a cookie
		// in case of hardware failure, last state will be resumed
		$student_cookie_details = $matricno . '|'. $course . '|' . $surname ;
		setcookie("student_cookie_details", $student_cookie_details, time()+(60*60*24*1));
		setcookie("student_cookie_questions", serialize($student_cookie_questions), time()+(60*60*24*1));
		setcookie("student_completed_exam", 'false', time()+(60*60*24*1));

		// checking if student is logged in
		// If so, take user to exam page
		if (isset($_SESSION['matricno']) && isset($_SESSION['course_id'])) {

			// unset previous user's SESSION variables
			// so the question doesnt start from where previous user ended
			unset($_SESSION['qn']);
			unset($_SESSION['question_id']);				
			//header("Location: Exam");

			// send ok to Ajax on includes/login.php
			echo 'ok';
			exit();
		}
	}
}
if ($_SERVER['REQUEST_METHOD']==='GET') include 'includes/login.html';
?>
