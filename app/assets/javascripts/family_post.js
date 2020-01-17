$(document).ready(function(){
  $('.slider').bxSlider({
    mode: 'fade',
    auto: true,
    autoStart: true,
    speed: 3000,
    pause: 2000,
    infiniteLoop: true,
    pager: false,
    prevSelector: '.custom-prev',
    nextSelector: '.custom-next'
  });
});