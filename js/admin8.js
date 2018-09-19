$(function() {
    $(document).on('click', '.view_student_btn', function(e) {
        //$('').on('click', function(e) {

        e.preventDefault()
        $('#view_student_modal').show();



        var student_id = $(this).attr("data-student-id");
        var student_fn = $(this).attr("data-student-fn");
        var student_ln = $(this).attr("data-student-ln");
        var student_en = $(this).attr("data-student-en");
        var student_cl = $(this).attr("data-student-cl");
        $('#student_fn').html('<strong>First Name</strong>: ' + student_fn);
        $('#student_sn').html('<strong>Other Name</strong>: ' + student_ln);
        $('#student_en').html('<strong>Exam Number</strong>: ' + student_en);
        $('#student_cl').html('<strong>Class</strong>: ' + student_cl);
        $('#student_dl_result_link').attr('href', 'admin.php?id=' + student_id + '&action=get_course_results_student&type=pdf')

        //window.location.replace('Ajax/students.php?page=get_profile&id=' + student_id);
        //$('body').html(student_id)

    })


    $('#remove_notification_tab').on('click', function() {
        $('#notification_tab').slideToggle(300);
    });
});

$('#select_class').on('change', function() {
    var value = $(this).val();


    if (value == '') {
        $('.the_student_info_row').show();
    } else {

        $('.the_student_info_row td:not(:contains(' + value + '))').parent('tr').hide();
        $('.the_student_info_row td:contains(' + value + ')').parent('tr').show();
    }
});

$('#search_student').on('keyup', function() {
        var value = $(this).val();


        value = value.toLowerCase().replace(/\b[a-z]/g, function(letter) {
            return letter.toUpperCase();
        });


        if (value == '') {
            $('.the_student_info_row').show(500);
        } else {

            $('.the_student_info_row td:not(:contains(' + value + '))').parent('tr').hide();
            $('.the_student_info_row td:contains(' + value + ')').parent('tr').show();
        }


    })
    // JS for tabs 
$('ul.tabs li').click(function() {
    //$(body).html('Bad');
    var tab_id = $(this).attr('data-tab');

    $('ul.tabs li').removeClass('current');
    $('.tab-content').removeClass('current');

    $(this).addClass('current');
    $("#" + tab_id).addClass('current');
})


$('#delete_question_button').on('click', function(e) {
    e.preventDefault();
    var question_id = $(this).attr("data-question-id");
    var num_of_available_questions = $('#num_of_available_questions').attr("data-num");

    $.get("Ajax/questions.php?id=" + question_id + "&action=delete", function(data) {

        $('.ajax_notification_div').html(data);
        $('.row_' + question_id).hide(1000);
        $('#delete_question_confirmation').slideToggle(300);
        var new_num_of_available_questions = num_of_available_questions - 1;
        if ($('#num_of_available_questions').html(new_num_of_available_questions)) {
            $('#num_of_available_questions').attr(data - num, (new_num_of_available_questions - 1));
        }
        //$('.ajax_notification_div').html(data);
        $('#delete_question_confirmation').slideToggle(300);
        if ($('.row_' + question_id).hide(1000, function() {
                $('.row_' + question_id).remove();
            })) {
            var new_num_of_available_questions = $('#questions_table tr').length;
            $('#num_of_available_questions').html(new_num_of_available_questions - 2);
            $('#num_of_available_questions').attr("data-num", new_num_of_available_questions - 2);
        }
    });
});


function display_conf(id) {

    $('#delete_question_button').attr("data-question-id", id);
    $('#delete_question_confirmation').slideToggle(300);
    $('#delete_info').html('The question with ID <strong>' + id + '</strong> will be permanently deleted. Are you sure you want to proceed?')

}
$(function() {
    $('#cancel_delete_question').on('click', function(e) {
        $('#delete_question_confirmation').slideToggle(300);
    });
    $('.action_delete_question').on('click', function(e) {
        $('body').html();
        e.preventDefault();
        var id = $(this).attr("data-id");
        $('#delete_question_button').attr("data-question-id", id);
        $('#delete_question_confirmation').slideToggle(300);
        $('#delete_info').html('The question with ID <strong>' + id + '</strong> will be permanently delete. Are you sure you want to proceed?')
    });
});

$(function() {
    $('#delete_student_btn_close').on('click', function(e) {
        $('#delete_student_confirmation').slideUp(300);
    });
    $(document).on('click', '.delete_student_btn', function(e) {
        //$('.delete_student_btn').on('click', function(e) {
        e.preventDefault();
        var s_id = $(this).attr("data-student-id");
        var fn = $(this).attr("data-student-fn");
        $('#delete_student_btn_yes').attr("data-student-id", s_id);
        $('#delete_student_confirmation').slideDown(300);
        $('#info_std').html('<b>' + fn + '</b> will be permanently removed. Are you sure you want to proceed?');
    });
    $(document).on('click', '#delete_student_btn_yes', function(e) {
        // $('#delete_student_btn_yes').on('click', function(e) {
        e.preventDefault();
        var student_id = $(this).attr("data-student-id");

        $.get("Ajax/students.php?id=" + student_id + "&action=delete_student", function(data) {

            $('.S' + student_id).hide(600);
            $('#delete_student_confirmation').slideUp(300);
            // $('html, body').animate({ scrollTop: 0 }, 500);

        });
    });

    $('#delete_teacher_btn_close').on('click', function(e) {
        $('#delete_teacher_confirmation').slideUp(300);
    });

    $('.delete_teacher_btn').on('click', function(e) {
        e.preventDefault();
        var t_id = $(this).attr("data-teacher-id");
        $('#delete_teacher_btn_yes').attr("data-teacher-id", t_id);
        $('#delete_teacher_confirmation').slideDown(300);
        var fn = $('#teacher_row_fn' + t_id).html();
        var ln = $('#teacher_row_ln' + t_id).html();
        $('#info').html('<b>' + fn + ' ' + ln + '</b> will be permanently removed. Are you sure you want to proceed?');
    });

    $('#delete_teacher_btn_yes').on('click', function(e) {
        e.preventDefault();
        var teacher_id = $(this).attr("data-teacher-id");
        $.get("admin.php?id=" + teacher_id + "&action=delete_teacher&page=create_lecturer", function(data) {

            $('#teacher_row_' + teacher_id).hide(600);
            $('#delete_teacher_confirmation').slideUp(300);
            $('html, body').animate({ scrollTop: 0 }, 500);

        });
    });

    $('.download_result_form select, .manager_view_questions_form select').on('change', function(e) {
        var form = $(this).parent('form');
        form.trigger('submit');

    });

    $('#analyze_result_form select').on('change', function(e) {
        var select = $(this);
        $('#analyze_result_form').trigger('submit');

    });

    $('.manager_view_questions_form').on('submit', function(e) {
        e.preventDefault();
        var course_id = $('.manager_view_questions_form select').val();


        $.ajax({

            url: "Ajax/view_questions.php",
            type: "POST",
            data: new FormData(this),
            contentType: false,
            processData: false,
            beforeSend: function() {
                $('#view_questions_container').html('<img id="loadingGif" class="center-block" style="flot:left; margin-top:200px; width:100px; height:100px;" src="default.gif" />')

            },
            complete: function() {
                $('img#loadingGif').remove();
            },
            success: function(data) {
                $('#view_questions_container').fadeOut(500).delay(300).fadeIn(500, function() {
                    $(this).html(data);
                });
                $('html, body').animate({ scrollTop: 0 }, 500);
            }
        });

    });




    $('#analyze_result_form').on('submit', function(e) {
        e.preventDefault();
        var course_id = $('#analyze_result_form select').val();

        $.get("analytics.php?id=" + course_id, function(data) {

            $('#analytics_container').fadeOut(500).delay(300).fadeIn(900, function() {
                $(this).html(data);
            });
            $('html, body').animate({ scrollTop: 0 }, 500);

        });

    });


    getStudentList();
    $('.student_list table tr td').css('paddin-left', '30px');

    function getStudentList() {
        $.getJSON("Ajax/students.php?page=list", function(data) {});
        $.get("Ajax/students.php?page=list", function(data) {

            // convert JSON string to JavaScript Object
            var JSONObject = $.parseJSON(data);

            // loop through JavaScript Object
            for (var key in JSONObject) {
                if (JSONObject.hasOwnProperty(key)) {
                    $('.student_list table').append('<tr style="color:#666666" class="S' +
                        JSONObject[key]["id"] + ' the_student_info_row ' + JSONObject[key]["class"] + '" height="40"><td width="200" style="paddin-left:30px"  scope="col">' +
                        JSONObject[key]["surname"] + '</td><td width="200"  scope="col">' +
                        JSONObject[key]["other_name"] + '</td><td width="200"  scope="col">' +
                        JSONObject[key]["exam_no"] + '</td><td width="200"  scope="col">' +
                        JSONObject[key]["class"] + '</td><td width="200"  scope="col"><form method="get" target="_blank" action="admin.php"><input type="text" name="action" value="get_course_results_student" hidden="hidden"/><select onchange="this.form.submit()" name="type"><option value="pdf">Download Student Results</option><option value="pdf">Download Result (PDF)</option><option value="csv">Download Result (CSV)</option><option value="xls">Download Result (XLS)</option></select><input hidden="hidden" type="text" name="id" value="' +
                        JSONObject[key]["id"] + '" /></form><a href="" data-student-fn="' +
                        JSONObject[key]["surname"] + ' ' +
                        JSONObject[key]["other_name"] + '" data-student-id="' +
                        JSONObject[key]["id"] + '" class="delete_student_btn center-block" style="text-align:center;margin-top:5px; margin-bottom:-7px;padding:4px;color:white;background-color:#f33155;border-radius:3px">DELETE STUDENT</a></td></tr>');
                }
            }

        });

    }


    //e.preventDefault();


    // function to add the details of the last registered 
    // student to the students list table
    function getLastStudentDetails() {
        $.getJSON("Ajax/students.php?page=list&a=last", function(data) {});
        $.get("Ajax/students.php?page=list&a=last", function(data) {

            // convert JSON string to JavaScript Object
            var JSONObject = $.parseJSON(data);

            // loop through JavaScript Object
            for (var key in JSONObject) {
                if (JSONObject.hasOwnProperty(key)) {

                    // display result after tr header
                    $('.student_list table #t_head').after('<tr style="color:#666666" class="S' +
                        JSONObject[key]["id"] + ' the_student_info_row ' + JSONObject[key]["class"] + '" height="40"><td width="200" style="paddin-left:30px"  scope="col">' +
                        JSONObject[key]["surname"] + '</td><td width="200"  scope="col">' +
                        JSONObject[key]["other_name"] + '</td><td width="200"  scope="col">' +
                        JSONObject[key]["exam_no"] + '</td><td width="200"  scope="col">' +
                        JSONObject[key]["class"] + '</td><td width="200"  scope="col"><form method="get" target="_blank" action="admin.php"><input type="text" name="action" value="get_course_results_student" hidden="hidden"/><select onchange="this.form.submit()" name="type"><option value="pdf">Download Student Results</option><option value="pdf">Download Result (PDF)</option><option value="csv">Download Result (CSV)</option><option value="xls">Download Result (XLS)</option></select><input hidden="hidden" type="text" name="id" value="' +
                        JSONObject[key]["id"] + '" /></form><a href="" data-student-fn="' +
                        JSONObject[key]["surname"] + ' ' +
                        JSONObject[key]["other_name"] + '" data-student-id="' +
                        JSONObject[key]["id"] + '" class="delete_student_btn center-block" style="text-align:center;margin-top:5px; margin-bottom:-7px;padding:4px;color:white;background-color:#f33155;border-radius:3px">DELETE STUDENT</a></td></tr>');
                }
            }

        });

    }

    $('#register_student_form').on('submit', function(e) {
        var form = $(this);
        e.preventDefault();

        // clear previous notification of any
        $('#notify_3').html('');


        $.ajax({

            url: "admin.php",
            type: "POST",
            data: new FormData(this),
            contentType: false,
            processData: false,
            beforeSend: function() {
                $('#register_student_form button').html('<i style="zoom:200%" class="fa fa-spinner fa-spin"></i>');
                //$('#notify').fadeIn(300).html('<i style="zoom:200%" class="fa fa-spinner fa-spin"></i>').css('color','black').addClass('center-block');
            },
            complete: function() {
                $('#register_student_form button').html('REGISTER STUDENT');
            },
            success: function(data) {
                if (data == 'ok') // if registration successful
                {
                    // roll down notification banner and alert of success
                    $('#notify_2').animate({ top: '+0px' }, 700).html('Student was successfully Registered').css('color', 'white');

                    // clear the form inputs for new registration
                    $('.input, textarea, input[type=file], select').val('');

                    // roll up notification after 3 seconds
                    $('#notify_2').delay(3000).animate({ top: '-70px' }, 700);

                    // update student list with the last registered student
                    getLastStudentDetails();

                    var previous_num_of_students = $('#num_of_students_counter').html();
                    var updated_num_of_students = previous_num_of_students + 1;
                    $('#num_of_students_counter').html(updated_num_of_students);

                } else if (data == 'wrong nonce') // if nonce is invalid, reload page
                {
                    $('#notify').html(data).css('color', 'red');
                } else // display recieved data
                {
                    // display the error message in red color
                    $('#notify_3').html(data).css('color', 'red');
                }


            }
        });

    });



});