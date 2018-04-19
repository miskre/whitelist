(function(){
  $( document ).ready(function() {
    init();
  });

  var init = function() {
    validateSignup();
  };

  var validateSignup = function() {
    $("#register").validate({
      ignore: [],
      rules: {
        "user[email]": {
          required: true,
          email: true
        },
        "user[password]": {
          required: true,
          minlength: 6
        },
        "user[password_confirmation]": {
          required: true,
          minlength: 6,
          equalTo: "form#register #user_password"
        },
        "user[agreed]": {
          required: true
        }
      },
      errorPlacement: function(error, element) {
        if (element.attr("name") == "user[agreed]" )
          $(".error-text").append("<label class='error'>" + error.html() + "</label>");
        else
          error.insertAfter(element);
      }
    });
  }
}).call(this)
