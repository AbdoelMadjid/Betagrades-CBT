<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
<link rel="stylesheet" href="/font-awesome-4.6.3/css/font-awesome.min.css" type="text/css"/>
<link rel="stylesheet" href="bootstrap.min.css" type="text/css"/>
 <link href="../jQuery-Simple-Timer-master/examples/style.css" rel="stylesheet" type="text/css" media="all">
<link rel="shortcut icon" href="/img/1471660293_users-10.png"  />
<title><?php if(isset($page_title)) echo $page_title ; ?></title>
<style type="text/css">

body {
	margin:0; padding:0;
}
header {
	box-shadow:2px 0px 5px 0px #333333; border:px solid black; height:40px; width:100%; padding: 0px 10% 0px 10%;
	background-color: #333333;
}


/** Style for header LOGO **/
header #logo {
	width:100px; border:px solid black; height:40px; float:left;
}
header #logo  h4 a{
	color:#cccccc; text-align:center; display:block; transition:0.3s;
}
header #logo  h4 a:hover{
	color:white; text-decoration:none;
}

/** Style for header MENU div **/
header #menu {
	width:60%; border:px solid black; height:40px; float:right;
}
header #menu ul{
	margin-left:-2.5em; list-style-type:none; float:right; margin-right:30px;
}
header #menu ul li{
	display:inline-block; border:px solid yellow; paddin:7px;
}
header #menu ul li a{
	 padding:7px; display:block; color:white; transition:0.3s; font-size:18px;
}
header #menu ul li a:hover {
	text-decoration: underline;
}
header #menu ul li a #arrowDownIcon{
	font-size:14px;
}


/** styles for CONTENT **/
#contentWrapper {
	margin-top:110px;
}
#contentWrapper form fieldset {
	border:1px solid #CCCCCC; padding:40px 35px; border-radiu:4px; box-shado:0px 0px 1px 0px #666666;
	border-top: 4px solid #0084B4;
}
#contentWrapper form fieldset h4, label {
	color:#0084B4;
}
#contentWrapper form fieldset p {
	color: #999999; display: block; clear: both;
}
#contentWrapper form fieldset select { clear: both; display: block; margin-bottom: 15px}
#contentWrapper form fieldset input {
	margin-bottom:15px; padding-left:20px;
}
#contentWrapper form fieldset button {
	width:100%; background-color:#0084B4; color:white; border:none; transition:0.3s;  border: 2px solid #0084B4;
}
#contentWrapper form fieldset button:hover {
	width:100%; background-color:white; color:#0084B4;
}

/** styles for QUESTIONS **/
#questionsWrapper {
	margin-top:10px;
}
#current_question {
	background-color:white; color:#666666;
}
.option_alphabeth{
	float:left; clear:left; font-weight:bold; margin-right:10px
}
/*.goto_question_button {
	background-color:#0084B4; border: 2px solid #0084B4;
	width:35px;margin-right:1px;clear:none;float:left; margin-bottom:1px

}
.goto_question_button:hover { color: #0084B4 }*/
.goto_question_button {
	background-color: #666666; border: 2px solid #666666;
	width:35px;margin-right:1px;clear:none;float:left; margin-bottom:1px

}
.goto_question_button:hover { color: #666666 }

#questionsWrapper  h3 {
	margin-bottom:20px;
}
#questionsWrapper form fieldset input {
	float:left; clear:lef; margin-right:10px;
}
#questionsWrapper form fieldset label {
	float:left; clear:right; width: 80%; color: #666666
}
#questionsWrapper form fieldset button#prev {
	float:left; clear:left;  width:200px; background-color:#0084B4; border:1px solid #0084B4;
	transition:0.3s; color:white;
}

#questionsWrapper form fieldset button#next{

	float:right;  width:200px; background-color:#0084B4; border:1px solid #0084B4; transition:0.3s;
	color:white;
}


#questionsWrapper form fieldset button#end{

	float:left;  margin-to:-35px; margin-left:330px; width:150px; background-color:#0084B4; border:1px solid #0084B4; transition:0.3s; color:white;
}


#questionsWrapper form fieldset button#end:hover, #questionsWrapper form fieldset button#next:hover, #questionsWrapper form fieldset button#prev:hover {
	background-color:white; color:#0084B4;
}

/** styles for COURSE EDIT **/
#contentWrapper form  h4, label {
	color:#0084B4; float:left; clear:left; width:120px; text-align:left;
}
#contentWrapper form  p {
	color: #999999;
}

#contentWrapper form  input, textarea {
	margin-bottom:15px;float:left; clear:right; border-radius:2px; padding:2px
}
#contentWrapper form textarea {
	height:80px; width:300px
}
#contentWrapper form  button, button {
	background-color:#990000; color:white; border:none; transition:0.3s;  border: 2px solid #990000; clear:both; float:left; padding:5px
}
#contentWrapper form  button:hover, button:hover {
	background-color:white; color:#990000;
}

/** styles for NOTIFICATION **/
#NotificationWrapper {
	margin-bottom:40px;
	padding:0 10%  0 10%;
}
#NotificationWrapper  div{
	display:inline-block;
}
#NotificationWrapper  p {
	font-size:20px;
}
#NotificationWrapper  #QueNotification {
	float:left; width:20%; border:px solid black;
}
#NotificationWrapper  #OtherNotification {
	float:right; width:50%; border:px solid black;  padding-left:70px;
}
#NotificationWrapper  #OtherNotification p {
	display:inline; margin-right:15px;
}

/** styles for FOOTER **/
footer {
	border:px solid black; height:40px; width:100%; padding: 0px 10% 0px 10%; border-top:1px solid rgba(204,204,204,1);
}
footer #copyrightWrapper {
	width:30%; border:px solid black; margin-top:5px;
}
footer p {
	color: #999999; text-align:center;
}
</style>
</head>

<body>
<div class="siteWrapper">

<!-- HTML for HEADER -->
<header>
<div id="logo"><h4><a href="index.php">HOME</a></h4></div>
<?php
if ($_SERVER['PHP_SELF'] === '/ElectronicExam/exam.php') {
}else {
?>
<div id="menu">
<ul>
<li><a href="tutorial.php">Tutorial</a></li>
<li><a href="admin.php">Admin <span id="arrowDownIcon">&or;</span></a></li>
</ul>
</div>
<?php
}
?>
</header>
