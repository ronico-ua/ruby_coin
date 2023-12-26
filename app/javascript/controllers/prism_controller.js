import { Controller } from "@hotwired/stimulus"
import '../tinymce/prism'

// Connects to data-controller="prism"
export default class extends Controller {
  connect() {
    console.log("Prism connected!")
  }
}
