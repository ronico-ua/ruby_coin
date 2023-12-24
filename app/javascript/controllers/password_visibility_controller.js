import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="password-visibility"
export default class extends Controller {

  static targets = ["input"]

  toggleVisibility(event) {
    event.preventDefault();
    event.stopPropagation();

    event.currentTarget.classList.toggle("active");

    const input = this.inputTarget;
    const currentType = input.type;
    input.type = currentType === "password" ? "text" : "password";
  }
}
