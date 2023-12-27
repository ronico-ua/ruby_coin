import { Controller } from "@hotwired/stimulus"
import Translations from '../i18n/aitranslation'

// Connects to data-controller="aitranslation"
export default class extends Controller {
  static targets = ["locale"];

  fetchData() {
    const inputBlock = document.getElementById("basic-description").querySelector('iframe').contentDocument.body.innerHTML;
    const outputBlock = document.getElementById("localized_description").querySelector('iframe').contentDocument.querySelector('body')
    const button = document.querySelector("#translation-button");
    const i18n = Translations[document.querySelector('body').dataset.lang]
    const locale = this.data.get("locale")

    button.innerHTML = i18n['translating']

    fetch('/management/posts/translate', {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").getAttribute("content"),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ input_data: inputBlock, locale: locale }),
    })
    .then(response => response.json())
    .then(data => {
      outputBlock.setAttribute("data-mce-placeholder", "");
      outputBlock.innerHTML = data.data;
      button.innerHTML = i18n['done']
      button.style.backgroundColor = 'darkgreen'
    })
    .catch(error => {
      button.innerHTML = i18n['error']
      button.style.backgroundColor = 'goldenrod'
    });
  }
}
