// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.require jquery.spin
// require spin

 
// require jquery
//= require jquery.min.js
// require jquery-1.12.0.min.js
//= require jquery_ujs
//= require bootstrap-sprockets
// require bootstrap.js
//= require jquery-ui.min.js
// require npm.js
// require turbolinks
//= require_tree .

 

function imgError(image) {
    image.onerror = "";
    image.src = "/assets/missing2.png";
    return true;
}

function imgError2(image) {
    image.onerror = "";
    image.src = "/assets/missing3.png";
    return true;
}

 
$(document).ready(function() {
  $("input.date-field").datepicker({
    changeMonth: true,
    changeYear: true,
    dateFormat: 'dd-mm-yy'
  });

  $(".date_of_birth").datepicker({
    changeMonth: true,
    changeYear: true,
    dateFormat: 'dd-mm-yy',
    yearRange: "1950:2005"
  });
});

$(document).ready(function() {
    var text_max = 300;
    $('#textarea_feedback').html(text_max);

    $('#textarea').keyup(function() {
        var text_length = $('#textarea').val().length;
        var text_remaining = text_max - text_length;

        $('#textarea_feedback').html(text_remaining);
    });
});


$(function () {
    var valid = {
        email: true,
        firstname: true,
        lastname: true,
        instauser_location: true,
        instauser_dob_3i: true,
        instauser_dob_2i: true,
        instauser_dob_1i: true,
        instauser_theme: true,
        postprice: true
    };
    var $submitBtn = $('input[type=submit]');
    $submitBtn.addClass('disabled');

    function check() {
        var isValid = true;
        for (var item in valid) {
            var $c = $('#' + item);
            valid[item] = !!($c.val().trim());
            $c[valid[item] ? 'removeClass' : 'addClass']('error');
            if (!valid[item])
                isValid = false;
        }
        return isValid;
    }


    for (var item in valid) {
        var $c = $('#' + item);
        var handler = function (e) {
            var isValid = !!($(this).val().trim());
            console.log($(this), 'changed');
            console.log($(this).val().trim(), isValid);
            $(this)[isValid ? 'removeClass' : 'addClass']('error');
            if (!isValid) {
                $submitBtn.addClass('disabled');
            } else {
                $submitBtn.removeClass('disabled');
            }
        };
        $c.change(handler);
        $c.blur(handler);
    }

    $('input[type=submit]').click(function (e) {
        e.preventDefault();
        e.stopPropagation;

        if (!check()) {
            //todo
        } else {
            $('form').submit();
        }
    });
});

 