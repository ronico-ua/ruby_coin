$(document).ready(function() {
  const hideFlashMessage = function(setTime) {
    let time = 0;
    const alertElements = $('.alert');
    const reversedAlerts = Array.from(alertElements).reverse();
    reversedAlerts.forEach(function(alertElement) {
      time += setTime;
      setTimeout(function() {
        $(alertElement).animate({ opacity: '0' }, 300, function() {
          $(this).hide();
        });
      }, time);
    });
  };

  hideFlashMessage(3000);
});