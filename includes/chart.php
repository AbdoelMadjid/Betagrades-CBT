<?php
//require 'config.inc.php';
//require MYSQLI;

$data = array(
    // create whatever columns are necessary for your charts here
    'cols' => array(
        array('type' => 'string', 'label' => 'Course'),
        array('type' => 'number', 'label' => 'Student Score')
    ),
    'rows' => array()
);

if ($single_course_analytics) {
$q = 'SELECT title, score, matricno FROM courses INNER JOIN student_results ON (student_results.course_id = courses.id) WHERE course_id = $course_id';
}else {
	$q = 'SELECT title, score, matricno FROM courses INNER JOIN student_results ON (student_results.course_id = courses.id)';
}
if ($_SESSION['user'] === 'lecturer') {
	$admin_id = $_SESSION['admin_id'];
	if ($single_course_analytics) {
	$q = 'SELECT title, score, matricno FROM courses INNER JOIN student_results ON (student_results.course_id = courses.id) WHERE lecturer_id = $admin_id AND course_id = $course_id';
	} else {
		$q = 'SELECT title, score, matricno FROM courses INNER JOIN student_results ON (student_results.course_id = courses.id) WHERE lecturer_id = $admin_id';

	}
}
$r = mysqli_query($dbc, $q);
if ($r) {
	while ($results = mysqli_fetch_array($r, MYSQLI_ASSOC)){
		$data['rows'][] = array('c' => array(
			array('v' => $results['matricno']),
			array('v' => $results['score'])
		));
	}
}

?>

       <script type="text/javascript" src="http://www.google.com/jsapi"></script>
       <!--<script type="text/javascript" src="jsapi.js"></script>
       <link rel="stylesheet" href="ui+en.css">-->
        <script type="text/javascript">
            function drawChart() {
                var data = new google.visualization.DataTable(<?php echo json_encode($data, JSON_NUMERIC_CHECK); ?>);
                var chart = new google.visualization.ColumnChart(document.querySelector('#chart_div'));
                chart.draw(data, {
                    height: 600,
                    width: 800
                });
            }
            google.load('visualization', '1', {packages:['corechart'], callback: drawChart});
        </script>

        <div style="padding-top:-50px" id="chart_div"></div>
