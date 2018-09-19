<?php

$exp_date = "2018-09-23";
$todays_date = date("Y-m-d");
$today = strtotime($todays_date);
$expiration_date = strtotime($exp_date);

$sql = "select count(*) AS numOfResults from student_results";
$r = mysqli_query($dbc, $sql);
if ($r)
{
    $row = mysqli_fetch_array($r, MYSQLI_ASSOC);
    $numOfResults = $row['numOfResults'];
}
if ($expiration_date <= $today || $numOfResults > 200)
{
?>
<!DOCTYPE HTML PUBLIC “-//IETF//DTD HTML 2.0//EN”>
<html>
<head>
<title>Expired…</title>
</head>
<body>
<h1>License Expired!</h1>
<p>The license given to use this product as initially agreed has expired</p>
<hr>
<address>To continue to use this product, please contact us: https://betagrades.com, +2348149090022</address>
</body>
</html>
<?php
exit;
}

?>
