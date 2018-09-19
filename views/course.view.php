<!-- HTML for CONTENT -->
<div id="contentWrapper" class="container-fluid">

<!-- HTML for LOG IN --><div class="row">

<div id="CourseWrapper" class="col-lg-6 col-xs-offset-2">
<?php echo $notification ; ?>
<?php
$q= "SELECT * FROM courses WHERE id = $course_id";
$r = mysqli_query($dbc, $q);
if ($r) {
	$row = mysqli_fetch_array($r, MYSQLI_ASSOC);
	$course_code = $row['course_code'];
	$course_title = $row['title'];
}
echo '<h3>' . $course_code . ' : ' .$course_title . '</h3>';
?>
<p id="addQuestion">Add Question</p>
<form class="col-lg-12" action="course.php" method="post">
<label>Question : </label><textarea name="question"><?php echo $_POST['question'];?></textarea>
<p><?php echo $login_errors['question'] ; ?></p>
<label>Option1 : </label>
<input name="op1" type="text" <?php echo 'value="'.$_POST['op1'].'"'  ;?> />
<p><?php echo $login_errors['op1'] ; ?></p>
<label>Option2: </label><input name="op2" type="text" <?php echo 'value="'.$_POST['op2'].'"' ;?> />
<p><?php echo $login_errors['op2'] ; ?></p>
<label>Option3 : </label><input name="op3" type="text" <?php echo 'value="'.$_POST['op3'].'"'  ;?> />
<p><?php echo $login_errors['op3'] ; ?></p>
<label>Correct Answer : </label><input name="ans" type="text" <?php echo 'value="'.$_POST['ans'].'"'  ;?> />
<p><?php echo $login_errors['ans'] ; ?></p>
<button type="submit">Add Qusetion</button>

</form>

<div id="downloads">
<?php echo '<a href="course.php?id='.$course_id.'&action=get_course_results&type=xls">download Course Result (XLS)</a>'; ?>
<br/>
<?php echo '<a href="course.php?id='.$course_id.'&action=get_course_results&type=csv">download Course Result (CSV)</a>'; ?>
<br/>
<?php echo '<a href="course.php?id='.$course_id.'&action=get_course_results&type=pdf">download Course Result (PDF)</a>'; ?>
</div>
</div>

<div id="CourseWrapper" class="col-lg-3">
<?php
echo '<a href="course.php?id='.$course_id.'&action=delete">Delete Course</a>';

$q = "SELECT status FROM courses WHERE id = $course_id";
$r = mysqli_query($dbc, $q);
$row = mysqli_fetch_array($r, MYSQLI_ASSOC);
$course_status = $row['status'];
if ($course_status === 'offline') {
	$take_course = 'online';
}else {
	$take_course = 'offline';
}
echo '<a href="course.php?id='.$course_id.'&take_course='.$take_course.'" style="margin-top:10px" type="button">Take Course '.$take_course.'</a>';

// querying the database for the total number
// of questions available for selected course
// $num_of_questions = number_of_course_question($course);
$q = "SELECT count(*) AS num_of_questions FROM questions WHERE course_id = $course_id";
$q = "SELECT count(*) AS num_of_questions, IFNULL( questions_to_answer, count(*)) AS questions_to_answer FROM questions q INNER JOIN courses c ON q.course_id = c.id WHERE course_id = $course_id";
$r = mysqli_query($dbc, $q);
if ($r){
	$row = mysqli_fetch_array($r, MYSQLI_ASSOC);
	extract($row);
}

echo '<br>There are <strong>'. $num_of_questions . '</strong> questions available for this course. And <strong>' .$questions_to_answer. '</strong> to be answered.';
?>
<br/><br/>
<form method="get" action="course.php">
	<p>Select the number of questions to ask students: </p>
	<p>The system automatically assumes all. </p>
	<input name="id" hidden="hidden" value="<?php echo $course_id ;?>"/>
	<input name="action" hidden="hidden" value="questions_to_be_answered"/>
	<input style="width:45px" name="num_of_q" type="text"/> <span>  out of <?php echo '<strong>'. $num_of_questions . '</strong>'  ?> questions.</span>
	<button type="submit"> GO! </button>
</form>

<!-- Upload question form goes here -->
<form id="upload_img_form" style="display:block; margin-top:20px" action="upload_image.php" method="post" enctype="multipart/form-data">
	<p>Click to upload a csv copy of the questions and answers: </p>
<?php  	if ($reg_errors['image']){
		echo $reg_errors['image'];
	}
?>
<input type="file" name="csv" id="csv"/>
<input name="course_id" type="number" value="<?php echo $course_id; ?>" hidden="hidden"/>
<p id="feedback">
if (isset($_SESSION['csv_name'])) {<?php /*

	 echo '<img height="100" width="100"  src="images/'. $_SESSION['img_name'].'"/>' ;
}*/
?>
</p>
<button type="submit">Upload</button>
</form>

<script src="jquery.js"></script>
<script src="bootstrap.min.js"></script>
<script>
$(function(){

	$('#upload_img_form').on('submit', function(e) {
		e.preventDefault();

		$.ajax({

			url: "upload_image.php",
			type: "POST",
			data: new FormData(this),
			contentType: false,
			processData:false,
			success: function(data){
				$('#upload_img_form #feedback').html(data);
				//$('#upload_img_form #feedback').fadeOut(5000);
				//$('#upload_img_form #feedback').html('<img width="100" height="100" id="rtv" src=""/>').fadeIn(400);
				//$('#rtv').attr('src', data);
			}
		});

	});
});
</script>

</div>
</div>
</div>
