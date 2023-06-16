$(document).ready(function() {
  $('input[type="checkbox"].toggle').bootstrapToggle();

  function addImage(event) {
    if (event.target.files.length > 0) {
      var src = URL.createObjectURL(event.target.files[0]);
      $("#file-ip-1-preview").attr("src", src).css("display", "block");
      $("#preview").css("background-image", "none");
    }
  }
  
  $("#add-img").on("change", addImage);
});