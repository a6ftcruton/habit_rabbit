$('#create-custom').click(function() {
    $('#create-habit-form').toggle()
});

$('#track-repo').click(function() {
    $('#track-repo-form').toggle()
});

$('#github-stats-toggle').click(function() {
    $('#github-stats').toggle()
});

$('.new_event > input').click(function() {
  $('.event-form').fadeOut();
});

$('.notifications_check').on('change', function() {
  $(this).parents('form:first').submit();
});

var container = document.querySelector('.habit-list');
var msnry = new Masonry( container, {
  columnWidth: ".grid-sizer",
  itemSelector: '.habit-wrapper'
});
imagesLoaded( container, function() {
  msnry.layout();
});
