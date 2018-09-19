<?php
require 'includes/config.inc.php';
require MYSQLI ;
require 'functions/functions.php';
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
<link href="https://fonts.googleapis.com/css?family=Nunito" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Titilliu+Web:400,700,700italic,600italic,300italic,200italic,400italic,600" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/font-awesome-4.6.3/css/font-awesome.min.css" type="text/css"/>
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="shortcut icon" href="logo-footer.jpg"  />
<title>Result</title>
</head>
<body>
<div class="container">
<div class="row">
	<div class="col-lg-8 center-bloc col-xs-offset-2">
<?php
$course_id  = $_GET['id'];
$q = "SELECT title, class, term fROM courses WHERE id = $course_id";
$r = mysqli_query($dbc, $q);
$row = mysqli_fetch_array($r, MYSQLI_ASSOC);
extract($row);
echo '<h3>EXAMINATION RESULT FOR <b>'.$title.'</b> - '.$class.' ('.$term.' TERM)</h3>';
?>
<img style="margin:15px" class="center-bloc" width="180" height="50" src="export/BetaGrades_logo2.png"/>
<?php

$q = "SELECT CONCAT(surname, ' ', other_name) AS surname,  s.exam_no AS matricno, 
score fROM student_results r INNER JOIN students s ON ( r.student_id = s.id) WHERE r.course_id = $course_id";
$r = mysqli_query($dbc, $q);
if (mysqli_num_rows($r) > 0){
	echo '<table border="1">';
	echo '<tr height="40"  bgcolor="#CCCCCC">';
	echo '<td width="50" align="center"  scope="col"><b>S/N</b></td>';
	echo '<td width="300" align="center"  scope="col"><b>Surname</b></td>';
	echo '<td width="200" align="center"   scope="col"><b>Examination Number</b></td>';
	echo '<td width="200" align="center"   scope="col"><b>Score</b></td>';
	echo '</tr>';
	$SN = 1;
	while ($row = mysqli_fetch_array($r, MYSQLI_ASSOC)) {
		extract($row);		
		echo '<tr height="30">';
		echo '<td>'.$SN.'</td>';
		echo '<td>'.$surname.'</td>';
		echo '<td>'.$matricno.'</td>';
		echo '<td align="center">'.$score.'</td>';
		echo '</tr>';
		$SN++;
	}
	echo '</table>';
?>
	<br>
    <form class="download_result_form" action="admin.php" method="get">
    <input type="number" hidden="hidden" name="id" value="<?php echo $course_id;?>" />
    <input type="text" hidden="hidden" value="get_course_results" name="action" />
    <select name="type" style="padding:9px; border-radius:4px; border:1px solid #CCCCCC">
    <option value="pdf">Download Result</option>
    <option value="pdf">Download in PDF</option>
    <option value="xls">Download in Excel(XLS)</option>
    <option value="csv">Download in Excel(CSV)</option>
    </select>
    </form>
<?php
}else {
	echo 'No result for this Subject yet';
	exit();
}
?>
</div>
</div>
</div>
</body>
<script src="jquery.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script>
		$('.download_result_form select, .manager_view_questions_form select').on('change', function(e) {
			var form = $(this).parent('form');
			form.trigger('submit');

		});
</script>
