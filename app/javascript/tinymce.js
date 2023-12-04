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
    // codesample_global_prismjs: true,
    codesample_languages: [
      { text: 'Ruby', value: 'ruby' },
      { text: 'HTML/XML', value: 'markup' },
      { text: 'JavaScript', value: 'javascript' },
      { text: 'CSS', value: 'css' }
    ],
    plugins: [
      'codesample', 'autolink', 'importcss', 'lists', 'link', 'image', 'anchor', 'searchreplace', 'autoresize',
      'autosave', 'media', 'pagebreak', 'nonbreaking'
    ],
    // menubar: 'insert',
    toolbar: 'codesample nonbreaking | casechange blocks | bold italic | alignleft aligncenter alignjustify' +
      '| bullist numlist checklist | removeformat | restoredraft',
    content_css: false,
    // skin: false
    skin: "oxide-dark",
    autoresize_bottom_margin: 50,
    max_height: 700,
    nonbreaking_force_tab: true
  });
}

document.addEventListener("turbo:load", rerender)
document.addEventListener("turbo:frame-render", rerender)
document.addEventListener("turbo:render", rerender)

// let adjustImageWidth = function() {
//   let gemContent = document.querySelector('.post-show__content');
//   if (gemContent) {
//     let img = gemContent.querySelector('img');
//     if (img) {
//       let imgWidth = img.clientWidth;
//       let screenWidth = window.innerWidth;
//       if (screenWidth < imgWidth) {
//         img.style.width = '100%';
//       }
//     }
//   }
// };
//
// window.addEventListener('resize', function () {
//   adjustImageWidth();
// });
// window.addEventListener('DOMContentLoaded', function () {
//   adjustImageWidth();
// });
