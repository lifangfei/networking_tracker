$(document).ready(function() {
  $('#login-swap').on('click', function(){
    $('#homepage-signup').hide();
    $('#homepage-login').show();
  });

  $('#signup-swap').on('click', function(){
    $('#homepage-login').hide();
    $('#homepage-signup').show();
  });
});
