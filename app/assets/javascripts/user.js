$(function(){
  $('#user_image').change(function(){
    var file = $(this).prop('files')[0];
    var fileReader = new FileReader();
    fileReader.onloadend = function() {
        $('.image_area').html('<img src="' + fileReader.result + '"/>');
    }
    fileReader.readAsDataURL(file);
  });
})