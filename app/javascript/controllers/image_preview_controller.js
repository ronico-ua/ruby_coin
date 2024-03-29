import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-preview"
export default class extends Controller {
  static targets = ["preview", "background" ]
  
  static values = { 
    imageAttached: Boolean
  }

  connect() {
    this.handleBackgroundImage();  
  }

  handleBackgroundImage(){
    if (this.imageAttachedValue) {
      this.backgroundTarget.style.backgroundImage = "none";
    } 
  };

  addImage(event) {
    if (event.target.files.length > 0) {
      var src = URL.createObjectURL(event.target.files[0]);
      this.previewTarget.src = src;
      this.previewTarget.style.display = "block";
      this.backgroundTarget.style.backgroundImage = "none";
    }
  }
}
