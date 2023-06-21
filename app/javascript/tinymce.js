import tinymce from 'tinymce'
// import 'tinymce/tinymce';
// import 'tinymce/themes/silver/theme';
// import 'tinymce/models/dom/model';
// import 'tinymce/icons/default';
// import 'tinymce/';
// import 'tinymce/plugins/code/plugin';
// import 'tinymce/plugins/codesample/plugin';
// import 'tinymce/plugins/autolink/plugin';
// import 'tinymce/plugins/importcss/plugin';
// import 'tinymce/plugins/lists/plugin';
// import 'tinymce/plugins/link/plugin';
// import 'tinymce/plugins/image/plugin';
// import 'tinymce/plugins/anchor/plugin';
// import 'tinymce/plugins/searchreplace/plugin';


const rerender = function() {
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
}

document.addEventListener("turbo:load", rerender)
document.addEventListener("turbo:frame-render", rerender)
document.addEventListener("turbo:render", rerender)
