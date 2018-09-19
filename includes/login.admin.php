<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<html xmlns="http://www.w3.org/1999/xhtml">
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
<title>Untitled Document</title>
<style>
body { background:url(export/Group%2021@2x.png) center; font-family: "Montserrat";  }
.center-align { text-align:center}
label { float:left; clear:both; color: #666666; font-size:16px; font-weight:100 }
input, select { width:100%; padding:10px; background-color:white; border:1px solid #cccccc; float:left; clear:both; border-radius:3px; margin-bottom:15px}
button { background-color:#0066FF;transition:0.3s;width:100%; float:left; clear:both; border:1px solid #0066FF; padding:5px; border-radius:2px; color:white; font-size:14px} 
button:hover{ background-color: white; color:#0066FF;}
input, select, button { bo-shadow:1px 1px 5px #333333}
</style>
</head>

<body>
<div style="padding-top:100px" class="container-fluid">
<div class="row">

<div class="col-lg-4 col-lg-offset-4" >
<?php  //echo insert_school_logo("200","200", $dbc);?>
<form method="post" action="admin.php" id="login_form" class="center-block" style=" min-height:430px; border-radius:3px;width:80%; margin-top:15px;border:px solid red; background-color:white; floa:left; padding:15px 15px; padding-top:30px">
<img style="margin-bottom:15px" class="center-block" width="180" height="55" src="export/BetaGrades_logo2.png" />
<h4 style="color: #0033CC" class="center-align">Administrative Panel</h4>
<p style="text-align:center; color:#0033CC">Please enter your details as requested below.</p>
<div style="color:#FF0066; text-align:center;height:30px">
<?php if (isset($notification)) echo '*'. $notification . '*';?>
<span id="notify" style=""></span>
</div>

<label for="username">Username</label><input type="text" value="<?php echo xss_clean($_POST['username']); ?>" name="username" />
<label for="pass">Password</label><input type="password" name="pass" />
<?php
$session_id = session_id();
$salt = 'secret_nonce'.rand(0, 100);
$combination = $session_id.$salt;
$nonce = sha1($combination);
$_SESSION['admin_panel_nonce'] = $nonce ;
?>
<input type="password" name="nonce" value="<?php echo $_SESSION['admin_panel_nonce']; ?>" hidden="hidden" />
<button id="enabled_btn" class="center-block" type="submit" >LOG IN</button>
<!--<button type="submit" class="center-block btn btn-primary btn-lg " id="load" 
data-loading-text="<i class='fa fa-circle-o-notch fa-spin'></i> Processing Order">LOG IN</button>
<button type="button" class="btn btn-primary btn-lg" id="load" 
data-loading-text="<i class='fa fa-spinner fa-spin '></i> Processing Order">Submit Order</button>-->
</div>
<input type="text" name="submit" value="login" hidden="hidden"/>
<?php  echo $_SESSION['admin_panel_nonce2'];?>

</form>
</div>
</div>
</div>

<script src="jquery.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>

<script>
$(function(){

/*$('.btn').on('click', function() {
    var $this = $(this);
  $this.button('loading');
    setTimeout(function() {
       $this.button('reset');
   }, 8000);
});*/
	$('#login_form').on('submit', function(e) {
			e.preventDefault();
			$('#enabled_btn').remove();
			$('#login_form').append('<button id="disabled_btn" class="center-block" type="submit" disabled="disabled" >LOG IN</button>');

			$.ajax({
	
				url: "admin.php",
				type: "POST",
				data: new FormData(this),
				contentType: false,
				processData:false,
				beforeSend: function(){					
					//$('#view_questions_container').html('<img id="loadingGif" class="center-block" style="flot:left; margin-top:200px; width:100px; height:100px;" src="default.gif" />')
					
				},
				complete: function(){
					// Enabled with:
					//$('input[type="submit"], input[type="button"], button').disable(false);
					$('#disabled_btn').remove();
					$('#login_form').append('<button id="enabled_btn" class="center-block" type="submit" >LOG IN</button>');

				},
				success: function(data){
					if (data == 'ok') // if login successful
					{
						$('#notify').fadeIn(900).html('Login Successful. Redirection you..').css('color','green');
						location.reload();					
					}
					else if(data == 'wrong nonce') // if nonce is invalid, reload page
					{
						$('#notify').html(data).css('color','red');
						location.reload();
					}
					else // display recieved data
					{
						$('#notify').html(data).css('color','red');
					}

					
				}
			});

		});

});
</script>
</body>
</html>
