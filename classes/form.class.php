<?php

class Form
{
    protected $_answer;
    protected $_action;
    protected $_goto;

    public function __construct ($dbc)
    {
        extract($_POST);

        if (isset($submit) && self::validate($submit, $dbc))
        {
            $this->_action = $submit;
        }
        elseif (isset($go_to_question) && self::validate($go_to_question, $dbc))
        {
            // set the value of the question the student 
            // wants to jump to
            self::setGotoQuestion($go_to_question);

            // tell PHP the student is trying to jump to a
            // particular question
            $this->_action = 'go_to_question';
        }

        if (isset($answer) && self::validate($answer, $dbc))
        {
            $this->_answer = $answer;
        }

    }

    private function setGotoQuestion ($go_to_question)
    {
        $this->_goto = $go_to_question;
    }

    // validate form parameters 
    private function validate($parameter, $dbc)
    {
        if (!empty($parameter))
        {
            $parameter = self::escape_data($parameter, $dbc);
            return true;
        }
        else 
        {
            return false;
        }
        
    }

    private function escape_data($data, $dbc)
    {
        if (get_magic_quotes_gpc()) {
            $data = stripslashes($data);
        }
        //$data = addslashes($data);
        return mysqli_real_escape_string ($dbc, trim ($data));
    }

    public function getAnswer()
    {
        return $this->_answer;
    }

    public function getAction()
    {
        return $this->_action;
    }

    // get the value of the question the student wants 
    // to jump to
    public function getGotoQuestion ()
    {
        return $this->_goto;
    }
    
}