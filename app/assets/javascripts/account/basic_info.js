(function(){
  $( document ).ready(function() {
    init();
  });

  var init = function() {
    validateBasicInfo();
  };

  var validateBasicInfo = function() {
    $.validator.addMethod(
      "regex",
      function(value, element, regexp) {
          var re = new RegExp(regexp);
          return this.optional(element) || re.test(value);
      },
      "Please check your input."
    );
    $("#basic-info").validate({
      rules: {
        "kyc[country]": {
          required: true
        },
        "kyc[full_name]": {
          required: true,
          maxlength: 70
        },
        "kyc[birth_date]": {
          required: true
        },
        "kyc[street]": {
          required: true,
          maxlength: 70
        },
        "kyc[street2]": {
          maxlength: 70
        },
        "kyc[region]": {
          maxlength: 35,
          minlength: 2
        },
        "kyc[city]": {
          required: true,
          maxlength: 35,
          minlength: 2
        },
        "kyc[amount_range]": {
          required: true,
          number: true,
          max: 2,
          min: 0,
        },
        "kyc[btc_address]": {
          required: true,
          regex: /^[1-3][a-km-zA-HJ-NP-Z1-9]{25,34}$/
        }
      },
      messages: {
        "kyc[full_name]": {
          regex: "Only a-z, A-Z and space"
        },
        "kyc[street]": {
          regex: "Only a-z A-Z 0-9 #,.- and space"
        },
        "kyc[street2]": {
          regex: "Only a-z A-Z 0-9 #,.- and space"
        },
        "kyc[region]": {
          regex: "Only a-z A-Z 0-9 and space"
        },
        "kyc[city]": {
          regex: "Only a-z A-Z 0-9 and space"
        }
      }
    });
  }
}).call(this)
