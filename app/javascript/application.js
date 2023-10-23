// Entry point for the build script in your package.json
import "./common"

import "@hotwired/turbo-rails"
Turbo.session.drive = false
import 'bootstrap/js/dist/dropdown'
import 'bootstrap/js/dist/modal'
import 'bootstrap/js/dist/collapse'
import 'bootstrap5-toggle/js/bootstrap5-toggle.jquery'
import * as ActiveStorage from "@rails/activestorage"

ActiveStorage.start()

tinymce.init({
    selector: 'textarea#default-editor',
    height: 800,
    codesample_global_prismjs: true,
    codesample_languages: [
      { text: 'HTML/XML', value: 'markup' },
      { text: 'JavaScript', value: 'javascript' },
      { text: 'CSS', value: 'css' },
      { text: 'Ruby', value: 'ruby' },
      { text: 'Python', value: 'python' }
    ],
    plugins: ['codesample',  'autolink', 'importcss', 'lists', 'link', 'image', 'anchor', 'searchreplace'],
    toolbar: 'codesample | casechange blocks | bold italic backcolor | alignleft aligncenter alignright alignjustify' +
      '| bullist numlist checklist outdent indent | removeformat ',
    content_css: false,
    // skin: false
    skin: "oxide-dark"
  });