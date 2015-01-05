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
