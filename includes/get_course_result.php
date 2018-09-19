<?php
//$course_id = $_GET['id'];
$file_type = $_GET['type'];
$q = "SELECT CONCAT(surname, ' ', other_name) AS surname,  matricno, 
score fROM student_results WHERE course_id = $course_id";
$q = "SELECT CONCAT(surname, ' ', other_name) AS surname,  s.exam_no AS matricno, 
score fROM student_results r INNER JOIN students s ON ( r.student_id = s.id) WHERE r.course_id = $course_id";
$r = mysqli_query($dbc, $q);
if (mysqli_num_rows($r) > 0){
	$data = array();
	$theRow = array();
	while ($row = mysqli_fetch_array($r, MYSQLI_ASSOC)) {
			$theRow["Surname"]= $row["surname"];
			$theRow["Examination Number"]= $row["matricno"];
			$theRow["Score"] = $row["score"];
			$data[] = $theRow;
	}

	function cleanData(&$str){
		// we try to escape the tab chars
		// as one or more fields to be ouput may contain tab chars
		// messing up the output
		$str = preg_replace("/\t/", "\\t", $str);
		$str = preg_replace("/\r?\n/", "\\n", $str);

		// detecting double quotes and values that contain them
		// as an uneven number of quotes in a string can confuse excel
		if(strstr($str, '"')) $str = '"' . str_replace('"', '""', $str) . '"';
	}

	// filename for download :
	$q = "SELECT title, class, term fROM courses WHERE id = $course_id";
	$r = mysqli_query($dbc, $q);
	$row = mysqli_fetch_array($r, MYSQLI_ASSOC);
	$course_title = $row['title'];
	$class = $row['class'];
	$course_term = $row['term'];

	$filename = "$course_title"."_". "$class"."_"."$course_term"."TERM_result_" . date('Ymd') . ".$file_type";

	// Sending HTTP header to trigger Excel file download
	// the browser expects a file with a given name and type
	header("Content-Disposition: attachment; filename=\"$filename\"");


	// if file type is a pdf
	// send a PDF header containing the PDF file
	if ($file_type === 'pdf'){
	header('Content-type:application/pdf');
	
	// Importing the FPDF Library
	// used to generate PDFs
	require('FPDF/fpdf.php');

	// We create a sub-class of parent class FPDF
	// This enables us to print output in HTML format
	require('FPDF/pdf.php');

	$pdf=new PDF();
	$pdf->AddPage();
	$pdf->SetFont('helvetica','',12);
	$content.=$pdf->Image('export/BetaGrades_logo2.png',75,20, 50,  20);
	$content.='<br><br><br><br><br><br><br><br><br><br><br>';
	$content .= '<br><br><u>EXAMINATION RESULT FOR <strong>'.$course_title.' - '.$class.' - '.$course_term.' TERM</strong></u><br><br>';
	$content .= '<table border="1"><tr><td width="40" height="50">S/N</td>';

	foreach ($theRow as $key => $value){
		$content .= '<td width="240" height="50" bgcolor="#CCCCCC" >'.$key.'</td>';
	}

	$content.= '</tr>';

	$sn = 1;
	foreach ($data as $row){
		$content = $content . '<tr>';
		$content .= '<td width="40" height="40">'.$sn.'</td>';
		foreach ($row as $key => $value){
			$content = $content . "<td width=\"240\" height=\"40\" bgcolo=\"#cccccc\" >". strtoupper($value). "</td>";
		}
		$content = $content . "</tr>";
		$sn++;
	}
	$content = $content . "</table><br><br>";
	$content .= 'This is the current result for '.$course_title.' - '.$class.' as at ' .date("d-m-Y"). '<br>';
	$content .= 'Which is subject to change as subsequent users take the test. <br>';
	$pdf->WriteHTML($content);
	$pdf->Output();
	exit();
	}


	// creating a CSV file format of the result
	if ($file_type === 'csv'){

	header("Content-Type: text/csv");
	//header("Content-Type: text/plain");

	// "php://output" writes directly to the page instead of a file
	$out = fopen("php://output", 'w');
	}elseif($file_type === 'xls') {
		header("Content-Type: application/vnd.ms-excel");
	}

	$flag = false;
	foreach($data as $row) {
		if(!$flag) {
			// display field/column names as first row
			if ($file_type === 'csv'){
				fputcsv($out, array_keys($row), ',', '"');
			}elseif($file_type === 'xls') {
				echo implode("\t", array_keys($row)) . "\r\n";
			}
			$flag = true;
		}
		array_walk($row, __NAMESPACE__ . '\cleanData');

		if ($file_type === 'csv'){
		fputcsv($out, array_values($row), ',', '"');
		}elseif($file_type === 'xls') {
			echo implode("\t", array_values($row)) . "\r\n";
		}
	}

	if ($file_type === 'csv') fclose($out);
	exit();
}