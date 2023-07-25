import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="highlight"
export default class extends Controller {
  toggleHighlight(event) {
    const label = event.currentTarget.labels[0];
    if (event.currentTarget.checked) {
      label.classList.add("active");
    } else {
      label.classList.remove("active");
    }
  }
}