<?php
require 'includes/config.inc.php';
require MYSQLI ;
extract($_GET);
?>

<?php
$q = "SELECT count(*) AS results, avg(score) AS average_score, max(score) AS highest_score, min(score) AS lowest_score FROM `student_results` WHERE course_id = $id";
if ($_SESSION['user'] === 'lecturer') {
    $admin_id = $_SESSION['admin_id'];
    $q = "SELECT count(*) AS results, avg(score) AS average_score, max(score) AS highest_score, min(score) AS lowest_score FROM `student_results`
    INNER JOIN courses ON (courses.id=student_results.course_id) WHERE lecturer_id = $admin_id AND course_id = $id";
}
$r = mysqli_query($dbc, $q);
$row = mysqli_fetch_array($r, MYSQLI_ASSOC);
extract($row);
?>
<div class="col-lg-2" style=" float:left;margin:15px;height:150px; background-color:#00a65a ; color:white; padding:15px; border-radius:3px">
<div style="height:45px !important;">Average score for this Subject: </div><br><span class="center-block" style=" height:45px;clear:both; font-size:36px; text-align:center">
<?php echo floor($average_score); ?></span>
</div>
<div class="col-lg-2" style=" float:left; margin:15px; height:150px; background-color:#dd4b39; color:white; padding:15px; border-radius:3px">
 <div style="height:45px">Number of students who have taken this subject: </div><br><span class="center-block" style=" height:45px;clear:both; font-size:36px; text-align:center">
<?php echo $results; ?></span>
</div>
<div class="col-lg-2" style=" float:left;margin:15px;height:150px;background-color:#00c0ef ; color:white; padding:15px; border-radius:3px">
 <div style="height:45px">Highest score for this Subject: </div><br><span class="center-block" style=" height:45px;clear:both; font-size:36px; text-align:center">
<?php echo $highest_score; ?></span>
</div>
<div class="col-lg-2" style=" float:left;margin:15px;height:150px; background-color:#00a65a ; color:white; padding:15px; border-radius:3px">
<div style="height:45px !important;">Lowest score for this Subject: </div><br><span class="center-block" style=" height:45px;clear:both; font-size:36px; text-align:center">
<?php echo $lowest_score; ?></span>
</div>
</div>
<div  class="col-lg-12">
<?php
$single_course_analytics = true;
?>
<?php //include 'includes/chart.php';?>
</div>

