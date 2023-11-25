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
      'autosave', 'media', 'pagebreak'
    ],
    // menubar: 'insert',
    toolbar: 'codesample | casechange blocks | bold italic | alignleft aligncenter alignjustify' +
      '| bullist numlist checklist | removeformat | restoredraft',
    content_css: false,
    // skin: false
    skin: "oxide-dark",
    autoresize_bottom_margin: 50,
    max_height: 700
  });
}

document.addEventListener("turbo:load", rerender)
document.addEventListener("turbo:frame-render", rerender)
document.addEventListener("turbo:render", rerender)

const adjustImageWidth = function() {
  console.log('Function adjustImageWidth is called.'); 
  const gemContent = document.querySelector('.post-show__content');
  if (gemContent) {
    const img = gemContent.querySelector('img');
    console.log('Gem Content:', gemContent); 
    console.log('Image:', img); 
    if (img) {
      const imgWidth = img.clientWidth;
      const screenWidth = window.innerWidth;

      console.log('Image Width:', imgWidth); 
      console.log('Screen Width:', screenWidth); 

      if (screenWidth < imgWidth) {
        img.style.width = '100%';
        console.log('Image width adjusted to 100%.'); 
      }
    }
  }
};

window.addEventListener('resize', function () {
  console.log('Resize event is triggered.');
  adjustImageWidth();
});
window.addEventListener('DOMContentLoaded', function () {
  console.log('DOMContentLoaded event is triggered.');
  adjustImageWidth();
});
window.addEventListener('load', function () {
  console.log('Load event is triggered.');
  adjustImageWidth();
});
