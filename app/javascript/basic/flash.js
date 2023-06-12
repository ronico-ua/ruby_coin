document.addEventListener('DOMContentLoaded', function() {
  const hideFlashMessage = function(setTime) {
    let time = 0;
    const alertElements = document.getElementsByClassName('alert');
    const reversedAlerts = Array.from(alertElements).reverse();
    reversedAlerts.forEach(function(alertElement) {
      time += setTime;
      setTimeout(function() {
        alertElement.style.opacity = '0';
        setTimeout(function() {
          alertElement.style.display = 'none';
        }, 300);
      }, time);
    });
  };

  hideFlashMessage(3000);
});
