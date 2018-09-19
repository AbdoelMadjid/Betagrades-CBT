<?php

class Exam
{

    public function setTimeStarted()
    {
	    $_SESSION['time_started'] = time();
    }

    public function setTimeToFinish(Subject $subject)
    {
	    $_SESSION['time_to_finish'] = time()+(60*$subject->getAllocatedTime());
    }

    private function getTimeStarted()
    {
	    return $_SESSION['time_started'];
    }

    private function getTimeToFinish()
    {
	    return $_SESSION['time_to_finish'];
    }

    public function getTitle(Subject $subject)
    {
        return 'Exam : '. $subject->getTitle();
    }

    public function insertAnswer($session_id, $student_id, $course_id,  $answer, $question_id, $dbc)
    {
                // question has not been answered
                // save to DB as new entry

                $q = "INSERT INTO student_answers SELECT NULL, '$session_id', $course_id, id, $student_id, question, option1,option2,option3,option4,'$answer',answer_true, image_name, instruction_id, passage_id
                FROM questions WHERE id = $question_id";
                mysqli_query($dbc, $q)  or die($q);

                // set the questions already answered in a session
                $_SESSION['row_of_que_already_answered'][$_SESSION['qn']+1] = 'answered';

                // set the questions already answered in a cookie in case of power failure
                $the__que_to_cookie = serialize($_SESSION['row_of_que_already_answered']);
                setcookie("the__que_to_cookie", $the__que_to_cookie, time()+(60*60*24*1));
    }

    public function updateAnswer($answer ='', $student_id = '', $question_id = 0, $dbc)
    {
                    // if question has been answered
                    // update the question in the database and not save as a new answer

                    $q = 'UPDATE student_answers SET answer_selected = \''.$answer.'\' WHERE student_id = \''.$student_id.'\' AND question_id = '.$question_id.'';
                    mysqli_query($dbc, $q) or die($q);
    }

    public function getTimeRemaining ()
    {
        $nowtime = time();
        $time_started = $this->getTimeStarted();
        $time_to_finish = $this->getTimeToFinish();

        // time left = minutes given - time expeneded
        // time expended = current time - time strated

        $time_given = ($time_to_finish - $time_started);
        $time_expended = ($nowtime - $time_started);

        $secs = $time_given - $time_expended;
        $bit = array(
            'y' => $secs / 31556926 % 12,
            'w' => $secs / 604800 % 52,
            'd' => $secs / 86400 % 7,
            'h' => $secs / 3600 % 24,
            'm' => $secs / 60 % 60,
            's' => $secs % 60
            );

        /*foreach($bit as $k => $v)
            if($v > 0)$ret[] = $v . $k . ':';

        return join(' ', $ret);*/
        $time_left = $secs / 60 ;

        // setting cookie for time left
        // so user resumes with that time in the case of hardware failure
        // The time_left value will be the new allocated time on resumption
        setcookie("time_left", $time_left, time()+(60*60*24*1));

        return $time_left;
    }

    public function decrypt ($ciphertext_base64, $key){
return $ciphertext_base64;
        # === WARNING ===

        # Resulting cipher text has no integrity or authenticity added
        # and is not protected against padding oracle attacks.

        # --- DECRYPTION ---
            # create a random IV to use with CBC encoding
        $iv_size = mcrypt_enc_get_iv_size(MCRYPT_RIJNDAEL_128, MCRYPT_MODE_CBC);
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

    function compileResult ($dbc, Student $student, Subject $subject)
    {
        // compiling student result
		//$q = "CALL Get_Student_Result('".$student->getExamNo()."', ".$subject->getId().", @score, '".$student->getName()."')";
        $q = "CALL Get_Student_Result(".$subject->getId().", ".$student->getId().", @score)";
		$r4 = mysqli_query($dbc, $q);
		if ($r4) {
			$r5 = mysqli_query($dbc, 'SELECT @score AS `score`');
			if (mysqli_num_rows($r5) === 1){
				list($student_score) = mysqli_fetch_array($r5);
                return $student_score;
			}
		} else {
			exit('Could not compile student\'s score. Please contact the admin'. $q);
		}
    }
}
