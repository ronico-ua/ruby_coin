import { Controller } from "@hotwired/stimulus"
import 'tinymce/tinymce.min.js'
import 'tinymce/models/dom/model'
import 'tinymce/icons/default/icons'
import 'tinymce/themes/silver/theme'
import 'tinymce/skins/ui/oxide-dark/skin'
import 'tinymce/skins/ui/oxide-dark/content'
import 'tinymce/plugins/codesample/plugin'
import 'tinymce/plugins/autolink/plugin'
import 'tinymce/plugins/importcss/plugin'
import 'tinymce/plugins/lists/plugin'
import 'tinymce/plugins/link/plugin'
import 'tinymce/plugins/image/plugin'
import 'tinymce/plugins/anchor/plugin'
import 'tinymce/plugins/searchreplace/plugin'
import 'tinymce/plugins/autoresize/plugin'
import 'tinymce/plugins/autosave/plugin'
import 'tinymce/plugins/media/plugin'
import 'tinymce/plugins/pagebreak/plugin'
import 'tinymce/plugins/nonbreaking'


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
      skin: false,
      autoresize_bottom_margin: 50,
      max_height: 700,
      nonbreaking_force_tab: true
    });
  }
}
