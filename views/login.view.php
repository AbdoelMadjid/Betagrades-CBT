<!-- HTML for CONTENT -->
<div id="contentWrapper" class="container-fluid">
<div class="row">
<?php
// echo 'good!';
// print_r ($_COOKIE['generated_questions']);
?>
<!-- HTML for LOG IN -->
<?php echo $notification ; ?>
<div id="loginWrapper" class="col-lg-6 col-xs-offset-3">
<div class="form-group">
<form style="width:70%; margin-left:15%" action="<?php echo $_SERVER['PHP_SELF']?>" method="post">
<fieldset>
<h4>Login</h4>
<p>Please provide your surname and matric number below</p>

<?php
// protecting against CSRF attack
if (!array_key_exists('form_token', $_SESSION)) {
	$_SESSION['student_login_token'] = uniqid().rand(20000);
}
echo '<input type="text" hidden="hidden" name="student_login_token" value="'.$_SESSION['student_login_token'].'" />';
?>

<label>Surname</label>
<?php if (isset($login_errors['surname'])) echo $login_errors['surname'] ; ?>
<input type="text" name="surname" class="form-control" <?php echo 'value="' .$surname. '"' ; ?> placeholde="*Surname" />
<label>Matric Number</label>
<?php if (isset($login_errors['matricno'])) echo $login_errors['matricno'] ; ?>
<input type="text" name="matricno" class="form-control" <?php echo 'value="' .$matricno. '"' ; ?>  placeholde="*Matric Number" />
<label>Select Course:</label>
<?php if (isset($login_errors['course'])) echo $login_errors['course'] ; ?>
<select name="course">
<?php
// query get list of courses from database
$q = "SELECT * FROM courses WHERE status = 'online'";

// querying the database
$r = mysqli_query($dbc, $q);

// if database returns result
if (mysqli_num_rows($r) > 0) {

	// display result
	while ($row = mysqli_fetch_array($r, MYSQLI_ASSOC)) {
		echo '<option value=" ' . $row['id'] . ' ">' . $row['course_code'] . '</option>';
	}
}  else  { // if databse doesnt return results

	$notification = "There are no courses online now.";
}
?>
</select>
<button type="submit" class=" btn btn-default">START</button>
</fieldset>
</form>
</div>
</div>
