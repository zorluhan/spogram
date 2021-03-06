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
    image.src = "<%= image_url('missing2.png') %>";
    return true;
}

function imgError2(image) {
    image.onerror = "";
    image.src = "<%= image_url('missing3.png') %>";
    return true;
}

function imgError3(image) {
    image.onerror = "";
    image.src = "<%= image_url('defaultimg.png') %>";
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

