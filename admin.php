<?php
require 'includes/config.inc.php';
require MYSQLI ;
require 'functions/functions.php';
require_once 'classes/admin.class.php';
require_once 'classes/user.class.php';
$admin = new Admin ();
$user = new User ();

// register student
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['submit'] === 'register_student')) {
	
	extract($_POST);
	
	if (preg_match('/^[a-zA-Z 0-9 ]{2,45}$/', $surname)) {
		$surname = escape_data($surname, $dbc);
	}else {
		$login_errors['surname'] = 'Please enter a valid surname.';
	}
	if (preg_match('/^[a-zA-Z  0-9]{2,35}$/', $exam_no)) {
		$exam_no = escape_data($exam_no, $dbc);
	}else {
		$login_errors['exam_no'] = 'Please enter a valid examination number';
	}
	if (preg_match('/^[a-zA-Z 0-9 ]{2,65}$/', $other_name)) {
		$other_name = escape_data($other_name, $dbc);
	}else {
		$login_errors['other_name'] = 'Please enter a valid other name.';
	}
	if (preg_match('/^[a-zA-Z  0-9]{1,5}$/', $class)) {
		$class = escape_data($class, $dbc);
	}else {
		$login_errors['class'] = 'Please select a valid class.';
	}
	
	
	if (empty($login_errors)) {
	
		$q = "INSERT INTO students (surname, other_name, exam_no, class)
				VALUES ('$surname', '$other_name', '$exam_no', '$class')";
		$r = mysqli_query($dbc, $q);
		if ($r) {
			$notification = 'Student successfully registered.';
			echo 'ok';
		}else {
			echo 'Could not complete registration. Try again later.' .$q;
		}
	}
	else 
	{
		foreach ($login_errors as $key => $value) 
		{
			$notification .= "$value".'<br>';
		}
		echo $notification;
	}
	exit();
	$_SERVER['REQUEST_METHOD'] = 'GET';
	$_GET['page'] = 'students';
}


// register school manager 
if ($_SERVER['REQUEST_METHOD'] === 'POST' && 
   ($_POST['submit'] === 'register_manager')
||($_POST['submit'] === 'create_admin')
||($_POST['submit'] === 'create_lecturer')
)
 {
	

	extract ($_POST);
	if ($submit === 'register_manager'){
		$r_type = 'manager';
	}elseif  ($submit === 'create_lecturer'){
		$r_type = 'lecturer';
	}elseif  ($submit === 'create_admin'){
		$r_type = 'admin';
	}
	
	if (preg_match('/^[a-zA-Z 0-9 ]{5,30}$/', $username)) {
		$username = escape_data($username, $dbc);
	}else {
		$login_errors['username'] = 'Please enter a valid username.';
	}
	if (preg_match('/^[a-zA-Z  0-9]{5,30}$/', $pass)) {
		$pass = escape_data($pass, $dbc);
	}else {
		$login_errors['pass'] = 'Please enter a valid password.';
	}
	if (preg_match('/^[a-zA-Z 0-9 ]{1,60}$/', $last_name)) {
		$last_name = escape_data($last_name, $dbc);
	}else {
		$login_errors['last_name'] = 'Please enter a valid last name.';
	}
	if (preg_match('/^[a-zA-Z  0-9]{1,60}$/', $first_name)) {
		$first_name = escape_data($first_name, $dbc);
	}else {
		$login_errors['first_name'] = 'Please enter a valid first name.';
	}
	
	
	if (empty($login_errors)) {
		// set user's username as password salt
		$salt = $username;
		$pass = sha1($pass.$salt);
	
		$q = "INSERT INTO admin (type, username, first_name, last_name, pass)
				VALUES ('$r_type', '$username', '$first_name', '$last_name', '$pass')";
		$r = mysqli_query($dbc, $q);
		if ($r) {
			$notification = $r_type.' successfully registered.';
		}else {
			$notification = 'Could not complete registration. Try again later.';
		}
	}else {
		foreach ($login_errors as $key => $value) {
			$notification .= "$value".'<br>';
		}
	}
	$_SERVER['REQUEST_METHOD'] = 'GET';
	$_GET['page'] = 'create_lecturer';
	
	// create ?; this specifies the type (lecturer, teacher or admin) 
	$_GET['type'] = $r_type;
	//header("Location: admin");
	
}

check_manager_registered($dbc);

//Getting the course results in different formats
// can only be accessed by the admin
if ($_SERVER['REQUEST_METHOD'] === 'GET' && $_GET['action'] === 'get_course_results' && isset($_GET['type'])) {
	//redirect_if_not("user", "admin.php", "admin");
	if (!isset($_SESSION['user'])) header("Location: admin.php");
	$course_id = $_GET['id'];
	include 'includes/get_course_result.php';
}
if ($_SERVER['REQUEST_METHOD'] === 'GET' && $_GET['action'] === 'get_course_results_student' && isset($_GET['type'])) {
	//redirect_if_not("user", "admin.php", "admin");
	//if (!isset($_SESSION['user'])) header("Location: admin.php");
	$student_id = $_GET['id'];
	include 'includes/get_course_result_student.php';
}
?>
<?php
$login_errors = array();
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $_POST['submit'] === 'login') {
	
	$admin->checkCsrf($_SESSION['admin_panel_nonce'], $_POST['nonce']);

	if (preg_match('/^[a-zA-Z 0-9 ]{5,30}$/', $_POST['username'])) {
		$username = escape_data($_POST['username'], $dbc); 
	}else {
		$login_errors['username'] = 'Please enter a valid username.';
	}
	if (preg_match('/^[a-zA-Z  0-9]{5,30}$/', $_POST['pass'])) {
		$pass = escape_data($_POST['pass'], $dbc);
	}else {
		$login_errors['pass'] = 'Please enter a valid password.';
	}

	if (empty($login_errors)) {

		$q = "SELECT *, concat(first_name, ' ', last_name) AS name FROM admin WHERE username = '$username'";
		$r = mysqli_query($dbc, $q);
		if (mysqli_num_rows($r) === 1) {
			//if ($r){
			$row = mysqli_fetch_array($r, MYSQLI_ASSOC);
			
			// setting user's username as password salt
			$salt = $username;
			$pass = sha1($pass.$salt);
			if ($row['pass'] === $pass) 
			{
				session_regenerate_id();
				$user->setUsername($row['username']);
				$user->setId($row['id']);

				if ($row['type'] === 'admin') 
				{
					$user->setType('Admin');
					$user->setName('Administrator');
				}
				elseif ($row['type'] === 'manager') 
				{
					$user->setType('Manager');
					$user->setName('Manager');					
				}
				else 
				{
					$user->setType('Teacher');
					$user->setName($row['name']);					
				}
				echo 'ok';
				// redirect user
				//if(!headers_sent()) header ("Location: admin.php");
				exit();
				
			}else {
				echo 'The username and password entered did not match any in the database.';
		   }
		}else {
				echo 'The username and password entered did not match any in the database.';
		}
	}else {
		echo $login_errors['pass'] . '<br/>' . $login_errors['username'];
	}
	exit();
}


// If user isnt logged in
// show login page
if ( ! $user->isLoggedIn() )
{
	include 'includes/login.admin.php';
	exit();
}

// GET Request to create a subject
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $_POST['submit'] === 'create_course'){
	
	// redirect if user isnt logged in as a lecturer
	// redirect_if_not("user", "admin.php", "lecturer");
	extract($_POST);
	$lecturer_id = $_SESSION['admin_id'];
	$course_title = escape_data($course_title, $dbc);
	$class = escape_data($class, $dbc);
	$term = escape_data($term, $dbc);
	$q = "INSERT INTO courses (title, class, term, lecturer_id) VALUES ('$course_title','$class', '$term', $lecturer_id)";
	$r = mysqli_query($dbc, $q);
	if ($r){
		$notification = 'Subject <strong>'. $course_title . '</strong> for <strong>'.$class.'</strong> '.$term.' Term was successfully added.';
	}else {
		$notification = 'Subject couldnt be added. Please try again.';
		
	}
	$_SESSION['new_notification'] = 'true';
	$_SESSION['notification'] = $notification;
	
	header("Location: admin.php?page=courses");
	exit();
}


if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['page']) && $_GET['page'] === 'create_lecturer' && $user->isLoggedIn() && !$user->isTeacher()) {
	// redirect if user isnt logged in as a lecturer
	// redirect_if_not("user", "admin.php", "admin");
		
	if (isset($_GET['action']) && ($_GET['action'] === 'delete_teacher')){
		$teacher_id  = $_GET['id'];
		$q = "DELETE FROM admin WHERE id =  $teacher_id";
		$r = mysqli_query($dbc, $q);
		if  (($r)) {
			$notification =  'Teacher was successfully deleted';
			header("Location: admin.php?page=create_lecturer");
			exit();
		}
	}
	
	$type=$_GET['type'];

	include 'views/header2.admin.html';
	include 'views/teachers2.admin.html';
	include 'views/footer2.admin.html';

}


elseif( $user->isLoggedIn() && $user->isManager() &&  $_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['page']) && $_GET['page'] === 'view_all_questions') 
{

	include 'views/header2.admin.html';
	include 'views/questions2.admin.html';
	include 'views/footer2.admin.html';

}

// If the User requests for the subjects page
// OR User is loggin in for the first time, select as default page
elseif (($_SERVER['REQUEST_METHOD'] === 'GET' && $user->isLoggedIn() && isset($_GET['page']) && $_GET['page'] === 'courses'  ) 
	|| ($user->isLoggedIn() && !isset($_GET['page']))) {

	include 'views/header2.admin.html';
	include 'views/subjects2.admin.html';
	include 'views/footer2.admin.html';
}


elseif ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['page']) && $_GET['page'] === 'students' && $user->isLoggedIn() && ( $user->isAdmin() || $user->isManager() ) ) 
{

	include 'views/header2.admin.html';
	include 'views/students2.admin.html';
	include 'views/footer2.admin.html';
	
} 


elseif ($user->isLoggedIn() && $_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['page']) && $_GET['page'] === 'download_results') 
{	
	include 'views/header2.admin.html';
	include 'views/results2.admin.html';
	include 'views/footer2.admin.html';
}

else
{
	// page requested not found
	// send error 404
	
	include '404.php';
	exit();
}
?>