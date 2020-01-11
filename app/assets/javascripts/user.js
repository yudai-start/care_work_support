// $(".file").on('change', function(){
//   var fileprop = $(this).prop('files')[0],
//       find_img = $(this).next('img'),
//       fileRdr = new FileReader();
  
//   if(find_img.length){
//      find_img.nextAll().remove();
//      find_img.remove();
//   }
  
//  var img = '<img width="200" alt="" class="img_view"><a href="#" class="img_del">画像を削除する</a>';

//  view_box.append(img);
  
//  fileRdr.onload = function() {    
//    view_box.find('img').attr('src', fileRdr.result);
//    img_del(view_box); 
//  }
//  fileRdr.readAsDataURL(fileprop);  
// });
$(function(){
  $('#user_image').change(function(){
    // $('img').remove();
    var file = $(this).prop('files')[0];
    // if(!file.type.match('image.*')){
    //     return;
    // }
    var fileReader = new FileReader();
    // $(".image_area").remove() 
    fileReader.onloadend = function() {
        $('.image_area').html('<img src="' + fileReader.result + '"/>');
    }
    fileReader.readAsDataURL(file);
});

//   $('#user_image').on('change', function (e) {
//     var reader = new FileReader();
//     reader.onload = function (e) {
//         $(".image_area").attr('src', e.target.result);
//     }
//     reader.readAsDataURL(e.target.files[0]);
// });

//   $('.field').on("click", function() {
//     console.log("ok");
//   });
})