$(document).ready(function() {
  $('#show-hide').click(function() {
    $(this).toggleClass('active');
    var input = $('#user_password');
    
    if (input.attr('type') === 'password') {
      input.removeAttr('type').attr('type', 'text');
    } else {
      input.removeAttr('type').attr('type', 'password');
    }
  });
  
  $('#user_remember_me').click(function() {
    $('.custom').toggleClass('checked');
  });
});