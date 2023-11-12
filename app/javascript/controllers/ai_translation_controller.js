import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ai-translation"
export default class extends Controller {
  static targets = ["inputContainer", "outputContainer"]

  fetchData() {
    const inputData = this.inputContainerTarget.value;

    fetch('/translate', {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").getAttribute("content"),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ input_data: inputData }),
    })
    .then(response => response.json())
    .then(data => {
      this.outputContainerTarget.value = data.data;
    })
    .catch(error => {
    });
  }
}
