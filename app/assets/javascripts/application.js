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
//= require bootstrap-select.js
//= require bootstrap-sprockets
//= require bootstrap.js
//= require jquery-ui.min.js
// require npm.js
//= require turbolinks
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
  var clickOnPopupLink = function(){
    $('body').on('click', '.static-popup-link', function(){
      $('#myModal').modal('brands_contact_form');
    });
  }
  clickOnPopupLink();
});

$(document).ready(function() {
  $("input.date-field").datepicker({
    changeMonth: true,
    changeYear: true,
    dateFormat: 'yy-mm-dd'
  });

  $(".date_of_birth").datepicker({
    changeMonth: true,
    changeYear: true,
    dateFormat: 'dd-mm-yy',
    yearRange: "1950:2015"
  });
});
 
// Setter



