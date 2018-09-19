<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<?php

// convert JSON string to PHP Array
$someJSON = '[
							{"name":"Gbenga", "gender":"male"}, 
							{"name":"Segun", "gender":"female"}
						]';
$someArray = json_decode($someJSON, true);
print_r ($someArray);
echo '<br/>';
echo $someArray[1]['name'] . '</br>';

// loop through PHP Array
foreach ($someArray as $key => $value){
	echo $value['name'] . ' ' . $value['gender']. '</br>';
}

// convert JSON string to PHP Array
$someObject = json_decode($someJSON);
print_r ($someObject);

echo '<br/>';
echo $someObject[0]->name . '</br>';

// loop through PHP Object
foreach ($someObject as $key => $value){
	echo $value->name . ' ' . $value->gender . '</br>';
}

// converting PHP Array to JSON String
$someArray = [
		[
			"course"=>"CSC505",
			"title"=>"Fault Tolerant"
		],
		[
			"course"=>"CSC509",
			"title"=>"Artificial Intelligence"
		]
];
$someJSONString = json_encode($someArray);
echo $someJSONString;
?>
<?php
require 'includes/config.inc.php';
require MYSQLI ;



	$q = 'SELECT * FROM students';
	$r = mysqli_query($dbc, $q);
	$PHPArray = array();
	
	if ($r) {
		
		while ($row = mysqli_fetch_array($r, MYSQLI_ASSOC)) {
			
			$PHPArray[] = $row;
			// converting PHP Array to JSON String
			
	
		}
		$someJSONString = json_encode($PHPArray);
			//echo $someJSONString.'<br/>';
			//print_r($PHPArray);
	} else {
	}

?>

<div id="loopResult"></div>
<script src="jquery.js"></script>
<script>
$(function(){
	
	// convert JSON string to JavaScript Object
	var JSONString = '<?php echo $someJSONString;?>';
	var JSONObject = $.parseJSON(JSONString);
	//console.log(JSONObject); // Dump all data of the object in the console
	//alert(JSONObject[0]["surname"] + ': '+ JSONObject[0]["exam_no"]); // Access object data
	
	// loop through JavaScript Object
	for (var key in JSONObject) {
		if (JSONObject.hasOwnProperty(key)) {
			console.log(JSONObject[key]["surname"] + ", " + JSONObject[key]["exam_no"]);
			$('#loopResult').append(JSONObject[key]["surname"] + ", " + JSONObject[key]["exam_no"] + '</br>');
			
		}
	}
	
	// convert JavaScript Object to JSON String
	/*var JSONStringNew = JSON.stringify(JSONObject);
	alert(JSONStringNew);
	$('#loopResult').append(JSONStringNew);*/
	
	
	
});
</script>
</body>
</html>