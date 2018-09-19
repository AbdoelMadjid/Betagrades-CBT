<?php
require '../includes/config.inc.php';
require MYSQLI ;
require '../functions/functions.php';
$course_id = $_POST['course_id'] ;

$q = "SELECT status,allocated_time, IFNULL(questions_to_answer,'All') AS questions_to_answer, class, term FROM courses WHERE id = $course_id";
$r = mysqli_query($dbc, $q) or die('error');
if (mysqli_num_rows($r)===1) {
	$row = mysqli_fetch_array($r, MYSQLI_ASSOC);
	extract($row);
	echo 'Allocated time for this Subject : <strong>'.$allocated_time.'</strong> Minutes';
	echo '<span style="margin-left:25px; margin-right:25px">Number of questions to be answered for this Subject : <strong>'.$questions_to_answer.'</strong></span>';
	echo' Status: <strong>'.$status.'</strong>';
		echo '<span style="margin-left:25px; margin-right:25px">Class: <strong>' . $class. '</strong></span>';
	echo 'Term: <strong>'. $term. '</strong><br/><br/>';

}

$q = "SELECT * FROM questions WHERE course_id = $course_id";
$r = mysqli_query($dbc, $q) or die('Could not get questions');
$key = pack('H*', "bcb04b7e103a0cd8b54763051cef08bc55abe029fdebae5e1d417e2ffb2a00a3");
$num_of_available_questions = mysqli_num_rows($r);
if ($num_of_available_questions>0){
	$q2 = "SELECT title, class FROM courses WHERE id = $course_id";
	$r2 = mysqli_query($dbc, $q2);
	if ($r2) {
		$row2 = mysqli_fetch_array($r2, MYSQLI_ASSOC);
		$course_title = $row2['title'];
		$course_class = $row2['class'];
	}
echo 'There are <strong data-num="'.$num_of_available_questions.'" id="num_of_available_questions">'.$num_of_available_questions.'</strong> question(s) for <strong>'.$course_title.' - '.$course_class.'</strong><br/>';

?>
<table id="questions_table" styl="margin:0px; border-radius:4px; border-color:#999999" class="table" >
<tr height="50" bgcolo="#ccc">
<td width="50" colspan="1">ID</td>
<td width="1050" colspan="2">Question</td>
<td width="750" colspan="2"><strong>True answer</strong></td>
<td width="750" colspan="2">Wrong Option</td>
<td width="750" colspan="2">Wrong Option</td>
<td width="750" colspan="2">Wrong Option</td>
<td width="300" colspan="2">Actions</td>
</tr>
<?php
}else {
	echo '*No questions available for this subject*';
}
 if ($r) {
    while ($row = mysqli_fetch_array($r, MYSQLI_ASSOC)) {

        $question = decrypt($row['question'], $key);
        $answer_true = decrypt($row['answer_true'], $key);
        $option1 = decrypt($row['option1'], $key);
        $option2 = decrypt($row['option2'], $key);
        $option3 = decrypt($row['option3'], $key);
        $option4 = decrypt($row['option4'], $key);

        $the_questions = array();
        $the_questions[$option1] = $option1;
        $the_questions[$option2] = $option2;
        $the_questions[$option3] = $option3;
        $the_questions[$option4] = $option4;
        $cc = 1;

        echo '<tr class="row_'.$row['id'].'" align="centr" height="35" data-instruction-id="'.$row['instruction_id'].'">';
        $qI = "SELECT instruction FROM instructions WHERE id = ".$row['instruction_id'];
        $rI = mysqli_query($dbc, $qI);
        if ($rI) {
        $rowI = mysqli_fetch_array($rI, MYSQLI_ASSOC);
        echo '<input class="the_instruction_'.$row['id'].'"  value="'.$rowI['instruction'].'" type="text" hidden="hidden"/>';
        }

        echo       '<td width="50" colspan="1">'.$row['id'].'</td>';
         echo       '<td class="question_'.$row['id'].'" width="1050" colspan="2">'.$question.'</td>';
         echo      ' <td class="answer_true'.$row['id'].'" width="750" colspan="2"><b>'.$answer_true.'</b></td>';

         // do not print column thats equal to true answer - its redundant
        foreach ($the_questions as $k => $v){
                    if(!($k === $answer_true)) {
                        echo '<td class="option'.$cc.'_'.$row['id'].'" width="750" colspan="2">'.$v.'</td>';
                        $cc++;
                    }

        }
        echo        '<td width="300" colspan="2"><div style="width:60px; margin-left:5px" class="center-block">
       <!--<button style="padding:4px; margi:10px" class="green-btn action_update_question" href="" data-id="'.$row['id'].'"><span class="glyphicon glyphicon-pencil"></span></button>-->
        <button onClick="display_conf('.$row['id'].')" style="padding:4px; margi:10px" class="red-btn action_delete_question" href="" data-id="'.$row['id'].'"><span class="glyphicon glyphicon-trash"></span></button>
        </div></td>';

        echo '</tr>';
    }
}
echo '</table>';
?>


