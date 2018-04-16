(function(){
  $( document ).ready(function() {
    init();
  });

  var init = function() {
    $.validator.addMethod(
      "number_regex",
      function(value, element, regexp) {
          var re = new RegExp(regexp);
          return this.optional(element) || re.test(value);
      },
      "Only a-z A-Z 0-9 - and space"
    );
    set_paper_type();

    $("#verify").validate();
  };
  
  var set_paper_type = function() {
    function passport_checked() {
      $("#kyc_passport_number_block").show();
      $("#kyc_license_number_block").hide();
      $("#kyc_national_id_card_number_block").hide();
      $("#passport-session").show();
      $("#national-id-session").hide();
      $("#license-session").hide();
      jQuery.validator.addClassRules("kyc_passport_number", {
        required: true,
        number_regex: /^[a-zA-Z0-9 -]+$/
      });
    }
    function national_id_checked() {
      $("#kyc_national_id_card_number_block").show();
      $("#kyc_passport_number_block").hide()
      $("#kyc_license_number_block").hide();
      $("#passport-session").hide();
      $("#national-id-session").show();
      $("#license-session").hide();
      jQuery.validator.addClassRules("kyc_national_id_card_number", {
        required: true,
        number_regex: /^[a-zA-Z0-9 -]+$/
      });
    }

    function license_checked() {
      $("#kyc_license_number_block").show();
      $("#kyc_passport_number_block").hide()
      $("#kyc_national_id_card_number_block").hide();
      $("#passport-session").hide();
      $("#national-id-session").hide();
      $("#license-session").show();
      jQuery.validator.addClassRules("kyc_license_number", {
        required: true,
        number_regex: /^[a-zA-Z0-9 -]+$/
      });
    }

    if ($("#paper_type").val() == "Wallet::PassportKycPaper") {
      $('#passport').prop('checked', true);
    }
    else if ($("#paper_type").val() == "Wallet::NationalIdCardKycPaper") {
      $('#national-id').prop('checked', true);
    }
    else if ($("#paper_type").val() == "Wallet::LicenseKycPaper") {
      $('#driver-license').prop('checked', true);
    }



    if ($('#passport').is(':checked')) {
      passport_checked();
    }
    if ($('#national-id').is(':checked')) {
      national_id_checked();
    }
    if ($('#driver-license').is(':checked')) {
      license_checked();
    }

    $('#passport').on('click', function(e) {
      passport_checked();
    });
    $('#national-id').on('click', function(e) {
      national_id_checked();
    });
    $('#driver-license').on('click', function(e) {
      license_checked();
    });
  }

}).call(this)
