<?php

class Subject 
{
    protected $_allocated_time;
    protected $_available_questions;
    protected $_available_questions_to_answer;
    protected $_id;
    protected $_title;
    protected $_class;
    protected $_term;
    
    public function __construct ($dbc) 
    {
        self::setId();
        self::setNumberOfQuestions($dbc);
        $q = 'SELECT *, IFNULL(allocated_time, 30) AS time FROM courses WHERE id ='. $this->_id;
        $r = mysqli_query($dbc, $q);
        if ($r) {
            $row = mysqli_fetch_array($r, MYSQLI_ASSOC);
            $this->_allocated_time = $row['time'];
            $this->_title =  $row['title'];
            $this->_class =  $row['class'];
            $this->_term = $row['term'];
        }
        
    }

    private function setNumberOfQuestions($dbc)
    {
        //$q = 'SELECT questions_to_answer AS numberOfQueToAnswer, count(*) AS numberOfQue FROM questions WHERE course_id ='. $this->_id;
        $q = 'SELECT count(*) AS num_of_questions, IFNULL( questions_to_answer, count(*)) AS questions_to_answer 
        FROM questions q INNER JOIN courses c ON q.course_id = c.id WHERE course_id ='. $this->_id;
        $r = mysqli_query($dbc, $q);
        if ($r)
        {
            $row = mysqli_fetch_array($r, MYSQLI_ASSOC);
            $this->_available_questions = $row['num_of_questions'];
            $this->_available_questions_to_answer = $row['questions_to_answer'];
        }
    }
    public function getNumberOfQuestions()
    {
        return $this->_available_questions;
    }
    public function getNumberOfQuestionsToAnswer()
    {
        return $this->_available_questions_to_answer;
    }

    private function setId ()
    {
        $this->_id = $_SESSION['course_id'];
    }

    public function getId ()
    {
        return $this->_id;
    }

    public function getAllocatedTime()
    {
        return $this->_allocated_time;
    }
    public function getTitle()
    {
        return $this->_title;
    }
    public function getClass()
    {
        return $this->_class;
    }
    public function getTerm()
    {
        return $this->_term;
    }
}