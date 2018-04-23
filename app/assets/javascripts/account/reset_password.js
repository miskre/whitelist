(function(){
  $( document ).ready(function() {
    init();
  });

  var init = function() {
    validateForgetPassword();
    validateSetpassword();
  };

  var validateForgetPassword = function() {
    $("#forget-password").validate({
      rules: {
        "email": {
          required: true,
          email: true
        }
      }
    });
  }

  var validateSetpassword = function() {
    $("#set-new-password").validate({
      rules: {
        "wallet_user[password]": {
          required: true,
          minlength: 6
        },
        "wallet_user[password_confirmation]": {
          required: true,
          minlength: 6,
          equalTo: "form#set-new-password #wallet_user_password"
        }
      }
    });
  }
}).call(this)
