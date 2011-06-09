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

  $('input#all').change(function(e) {
    var check = $(this).is(':checked') ? true : false
    $('.article-list input[type="checkbox"]').attr('checked', check);
  });

  $('.article-list input[type="checkbox"]').change(function(e) {
    if($('.article-list input[type="checkbox"]:checked').length == 0 ) { 
      $('#mass-convert').slideUp(); 
      return; 
    } 
    $('#mass-convert').slideDown();
  });

  $('#mass-convert a').click(function(e) {
    e.preventDefault();
    var ids = _.map($('.article-list input[type="checkbox"]:checked'), function(ck) { return $(ck).val() });

    $.ajax({
      type: 'post',
      url: $(this).attr('href'),
      data: { check: ids },
      beforeSend: function() {
        $('#mass-convert').hide();
        $('#generating').fadeIn();
      }, 
      success: function(link) {
        $('#generating').hide();
        $('#link').html("<h3><a href='/"+link+"'>Download!</a></h3>");
      },
      error: function() {
        $('#mass-convert').show();
        $('#generating').hide();
      }
    });

  });

});

