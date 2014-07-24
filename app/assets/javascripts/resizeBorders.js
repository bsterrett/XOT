function resizeBorders(){
  var target = $('.page-middle');
  var padding = $(window).height() - target.height();
  target.css('padding-bottom', padding+'px');
}

$(document).ready(function(){
  resizeBorders();
});