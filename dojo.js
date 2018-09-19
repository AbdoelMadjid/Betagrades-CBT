$(function(){
  $('.timer').startTimer({
    onComplete: function(element){
    $( "#end_exam_button" ).trigger( "click" );
    }
  }).click(function(){ location.reload() });
})
