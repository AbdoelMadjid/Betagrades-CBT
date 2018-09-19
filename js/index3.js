$(function() {

    $('#login_form').on('submit', function(e) {
        var form = $(this);
        e.preventDefault();
        form.prop('disabled', true);

        $.ajax({

            url: "Home",
            type: "POST",
            data: new FormData(this),
            contentType: false,
            processData: false,
            beforeSend: function() {
                //$('#loading').html('<img id="loadingGif" class="center-block" style="flot:left; margin-to:200px; width:50px; height:50px;" src="default.gif" />')
                $('#loadingGif').show();
                $('#not').html('Loading...');
                //$(this).child('button').attr('disabled', 'disabled');

            },
            complete: function() {
                //$('img#loadingGif').remove();

            },

            success: function(data) {
                if (data == 'ok') // if login successful
                {
                    $('#not').fadeIn(900).html('Login Successful. Redirection you..').css('color', 'green');
                    window.location.replace('Exam');
                } else if (data == 'lg') // if login successful
                {
                    $('#not').fadeIn(900).html('You have already written this exam').css('color', 'red');
                    //window.location.replace('Exam');
                } else
                // display recieved data
                {
                    $('#not').html(data).css('color', 'red');
                }


            }
        });

    });

    $('#sec_form').on('submit', function(e) {
        var form = $(this);
        e.preventDefault();
        var matricno = $('#mat').val();

        $.ajax({

            url: "Ajax/select_subject.php?matricno=" + matricno,
            type: "GET",
            data: new FormData(this),
            contentType: false,
            processData: false,
            beforeSend: function() {
                //$('#loading').html('<img id="loadingGif" class="center-block" style="flot:left; margin-to:200px; width:50px; height:50px;" src="default.gif" />')
                $('#loadingGif').show();
                $('#loading').html('Loading Subjects..');
            },
            complete: function() {
                //$('img#loadingGif').remove();

            },
            success: function(data) {
                $('#loadingGif').hide();
                $('#loading').html(data);
                $('html, body').animate({ scrollTop: 0 }, 500);
                if ($('#login_form button').hasClass('remove')) {
                    $('#sec_form').remove();
                }
                $('#not').html('');
            }
        });

    });


});