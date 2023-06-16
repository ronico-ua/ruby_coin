$(document).ready(function() {
  $('#show-hide1').click(function() {
    $(this).toggleClass('active');
    var input1 = $('#user_password');
    
    if (input1.attr('type') === 'password') {
      input1.removeAttr('type').attr('type', 'text');
    } else {
      input1.removeAttr('type').attr('type', 'password');
    }
  });
  
  $('#show-hide2').click(function() {
    $(this).toggleClass('active');
    var input2 = $('#user_password_confirmation');
    
    if (input2.attr('type') === 'password') {
      input2.removeAttr('type').attr('type', 'text');
    } else {
      input2.removeAttr('type').attr('type', 'password');
    }
  });
});