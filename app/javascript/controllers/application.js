import { Application } from "@hotwired/stimulus"

const application = Application.start()

import $ from 'jquery'

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener("DOMContentLoaded", function() {
  var dropzone = document.getElementById("dropzone");

  dropzone.addEventListener("dragover", function(e) {
    e.preventDefault();
    this.classList.add("dragover");
  });

  dropzone.addEventListener("dragleave", function(e) {
    e.preventDefault();
    this.classList.remove("dragover");
  });

  dropzone.addEventListener("drop", function(e) {
    e.preventDefault();
    this.classList.remove("dragover");

    var files = e.dataTransfer.files;
    var imageInput = document.getElementById("image-upload");
    imageInput.files = files;
  });
});

$(document).on('turbolinks:load', function() {
  $('#toggle-one').bootstrapToggle();
})

$(document).on('turbolinks:load', function() {
  function hideFlashMessage(setTime){
    let time = 0
    $($('.alert').get().reverse()).each(function() {
      time = time + setTime
      $(this).delay(time).fadeOut(300);
    });
  }

  hideFlashMessage(3000)
});