<?php

require '../includes/config.inc.php';
require MYSQLI ;
require '../functions/functions.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	extract($_POST);


	if (is_uploaded_file($_FILES['image']['tmp_name']) && ($_FILES['image']['error'] === UPLOAD_ERR_OK)) {
		$errors = array();
		$file_name = $_FILES['image']['name'];
		$file_size = $_FILES['image']['size'];
		$file_tmp = $_FILES['image']['tmp_name'];
		$file_type = $_FILES['image']['type'];

		// explode file name delimited by fullstop,
		// and extract the file extension
		$file_ext = strtolower(end(explode('.',$_FILES['image']['name'])));

		// declare accepted file extensions
		$extensions = array("jpg", "png");

		// check if file extension matches accepted extensions
		if (!in_array($file_ext, $extensions)) {

			$errors[] = "Extension not allowed";
			echo 'Extension not allowed';
		}

		// if file size is larger than 2MB,
		// declare and error
		if ($file_size > 2097152) {

			$errors[] = "File size exceeded 2MB";
			echo 'File size exceeded 2MB';
		}

		// if there are no errors,
		// move uploaded files
		if (empty($errors)) {

			// Create a tmp_name for the file:
			//$tmp_name = sha1($_FILES['img']['name']) . uniqid('',true);
			$tmp_name = $_FILES['image']['name'];

			// Move the file to its proper folder but add _tmp, just in case:
			//$dest =  IMGS_DIR . $tmp_name . '.'.$file_ext;
			$dest =  IMAGE_DIR . $tmp_name ;

			if (move_uploaded_file($file_tmp, $dest)){
				
				// set file name into a session variable
				// to be used during upload to DB
				$image_name = $tmp_name;
				echo 'Image successfully uploaded ' ;

				// file has been successfully uploaded

			}else {
				echo "Image couldn't be moved, please try again";
			}

		}else { // if there are errors, display them

			print_r($errors);
		}
	}else {
		echo "No image uploaded for this question <br/>";
	}

	
	if (!empty($questionn)) {
		$questionn = escape_data($questionn, $dbc);
	}else {
		$login_errors['questionn'] = 'Question is empty';
	}
	if (!empty($op1)) {
		$op1 = escape_data($op1, $dbc);
	}else {
		$login_errors['op1'] = 'Option 1 is empty';
	}
	if (!empty($op2)) {
		$op2 = escape_data($op2, $dbc);
	}else {
		$login_errors['op2'] = 'Option 2 is empty';
	}
	if (!empty($op3)) {
		$op3 = escape_data($op3, $dbc);
	}else {
		$login_errors['op3'] = 'Option 3 is empty';
	}	
	if (!empty($ans)) {
		$op4 = escape_data($ans, $dbc);
	}else {
		$login_errors['op4'] = 'Option 4 is empty';
	}	
	$passage_id = escape_data($passage_id, $dbc);
	if ($passage_id === '') $passage_id = 'NULL';

	if (empty($login_errors)) {

		/*$key =pack('A*', "hfcjvkh6jkbcytkurd7685h6k7d9g898");

		$question = mc_encrypt(serialize(trim($question)), $key);
		$op1 = mc_encrypt(serialize(trim($op1)), $key);
		$op2 = mc_encrypt(serialize(trim($op2)), $key);
		$op3 = mc_encrypt(serialize(trim($op3)), $key);
		$op4 = mc_encrypt(serialize(trim($op4)), $key);*/
		
		# the key should be random binary, use scrypt, bcrypt or PBKDF2 to
		# convert a string into a key
		# key is specified using hexadecimal
		$key = pack('H*', "bcb04b7e103a0cd8b54763051cef08bc55abe029fdebae5e1d417e2ffb2a00a3");

		/*$questionn = encrypt($questionn, $key);
		$op1 = encrypt($op1, $key);
		$op2 = encrypt($op2, $key);
		$op3 = encrypt($op3, $key);
		$op4 = encrypt($op4, $key);*/
		$questionn = $questionn;
		$op1 = $op1;
		$op2 = $op2;
		$op3 = $op3;
		$op4 = $op4;

		$course_id = $_SESSION['cid'] ;
		//$course_id = 1 ;

		// save the value of the right answer
		$ans = $op4;

		// we now shuffle the options
		// so they are not as arranged as the
		// lecturer inputed them
		$ques = array($op1,$op2,$op3,$op4);
		shuffle($ques);
		list($op1, $op2, $op3, $op4) = $ques;

		// we check if the user is logged in just before we save the question
		//redirect_if_not('user', 'admin.php', 'lecturer');
		
						
		$q2 = "UPDATE instructions SET instruction = '$instruction' WHERE id = $instruction_id";
		$r2 = mysqli_query($dbc, $q2);

			// saving the question in the database
			$q = "UPDATE `questions` SET
			 `question` = '$questionn', 
			 `option1` = '$op1', 
			 `option2` = '$op2', 
			 `option3` = '$op3', 
			 `option4` = '$op4', 
			`answer_true` = '$ans' 
			WHERE `questions`.`id` = $question_id";
			$r = mysqli_query($dbc, $q) ;
			if (($r)) {
					echo 'Question successfully saved.';
	
					$_POST = '';
			} else {
				echo 'Failed to saved question. Please try again.' . $q;
			}

	}else {
	echo 'Error uploading question.';
	/*print_r($_POST);
	print_r($login_errors);*/
	}
}


?>