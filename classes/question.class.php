<?php
class Question 
{
    public $question;
    public $_id;
    public $current;
    public $instruction_id;
    public $passage_id;
    public $answer_selected = NULL;

    public $option1;    
    public $option2;
    public $option3;    
    public $option4;

    function __construct ()
    {
    }

    private function setCurrentQuestion()
    {
        $this->current = $_SESSION ['qn'];
    }

    // set current question to the first question
    function initialize()
    {
        $_SESSION ['qn'] = 0;
        setcookie("qn", $_SESSION['qn'], time()+(60*60*24*1));
    }

    // if user clicks the previous question button
    // decrease current question value by 1
    function decrement()
    {
        $_SESSION['qn'] = $_SESSION['qn'] - 1 ;
        setcookie("qn", $_SESSION['qn'], time()+(60*60*24*1));
    }
    
    // if user clicks the next question button
    // increase current question value by 1
    function increment()
    {
        $_SESSION['qn'] = $_SESSION['qn'] + 1 ;
        setcookie("qn", $_SESSION['qn'], time()+(60*60*24*1));
    }

    function gotoQuestion($go_to_question)
    {       
		$_SESSION['qn'] = ($go_to_question-1);
		setcookie("qn", $_SESSION['qn'], time()+(60*60*24*1));
    }

    function getCurrentQuestion()
    {
        self::setCurrentQuestion();
        return $this->current;
    }

    function getQuestions($dbc, Subject $subject, Student $student)
    {
        $q = "SELECT * FROM questions WHERE course_id = " . $subject->getId();

        // make query
        $r = mysqli_query($dbc, $q);

        // the questions_row array contains the numbers
        // of randomly generated questions from a pool
        // of questions relating to the course
        $questions_row = array();
        $questions_row = $_SESSION['generated_questions'];

        // pick a question in results based on the current question number
        // The question row number will be based on the value
        // of the current question number
        // i.e the third question to be asked = the 8th question in DB
        $ques_row = $questions_row[self::getCurrentQuestion()];
        mysqli_data_seek($r, $ques_row);

        // retrieving the current question
        $row = mysqli_fetch_array($r, MYSQLI_ASSOC);
        $_SESSION['question_id'] = $row['id'];

        $this->_id = $_SESSION['question_id'];

        if ($this->alreadyAnswered($dbc, $student))
        {
            $theQ = "SELECT * FROM student_answers WHERE question_id = $this->_id AND student_id = '".$student->getId(). "'";
            $theR = mysqli_query($dbc, $theQ);

            // retrieving already answered question
            $theRow = mysqli_fetch_array($theR, MYSQLI_ASSOC);
            
            // fetch result from answeres table
            $Question = $theRow;
            $this->answer_selected = $theRow['answer_selected'];           
        }
        else 
        {
            // fetch result from questions table
            $Question = $row;
        } 

        $this->question = $Question['question'];
        $this->instruction_id =  $Question['instruction_id'] ;
        $this->passage_id = $Question['passage_id'] ;
        $this->option1 = $Question['option1'] ;
        $this->option2 = $Question['option2'] ;
        $this->option3 = $Question['option3'] ;
        $this->option4 = $Question['option4'] ;
        $this->image = $Question['image_name'] ;
        
    }

    function excedeLimit(Subject $subject)
    {        
        if ( $this->current > ($subject->getNumberOfQuestionsToAnswer() - 1) )
        {
            return true;
        }
    }

    function alreadyAnswered($dbc, Student $student)
    {
        if (!isset($this->_id))
        {
            $this->_id = $_SESSION['question_id'];
        }
        // checking if question already answered
        // if yes, we retrieve already answered question for update
        $theQ = "SELECT question FROM student_answers WHERE question_id = $this->_id AND student_id ='" . $student->getId()."'";
 //echo $theQ;
        $theR = mysqli_query($dbc, $theQ);
        if (mysqli_num_rows($theR) === 1) 
        { // question has already been answered
            return true;
        } 
        else 
        {
            return false;
        }
    }

}