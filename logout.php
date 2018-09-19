<?php
require 'includes/config.inc.php';
require_once 'classes/user.class.php';
$user = new User();

$user->logout();

header("location: admin.php");
exit();