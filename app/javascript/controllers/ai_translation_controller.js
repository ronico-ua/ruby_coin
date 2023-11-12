import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ai-translation"
export default class extends Controller {
  static targets = ["inputContainer"]

  fetchData() {
    const inputData = this.inputContainerTarget.value;
    const outputBlock = document.getElementById("localized_description").querySelector('iframe').contentDocument.querySelector('body')
    const button = document.querySelector("#translation-button");
    button.innerHTML = "Translating..."

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
      outputBlock.setAttribute("data-mce-placeholder", "");
      outputBlock.innerHTML = data.data;
      button.innerHTML = "Done"
    })
    .catch(error => {

      button.innerHTML = "Something went wrong, try again"
    });
  }
}
