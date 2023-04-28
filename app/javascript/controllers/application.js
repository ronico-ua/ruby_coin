import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// document.addEventListener("DOMContentLoaded", function() {
//   function hideFlashMessage(setTime){
//     let time = 0
//     $($('.alert').get().reverse()).each(function() {
//       time = time + setTime
//       $(this).delay(time).fadeOut(300);
//       // debugger;
//     });
//   }
//
//   hideFlashMessage(3000)
// });
