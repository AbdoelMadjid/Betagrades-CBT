
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].onclick = function() {
    this.classList.toggle("active");
    var panel = this.nextElementSibling;
    if (panel.style.maxHeight){
      panel.style.maxHeight = null;
    } else {
      panel.style.maxHeight = panel.scrollHeight + "px";
    } 
  }
}


$(function(){
	
	$('#cancel_end_exam').on('click', function(e) {
		$('#end_exam_confirmation').slideToggle(300);
	});
	$('#pre_end_exam_button').on('click', function(e) {
		e.preventDefault();
		$('#end_exam_confirmation').slideDown(300);
	});
});
