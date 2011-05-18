$(document).ready(function(){
  
  // show the article filter
  $('.filter-show a').click(function(e) {
    e.preventDefault();

    $('.filter').toggle('slide', { direction: 'up'}, '300');
  });

  // tipsy
  $('.filter-show a').tipsy({
    gravity: "w",
    fade: true
  });

  $('#footer .links a').tipsy({
    gravity: "s",
    fade: true,
    offset: 15
  });
  

});

