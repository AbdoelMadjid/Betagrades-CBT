<?php
require 'includes/config.inc.php';
require(MYSQLI);
require 'functions/functions.php';
//echo print_r($_SESSION);exit();
// Autoload classes from "classes" directory:
function class_loader($class) {
    require_once('classes/' . strtolower($class) . '.class.php');
}
spl_autoload_register('class_loader');

$student = new Student($dbc);
$question = new Question();
$subject = new Subject($dbc);
$exam = new Exam();
$form = new Form($dbc);



// redirecting student to homepage if not logged in
if (!$student->isLoggedIn())
{
	header("location: Home");
	exit();	
}


$page_title = $exam->getTitle($subject);

// get the id of the incoming question
$question_id = $_SESSION['question_id'] ;

/**
get question relating to the question_id
query the DB for the question, options and true_answer
selected answer is sent through POST
All info is then saved to the student_answers table
**/
/**
	Note: We only get selected answer from student. Options and true answer relating
	to the question is gotten from the DB. This ensures data integrity as all options 
	and true answer relating to the question is reteived from an internal soure - the DB
**/

// set the session which will hold the 
// current question default is zero
if(!isset($_SESSION['qn'])) 
{
	$question->initialize();
	$_COOKIE['the__que_to_cookie'] = '';
	
	$exam->setTimeStarted();
	$exam->setTimeToFinish($subject);
} 
else 
{ // student already started exam	
		
	if ($form->getAction() && $form->getAnswer()) 
	{
		if ($question->alreadyAnswered($dbc, $student))
		{
			$exam->updateAnswer($form->getAnswer(), $student->getId(), $question_id, $dbc);
		} 
		else 
		{
			$exam->insertAnswer(session_id(), $student->getId(), $subject->getId(),  $form->getAnswer(), $question_id, $dbc);
		}	
	}
	
	if ($form->getAction() === 'go_to_question') 
	{		
		$question->gotoQuestion($form->getGotoQuestion());
	}

	elseif ($form->getAction() === 'Prev Question') 
	{
		$question->decrement();
	}

	elseif ($form->getAction() === 'Next Question') 
	{				
		$question->increment();
	}
	
	// if action is get result
	// save the last question and compile student's result
	if ( ($form->getAction() === 'FINISH EXAM') || ($form->getAction() === 'end_exam') ) 
	{		
		$student_score = $exam->compileResult ($dbc,$student,$subject);	

		// tell server student finished exam and shouldnt attempt to
		// resume last session for the next user.			
		setcookie("student_completed_exam", 'true', time()+(60*60*24*1));

		// display result
		include 'views/end_exam.html';

		// unset session varaibles and destroy the current session
		unset($_SESSION['matricno'],$_SESSION['course_id'], $_SESSION['qn'], $_SESSION['question_id'] );
		session_destroy();
		exit();
	}
}

// check if current question value hasnt exceded the total number of questions in database
if ($question->excedeLimit($subject)) {
	// there is a problem, user should be redirected back home
	// to start afresh
	unset($_SESSION['qn']);
	session_destroy();
	header("location: Home");
	exit();
}

// if question isnt the first, display previous question option
if($question->getCurrentQuestion() !== 0 ) {
	$prev_button = true ;
}

// check if qusetion isnt the last one:
// first we determine num of question with the size of question_row array
if($question->getCurrentQuestion() < ($subject->getNumberOfQuestionsToAnswer()-1) ) {
	$button_value = 'Next Question' ;
} else { // if question is last, display Get result
	$button_value = 'FINISH EXAM' ;
}

// get time remaining for exam
$time_left = $exam->getTimeRemaining();

// get the questions
$question->getQuestions($dbc, $subject, $student);

// display questions
include 'views/exam_template.html';