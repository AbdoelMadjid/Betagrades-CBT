<?php

class Admin
{
    protected $_type;

    public function registerStudent ($dbc)
    {
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
            }else {
                $notification = 'Could not complete registration. Try again later.' .$q;
            }
        }else {
            foreach ($login_errors as $key => $value) {
                $notification .= "$value".'<br>';
            }
        }
        $_SERVER['REQUEST_METHOD'] = 'GET';
        $_GET['page'] = 'students';
    }

    public function displayMetrics($dbc)
    {
        include 'views/admin_metric.html';
    }

    public function checkCsrf($stored, $returned)
    {
        if ($stored !== $returned) 
        { 
            // Generate a different sess ID
            session_regenerate_id(true);
            // Remove previous session state data
            session_destroy();
            // redirect to error page
            //header("Location: admin.php");
            echo 'wrong nonce';
            exit();
	    }
    }
}