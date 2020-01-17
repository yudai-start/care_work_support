$(function(){
  $('#care_home_post_image').change(function(){
    var file = $(this).prop('files')[0];
    var fileReader = new FileReader();
    fileReader.onloadend = function() {
        $('.edit_post_image_area').html('<img src="' + fileReader.result + '"/>');
    }
    fileReader.readAsDataURL(file);
  });
})