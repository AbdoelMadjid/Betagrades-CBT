<?php
class User 
{
    protected $_type;

    function __construct()
    {

    }

    function setType($type)
    {
        $_SESSION['user'] = $type;
    }

    function getType()
    {
        return $_SESSION['user'];
    }

    function setName($name)
    {
        $_SESSION['admin_name'] = $name;
    }

    function getName()
    {
        return $_SESSION['admin_name'];
    }

    function setId($id)
    {
        $_SESSION['admin_id'] = $id;
    }

    function getId()
    {
        return $_SESSION['admin_id'];
    }

    function setUsername($username)
    {
        $_SESSION['username'] = $username;
    }

    function getUsername ()
    {
        return $_SESSION['username'];
    }

    function isLoggedIn()
    {
        if (isset($_SESSION['user']))
        {
            return true;
        }
        else
        {
            return false;    
        }
    }

    function isTeacher()
    {
        if (isset($_SESSION['user']) && $_SESSION['user']==='Teacher')
        {
            return true;
        }
        else
        {
            return false;    
        }       
    }

    function isAdmin()
    {
        if (isset($_SESSION['user']) && $_SESSION['user']==='Admin')
        {
            return true;
        }
        else
        {
            return false;    
        }       
    }

    function isManager()
    {
        if (isset($_SESSION['user']) && $_SESSION['user']==='Manager')
        {
            return true;
        }
        else
        {
            return false;    
        }       
    }

    function logout ()
    {
        unset($_SESSION['username'],$_SESSION['admin_id'], $_SESSION['user'] );
        session_regenerate_id();
        session_destroy();
    }
}