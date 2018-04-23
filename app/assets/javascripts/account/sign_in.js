(function(){
  $( document ).ready(function() {
    init();
  });

  var init = function() {
    validateSignin();
  };

  var validateSignin = function() {
    $("#user-signin").validate({
      rules: {
        "session[email]": {
          required: true,
          email: true
        },
        "session[password]": {
          required: true,
          minlength: 6
        }
      }
    });
  }
}).call(this)
