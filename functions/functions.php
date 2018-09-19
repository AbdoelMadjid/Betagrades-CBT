<?php

function check_if_exam_taken($dbc, $student_id, $course){
		// checking if user already wrote exam
		// If yes, display the matric number and score
		// exit the script
		$q1 = "SELECT score FROM student_results WHERE student_id = $student_id AND course_id = $course";
		//exit($q1);
		$r1 = mysqli_query($dbc, $q1);
		if (mysqli_num_rows($r1) > 0 ) {
			$row1 = mysqli_fetch_array($r1, MYSQLI_ASSOC);
			//unset($_SESSION['matricno'],$_SESSION['course_id'], $_SESSION['qn'], $_SESSION['question_id'] );
			
			//session_destroy();
			
			//session_regenerate_id();
			//include 'views/already_taken_exam.html';
			return true;
			exit();
		}
}

function clear_session_and_data($url = 'home') {
	session_regenerate_id();
	session_destroy();
	header("Location: $url");
	exit(); // Quit the script.
}
function check_manager_registered($dbc) {
	//check if manger has registered, else prompt and exit
	$q = "SELECT id FROM admin WHERE type = 'manager'";
	$r = mysqli_query($dbc, $q);
	if (!(mysqli_num_rows($r) === 1)){
		include 'views/register_manager.html';
		exit();
	}

	// if its greater than 1, delete all occurences
}

function check_school_registered ($dbc){
	// check if a school is registered on the system
	//check if manger has registered, else prompt and exit
	$q = "SELECT * FROM school";
	$r = mysqli_query($dbc, $q);
	if (!(mysqli_num_rows($r) === 1)){
		include 'register_school.html';
		exit();
	}
}

function insert_school_logo ($width = "200", $height = "200", $dbc) {
	$q6 = "SELECT logo FROM school";
	$r6 = mysqli_query($dbc, $q6);
	if ($r6) {
		$row = mysqli_fetch_array($r6, MYSQLI_ASSOC);
		$logo = $row["logo"];
		$image = '<img class="center-block" width="'.$width.'" height="'.$height.'" src="images/'.$logo.'" />';
		return $image;
	}else {
		$error = 'Could not fetch School image'. $width;
		return $error;
	}
	
}

function update_answer($answer ='', $matricno = '', $question_id = 0, $dbc) {
				// if question has been answered
				// update the question in the database and not save as a new answer
				
				$q2 = 'UPDATE student_answers SET answer_selected = \''.$answer.'\' WHERE matric_no = \''.$matricno.'\' AND question_id = '.$question_id.'';
				mysqli_query($dbc, $q2) or die($q2);
				$_SESSION['question_already_answered'] = false;
				unset($_SESSION['question_already_answered']);	
}

//function insert_answer($session_id, $matricno, $course_id, $question_id, $question , $option1 , $option2, $option3, $option4, $answer , $answer_true, $image_name, $instruction_id,  $dbc){		
function insert_answer($session_id, $matricno, $course_id,  $answer, $question_id, $dbc){		
			// question has not been answered
			// save to DB as new entry
			
			$q2 = "INSERT INTO student_answers SELECT '$session_id', '$matricno', $course_id, id, question, option1,option2,option3,option4,'$answer',answer_true, image_name, instruction_id, passage_id 
			FROM questions WHERE id = $question_id";
			mysqli_query($dbc, $q2)  or die($q2);
			$_SESSION['row_of_que_already_answered'][$_SESSION['qn']+1] = 'answered';
			$the__que_to_cookie = serialize($_SESSION['row_of_que_already_answered']);
			setcookie("the__que_to_cookie", $the__que_to_cookie, time()+(60*60*24*1));
}

function encrypt ($plaintext, $key){
    # --- ENCRYPTION ---


    
    # show key size use either 16, 24 or 32 byte keys for AES-128, 192
    # and 256 respectively
    $key_size =  strlen($key);
    // echo "Key size: " . $key_size . "<br/>";
    
   // $plaintext = "This string was AES-256 / CBC / ZeroBytePadding encrypted.";

    # create a random IV to use with CBC encoding
    $iv_size = mcrypt_get_iv_size(MCRYPT_RIJNDAEL_128, MCRYPT_MODE_CBC);
    $iv = mcrypt_create_iv($iv_size, MCRYPT_RAND);
    
    # creates a cipher text compatible with AES (Rijndael block size = 128)
    # to keep the text confidential 
    # only suitable for encoded input that never ends with value 00h
    # (because of default zero padding)
    $ciphertext = mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $key,
                                 $plaintext, MCRYPT_MODE_CBC, $iv);

    # prepend the IV for it to be available for decryption
    $ciphertext = $iv . $ciphertext;
    
    # encode the resulting cipher text so it can be represented by a string
    $ciphertext_base64 = base64_encode($ciphertext);

    //echo  $ciphertext_base64 . "<br/>";
	return $ciphertext_base64;
}

function decrypt ($ciphertext_base64, $key){
	
	# === WARNING ===

    # Resulting cipher text has no integrity or authenticity added
    # and is not protected against padding oracle attacks.
    
    # --- DECRYPTION ---
	    # create a random IV to use with CBC encoding
    $iv_size = mcrypt_get_iv_size(MCRYPT_RIJNDAEL_128, MCRYPT_MODE_CBC);
    $iv = mcrypt_create_iv($iv_size, MCRYPT_RAND);
    
    $ciphertext_dec = base64_decode($ciphertext_base64);
    
    # retrieves the IV, iv_size should be created using mcrypt_get_iv_size()
    $iv_dec = substr($ciphertext_dec, 0, $iv_size);
    
    # retrieves the cipher text (everything except the $iv_size in the front)
    $ciphertext_dec = substr($ciphertext_dec, $iv_size);

    # may remove 00h valued characters from end of plain text
    $plaintext_dec = mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $key,
                                    $ciphertext_dec, MCRYPT_MODE_CBC, $iv_dec);
    
    //echo  $plaintext_dec . "<br/>";
	//return utf8_decode($plaintext_dec);
	return $plaintext_dec;
}