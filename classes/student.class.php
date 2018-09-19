<?php

class Student 
{
    protected $_name;
    protected $_exam_no;
    protected $_class;
    protected $_id;
    protected $_subject_id;

    public function __construct($dbc)
    {
        self::setExamNo();
        self::setName($dbc);
        
        self::setClass($dbc);
    }

    private function setName($dbc)
    {
        $q = "SELECT CONCAT(surname ,' ',other_name) AS name, id FROM `students` WHERE exam_no = '$this->_exam_no'";
        $r = mysqli_query($dbc, $q);
        if($r)
        {
            $row = mysqli_fetch_array($r, MYSQLI_ASSOC);
            $this->_name = $row['name'];
            $this->_id = $row['id'];
            $_SESSION['student_id'] = $this->_id;
        }
        else 
        {
            $this->_name = 'unknown';
        }
    }

    private function setClass($dbc)
    {
        $q = "SELECT class FROM students WHERE exam_no = '$this->_exam_no'";
        $r = mysqli_query($dbc, $q);
        if($r)
        {
            $row = mysqli_fetch_array($r, MYSQLI_ASSOC);
            $this->_class = $row['class'];
        }
        else 
        {
            $this->_class = 'unknown';   
        }
    }

    private function setExamNo ()
    {
        if (isset($_SESSION['matricno'])){
            $this->_exam_no = $_SESSION['matricno'];
        }
    }

    public function getName()
    {
        return $this->_name;
    }

    public function getId()
    {
        return $_SESSION['student_id'];
    }

    public function getExamNo()
    {
        return $this->_exam_no;
    }
    public function getClass()
    {
        return $this->_class;
    }

    public function isLoggedIn ()
    {
        if(isset($this->_exam_no))
        {
            return true;
        }
        else 
        {
            return false;
        }
    }
}