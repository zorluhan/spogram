
$(document).on('change', '#instauser_country' , function() {
  $('#instauser_city').html('');

  $.ajax({ 
    url: '/cities.json', 
    data: { country: $(this).val() } 
    }).success(function(result){

      var options = $('#instauser_city');
      $.each(result, function() {
        options.append($("<option />").val(this).text(this));
      });
    });
});
