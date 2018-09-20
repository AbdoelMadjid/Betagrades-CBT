<?php

 
function getHostAddress(){ 
        return $_SERVER['SERVER_NAME'] === "localhost" ? "http://localhost/cbt" : $_SERVER['SERVER_NAME'];
    
}
$test = $_GET['CKEditorFuncNum'];

function endsWith($haystack, $needle)
{
    

    if(is_array($needle)){
        $foundMatch = false;
        foreach($needle as $n){
            $length = strlen($n);
            if( substr($haystack, -$length) === $n ){
                $foundMatch = true;


            }
        }
        return $foundMatch;
    }
    $length = strlen($needle);
    if ($length == 0) {
        return true;
    }

    return (substr($haystack, -$length) === $needle);
}

$files = scandir("./editor-images");
 
?>
 
<html>
    <head>

        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
        crossorigin="anonymous">
    </head>
<body>
<div class="container" style="margin-top:100px">

    <div class="row">
    <div class="col-md-8 col-md-offset-2">
    <?php
    foreach($files as $file)
    {

    if( endsWith($file, ["jpg","png","jpeg"]) ){

    
    ?>
    <div class="col-md-4" style="margin-bottom:15px;margin-top:15px;">
    <div style="border:1px solid #cccccc;padding:5px">
            <a style="" href="#"><img class="img-responsive" style="height:200px" src='<?php echo getHostAddress()."/editor-images/$file";?>'></a>
        </div>
    </div>
    <?php 
    } 
    }
    ?>
    </div>

    </div>
</div>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
<script type="text/javascript">
$('a[href]').on('click', function(e){
    e.preventDefault(); 
    window.opener.CKEDITOR.tools.callFunction(<?php echo $test; ?>,$(this).find('img').prop('src'));
    window.close();
});
</script>
</body>
</html>
