// JS for tabs
$('ul.tabs li').click(function() {

    var tab_id = $(this).attr('data-tab');

    $('ul.tabs li').removeClass('current');
    $('.tab-content').removeClass('current');

    $(this).addClass('current');
    $("#" + tab_id).addClass('current');

})

$(function() {
    //$('#que').html('Nice');

    $('#close_delete_que').on('click', function(e) {
        $('#update_question_confirmation').slideUp(300);
    });
    $('.action_update_question').on('click', function(e) {
        e.preventDefault();
        var selected_question = $(this);
        var question_id = selected_question.attr("data-id");
        $('#update_question_confirmation').slideDown(300);
        var instruction_id = $('.row_' + question_id).attr("data-instruction-id");
        var question = $('.question_' + question_id).html();
        var option1 = $('.option1_' + question_id).html();
        var option2 = $('.option2_' + question_id).html();
        var option3 = $('.option3_' + question_id).html();
        var answer = $('.answer_true' + question_id).html();

        //$('#update_question_form #que').val(question);
        //$('#update_question_form #questionn').html(encodeURIComponent(question));
        $('#update_question_form #questionn').html(question);
        $('#update_question_form .fr-element p').html(question);

        $('#update_question_form .option1').val(answer);

        $('#update_question_form .option2').val(option1);
        $('#update_question_form .option3').val(option2);
        $('#update_question_form .option4').val(option3);

        $('#update_question_form .que_id').attr('value', question_id);
        $('#update_question_form .inst_id').attr('value', instruction_id);
        var instruction = $('.the_instruction_' + question_id).val();
        $('#inst_value').val(instruction);

    });

    $(document).on('submit', '#update_question_form', function(e) {
        //$('#update_question_form').on('submit', function(e) {
        var form = $(this);
        e.preventDefault();

        $.ajax({

            url: "Ajax/update_question.php",
            type: "POST",
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function(data) {
                //$('.ajax_notification_div').html('<span style="color:green">' + data + '</span>');
                //$('html, body').animate({ scrollTop: 0 }, 500);
                $('#update_question_confirmation').slideToggle(300);
                // roll down notification banner and alert of success
                $('#notify_2').animate({ top: '+0px' }, 700).html(data).css('color', 'white');

                // roll up notification after 3 seconds
                $('#notify_2').delay(3000).animate({ top: '-70px' }, 700);


                // get updated value from input
                // append them to table
                var question = $('#update_question_form #questionn').val();
                var answer = $('#update_question_form .option1').val();
                var option1 = $('#update_question_form .option2').val();
                var option2 = $('#update_question_form .option3').val();
                var option3 = $('#update_question_form .option4').val();
                var question_id = $('.que_id').val();
                $('.question_' + question_id).html(question);
                $('.option1_' + question_id).html(option1);
                $('.option2_' + question_id).html(option2);
                $('.option3_' + question_id).html(option3);
                $('.answer_true' + question_id).html(answer);
                var instruction = $('#inst_value').val();
                $('.the_instruction_' + question_id).val(instruction);

            }
        });

    });

    $('#delete_question_button').on('click', function(e) {
        e.preventDefault();
        var question_id = $(this).attr("data-question-id");
        var num_of_available_questions = $('#num_of_available_questions').attr("data-num");

        $.get("Ajax/questions.php?id=" + question_id + "&action=delete", function(data) {

            $('.ajax_notification_div').html(data);
            $('.row_' + question_id).hide(1000);
            $('#delete_question_confirmation').slideUp(300);
            var new_num_of_available_questions = num_of_available_questions - 1;
            if ($('#num_of_available_questions').html(new_num_of_available_questions)) {
                $('#num_of_available_questions').attr(data - num, (new_num_of_available_questions - 1));
            }
            //$('.ajax_notification_div').html(data);
            //$('#delete_question_confirmation').slideToggle(300);
            if ($('.row_' + question_id).hide(1000, function() {
                    $('.row_' + question_id).remove();
                })) {
                var new_num_of_available_questions = $('#questions_table tr').length;
                $('#num_of_available_questions').html(new_num_of_available_questions - 2);
                $('#num_of_available_questions').attr("data-num", new_num_of_available_questions - 2);
            }
        });
    });

    /*$('#delete_question_button').on('click', function(e) {
	e.preventDefault();
	var question_id = $(this).attr("data-question-id");
	var num_of_available_questions = $('#num_of_available_questions').attr("data-num");

	$.get("Ajax/questions.php?id=" + question_id + "&action=delete", function(data){

		
		var result = data;
		var parseData = $.parseJSON(data);
		var first_element = parseData[0];
		$('#delete_question_confirmation').slideToggle(300);
		
		// convert JSON string to JavaScript Object
		//var JSONString = '<?php echo $someJSONString;?>';
		var JSONObject = $.parseJSON(result);
		console.log(JSONObject); // Dump all data of the object in the console
		//alert(JSONObject[0]["result"] + ': '+ JSONObject[0]["title"]); 
		alert(JSONObject[0]["result"]); 
		// Access object data
		
		if (result === "success") {
			$('.ajax_notification_div').html('Question with ID <strong>'+question_id + '</strong> successfully deleted' + result);
			if($('.row_'+question_id).hide(1000, function(){
				$('.row_'+question_id).remove();
			}) ){
				var new_num_of_available_questions = $('#questions_table tr').length;
				$('#num_of_available_questions').html(new_num_of_available_questions-2);
				$('#num_of_available_questions').attr("data-num", new_num_of_available_questions -2);
			}
		}else if (result === "failure") { 
			$('.ajax_notification_div').html('Could not delete question, Please try again later.' + result);
			
		}else if (result === "failures") { 
			$('.ajax_notification_div').html('Result: ' + result);
			
		}
		
	});
});*/

    $('#uploadBtn').on('change', function() {
        $('#uploadFile').val(this.value);
    });


    $('#upload_img_form').on('submit', function(e) {
        $("#upload_img_form button").attr("disabled", true);
        var form = $(this);
        e.preventDefault();

        $.ajax({
            url: "Ajax/upload_image.php",
            type: "POST",
            data: new FormData(this),
            contentType: false,
            processData: false,
            beforeSend: function() {
                $('#upload_img_form #upload_btn').val('loading...').attr('type', 'button').after('<img id="loadingGif" class="center-block" style="flot:left; width:20px; height:20px;" src="default.gif" />');
            },
            complete: function() {
                $('#upload_img_form #upload_btn').val('Upload').attr('type', 'submit');
                $('img#loadingGif').remove();
            },
            success: function(data) {
                $("#upload_img_form button").attr("disabled", false);
                $('.ajax_notification_div').html(data).fadeIn(300);
                $('html, body').animate({ scrollTop: 0 }, 500);
            }
        });

    });

    $('#cancel_delete_course').on('click', function(e) {
        $('#delete_course_confirmation').slideUp(300);
    });
    $('#action_delete_button').on('click', function(e) {
        e.preventDefault();
        $('#delete_course_confirmation').slideDown(300);
    });


    $('#cancel_delete_question').on('click', function(e) {
        $('#delete_question_confirmation').slideUp(300);
    });
    $('.action_delete_question').on('click', function(e) {
        e.preventDefault();
        var id = $(this).attr("data-id");
        $('#delete_question_button').attr("data-question-id", id);
        $('#delete_question_confirmation').slideDown(300);
        $('#delete_info').html('The question with ID <strong>' + id + '</strong> will be permanently delete. Are you sure you want to proceed?')
    });


    $('#insert_question_for').on('submit', function(e) {
        var form = $(this);
        e.preventDefault();

        $.ajax({

            url: "Ajax/course_post.php",
            type: "POST",
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function(data) {
                $('.ajax_notification_div').html(data).fadeIn(300);
                $('html, body').animate({ scrollTop: 0 }, 500);

                // clear form values
                $('input[type=text], textarea, input[type=file]').val('');
                $('#insert_question_form textarea').html('');
                $('body#tinymce p').html(' ');
                $('#insert_question_form #add_que_textarea').html('');
                $('#insert_question_form .fr-element p').html('');
                if ($('input#uploadBtn').remove()) {
                    $('.fileUpload').append('<input id="uploadBtn" type="file" class="upload new" name="image" />');
                    $('#uploadFile').val('');
                }
                //$('select').find('option').prop("selected", false);
                //$('input[type=radio]').prop("checked", false)
            }
        });

    });

    $('#add_passage_form').on('submit', function(e) {
        var form = $(this);
        e.preventDefault();
        var details = $('#add_passage_form').serialize();


        $.ajax({

            url: "Ajax/passage.php",
            type: "POST",
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function(data) {
                // roll down notification banner and alert of success
                $('#notify_2').animate({ top: '+0px' }, 700).html('Passage successfully added').css('color', 'white');

                // roll up notification after 3 seconds
                $('#notify_2').delay(3000).animate({ top: '-70px' }, 700);

                $('html, body').animate({ scrollTop: 0 }, 500);

                // clear form values

                $('input[type=text], textarea, input[type=file]').val('');

                $('input[type=text], textarea, input[type=file]').val('');
                $('#add_passage_form textarea').html('');
                $('body#tinymce p').html(' ');
                $('#add_passage_form #add_que_textarea').html('');
                $('#add_passage_form .fr-element p').html('');
            }
        });

    });

    $('#allocated_time_form').on('submit', function(e) {
        var form = $(this);
        e.preventDefault();
        var id = form.children('#input_course_id').val();
        var input_allocated_time = form.children('#input_allocated_time').val();

        $.get("course.php?id=" + id + "&action=allocated_time&allocated_time=" + input_allocated_time + "", function(data) {

            // roll down notification banner and alert of success
            $('#notify_2').animate({ top: '+0px' }, 700).html(data).css('color', 'white');

            // roll up notification after 3 seconds
            $('#notify_2').delay(3000).animate({ top: '-70px' }, 700);
            $('#alloc_time').html(input_allocated_time);
            $('html, body').animate({ scrollTop: 0 }, 500);

        });

    });


    $('#num_of_questions_form').on('submit', function(e) {
        var form = $(this);
        e.preventDefault();
        input_q_to_ans
        var input_course_id = form.children('#input_course_id').val();
        var input_q_to_ans = form.children('#input_q_to_ans').val();
        var num_of_q = form.children('#num_of_q').val();

        $.get("course.php?id=" + input_course_id + "&action=questions_to_be_answered&num_of_q=" + num_of_q + "", function(data) {

            // roll down notification banner and alert of success
            $('#notify_2').animate({ top: '+0px' }, 700).html(data).css('color', 'white');

            // roll up notification after 3 seconds
            $('#notify_2').delay(3000).animate({ top: '-70px' }, 700);
            $('#q_to_anss').html(num_of_q);
            $('html, body').animate({ scrollTop: 0 }, 500);
        });

    });



    $('#take_course_button').on('click', function(e) {
        var t = $(this);
        e.preventDefault();
        var id = $(this).attr("data-id");
        var action = $(this).attr("data-take");

        $.get("course.php?id=" + id + "&take_course=" + action + "", function(data) {
            //t.parents('#theParent').fadeOut(500);
            $('.ajax_notification_div').html(data).fadeIn(3000);
            var course = 'online';
            if (action === 'online') {
                var course = 'offline';
            }
            t.html('take course ' + course).attr('data-id', id).attr('data-take', course);
            $('html, body').animate({ scrollTop: 0 }, 500);
        });

    });

    $('#delete_course_button').on('click', function(e) {
        e.preventDefault();
        var id = $(this).attr("data-id");
        $(location).attr('href', "course.php?id=" + id + "&action=delete")

    });
});