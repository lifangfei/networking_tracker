$(document).ready(function() {
  $('#homepage-signup').on('click', "a", function(e){
    e.preventDefault();
    var link = $(this);
    $.ajax({
      url:    link.attr("href")
    })
    .done(function(response){
      $('#homepage-signup').empty();
      $('#homepage-login').append(response);
    })
  });

  $('#homepage-login').on('click', "a", function(e){
    e.preventDefault();
    var link = $(this);
    $.ajax({
      url:    link.attr("href")
    })
    .done(function(response){
      $('#homepage-login').empty();
      $('#homepage-signup').append(response);
    })
  });

  $('.lists').on('click', "a", function(e){
    e.preventDefault();
    var link = $(this);
    $.ajax({
      url:    link.attr("href")
    })
    .done(function(response){
      $('.list-details').empty();
      $('.list-details').append(response);
    })
  });
});
