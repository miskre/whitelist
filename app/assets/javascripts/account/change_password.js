(function(){
  $( document ).ready(function() {
    init();
  });

  var init = function() {
    validateSignup();
  };

  var validateSignup = function() {
    $("#change-password").validate({
      rules: {
        "user[current_password]": {
          required: true,
          minlength: 6
        },
        "user[password]": {
          required: true,
          minlength: 6
        },
        "user[password_confirmation]": {
          required: true,
          minlength: 6,
          equalTo: "form#change-password #user_password"
        }
      }
    });
  }
}).call(this)
