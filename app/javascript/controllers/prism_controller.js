import { Controller } from "@hotwired/stimulus"
// import '../tinymce/prism'
// Connects to data-controller="prism"
export default class extends Controller {
  connect() {
    this.createTinymcePrism()
  }

  createTinymcePrism() { 
    if (this.prismScript) return;
    
    const script = document.createElement("script");
    script.src = "/assets/prism.js";
    script.type = "text/javascript";
    script.id = "tinymce-prism";
    document.body.appendChild(script);
  }

  disconnect() {
    const script = this.prismScript;
    if (!script) return;
    
    document.body.removeChild(script);
  }

  get prismScript() {
    return document.getElementById('tinymce-prism');
  }
}
