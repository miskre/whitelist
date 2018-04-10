(function() {
  $(document).ready(function() {
    init();
  });

  var init = function () {
    zoomImage();
  }

  var zoomImage = function() {
    $(".kyc_information_review img").elevateZoom();
  }
}).call(this);
