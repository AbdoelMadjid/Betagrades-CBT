<?php
 


require '../includes/config.inc.php';
require MYSQLI ;
 
function getHostAddress2(){ 
	return $_SERVER['SERVER_NAME'] === "localhost" ? "http://localhost/cbt" : "https://".$_SERVER['SERVER_NAME'];

}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	$course_id = $_POST['course_id'];

	if (is_uploaded_file($_FILES['upload']['tmp_name']) && ($_FILES['upload']['error'] === UPLOAD_ERR_OK)) {
		$errors = array();
		$file_name = $_FILES['upload']['name'];
		$file_size = $_FILES['upload']['size'];
		$file_tmp = $_FILES['upload']['tmp_name'];
		$file_type = $_FILES['upload']['type'];

		// explode file name delimited by fullstop,
		// and extract the file extension
		$file_ext = strtolower(end(explode('.',$_FILES['upload']['name'])));

		// declare accepted file extensions
		$extensions = array("jpg", "jpeg", "png");

		// check if file extension matches accepted extensions
		if (!in_array($file_ext, $extensions)) {

			$errors[] = "Extension not allowed";
		}

		// if file size is larger than 2MB,
		// declare and error
		if ($file_size > 2097152) {

			$errors[] = "File size exceeded 2MB";
		}

		// if there are no errors,
		// move uploaded files
		if (empty($errors)) {
			http_response_code(201);

			// Create a tmp_name for the file:
			//$tmp_name = sha1($_FILES['img']['name']) . uniqid('',true);
			$tmp_name = $_FILES['upload']['name'];

			// Move the file to its proper folder but add _tmp, just in case:
			//$dest =  IMGS_DIR . $tmp_name . '.'.$file_ext;
			$dest =  EDITOR_IMAGE_DIR . "/$tmp_name";

			if (move_uploaded_file($file_tmp, $dest)){
				
				// set file name into a session variable
				// to be used during upload to DB
				$_SESSION['excel_file_name'] = $tmp_name;
				$_SESSION['excel_course_id'] = $course_id;
				//echo 'File successfully uploaded '. $tmp_name ;

				//$res = "<script>window.parent.CKEDITOR.tools.callFunction(" .$funcNum.  "," . $url . "," .$message. ")</script>"

				//return response()->json(['data' => $res]);

				$url = getHostAddress2()."/editor-images";

				$json = [
					"uploaded" => 1,
					"fileName" => "$tmp_name",
					"url" => "{$url}/{$tmp_name}"
				];
				header('Content-Type: application/json');
				echo json_encode($json);
				
				// redirect to index.php where the file will
				// be extracted into the DB
				//header('location: http://localhost/ElectronicExam/import-excel-file-in-database/question_to_db.php');

				// file has been successfully uploaded
				// we will now deconstruct the Excel file
				// and save the content to the database

			 //$file_open=fopen("$dest","r");
			 //$file_n = $_FILES['file']['tmp_name'];
			 /*$handle = fopen("../upload/".$tmp_name, "r");
			 $c = 0;
			 $course_id = 1;
			 while(($filesop = fgetupload($handle, 1000, ",")) !== false)
			 {

			 $question = $filesop[0];
			 $option1 = $filesop[1];
			 $option2 = $filesop[2];
			 $option3 = $filesop[3];
			 $option4 = $filesop[4];
			 $answer_true = $filesop[5];

			 $q = "INSERT INTO questions (course_id, question, option1, option2, option3, option4, answer_true)
			 			VALUES ('$course_id','$question', '$option1', '$option2', '$option3', '$option4', '$answer_true',)";
			 $sql = mysqli_query($dbc, $q);
			 }

			 if($sql){
			 echo "Your database has imported successfully";
			 }else{
			 echo "Sorry! There is some problem.";
			 }*/

			}else {
				echo "File couldn't be moved, please try again";
			}

		}else { // if there are errors, display them

			print_r($errors);
		}
	}else {
		echo "Error occured during upload, please try again";
	}
}
