$(document).ready(function(){
  
  // show the article filter
  $('.filter-show a').click(function(e) {
    e.preventDefault();

    $('.filter').toggle('slide', { direction: 'up'}, '300');
  });

});

