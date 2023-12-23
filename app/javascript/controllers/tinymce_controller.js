import { Controller } from "@hotwired/stimulus"
import tinymce from 'tinymce'

// Connects to data-controller="tinymce"
export default class extends Controller {
  
  codesample_languages = [  
    { text: 'Ruby', value: 'ruby' },
    { text: 'HTML/XML', value: 'markup' },
    { text: 'JavaScript', value: 'javascript' },
    { text: 'CSS', value: 'css' }
  ]

  plugins = [
    'codesample', 'autolink', 'importcss', 'lists', 'link', 'image', 'anchor', 'searchreplace', 'autoresize',
    'autosave', 'media', 'pagebreak', 'nonbreaking'
  ]

  toolbar = [
    'codesample nonbreaking',
    'casechange blocks',
    'bold italic',
    'alignleft aligncenter alignjustify',
    'bullist numlist checklist',
    'removeformat',
    'restoredraft'
  ].join(' | ');

  connect() {
    tinymce.init({
      selector: 'textarea#default-editor',
      height: 800,
      codesample_languages: this.codesample_languages, // codesample_global_prismjs: true,
      plugins: this.plugins,
      toolbar: this.toolbar, // menubar: 'insert',
      content_css: false,
      // skin: false
      skin: "oxide-dark",
      autoresize_bottom_margin: 50,
      max_height: 700,
      nonbreaking_force_tab: true
    });
  }
}
