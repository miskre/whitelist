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

    var kyc_validation = $("#verify").validate();
    set_paper_type(kyc_validation);

  };
  
  var set_paper_type = function(kyc_validation) {
    function passport_checked(kyc_validation) {
      $("#kyc_passport_number_block").show();
      $("#kyc_license_number_block").hide();
      $("#kyc_national_id_card_number_block").hide();
      $("#passport-session").show();
      $("#national-id-session").hide();
      $("#license-session").hide();

      kyc_validation.destroy();
      kyc_validation = $("#verify").validate({
        ignore: [],
        rules: {
          "kyc[passport_number]": {
            required: true,
            number_regex: /^[a-zA-Z0-9 -]+$/
          },
          "kyc[passport]": {
            required: function() {
              return $("#passport-session .back").attr("style").length == 23;
            },
            extension: "jpg|jpeg|png|gif"
          },
          "kyc[face_and_passport]": {
            required: function() {
              return $("#passport-session .selfie").attr("style").length == 23;
            },
            extension: "jpg|jpeg|png|gif"
          }
        }
      });
    }
    function national_id_checked(kyc_validation) {
      $("#kyc_national_id_card_number_block").show();
      $("#kyc_passport_number_block").hide()
      $("#kyc_license_number_block").hide();
      $("#passport-session").hide();
      $("#national-id-session").show();
      $("#license-session").hide();

      kyc_validation.destroy();
      kyc_validation = $("#verify").validate({
        ignore: [],
        rules: {
          "kyc[national_id_card_number]": {
            required: true,
            number_regex: /^[a-zA-Z0-9 -]+$/
          },
          "kyc[national_id_card]": {
            required: function() {
              return $("#national-id-session .front").attr("style").length == 23;
            },
            extension: "jpg|jpeg|png|gif"
          },
          "kyc[national_id_card_reverse]": {
            required: function() {
              return $("#national-id-session .back").attr("style").length == 23;
            },
            extension: "jpg|jpeg|png|gif"
          },
          "kyc[face_and_national_id_card]": {
            required: function() {
              return $("#national-id-session .selfie").attr("style").length == 23;
            },
            extension: "jpg|jpeg|png|gif"
          }
        }
      });
    }

    function license_checked() {
      $("#kyc_license_number_block").show();
      $("#kyc_passport_number_block").hide()
      $("#kyc_national_id_card_number_block").hide();
      $("#passport-session").hide();
      $("#national-id-session").hide();
      $("#license-session").show();

      kyc_validation.destroy();
      kyc_validation = $("#verify").validate({
        ignore: [],
        rules: {
          "kyc[license_number]": {
            required: true,
            number_regex: /^[a-zA-Z0-9 -]+$/
          },
          "kyc[license]": {
            required: function() {
              return $("#license-session .front").attr("style").length == 23;
            },
            extension: "jpg|jpeg|png|gif"
          },
          "kyc[license_reverse]": {
            required: function() {
              return $("#license-session .back").attr("style").length == 23;
            },
            extension: "jpg|jpeg|png|gif"
          },
          "kyc[face_and_license]": {
            required: function() {
              return $("#license-session .selfie").attr("style").length == 23;
            },
            extension: "jpg|jpeg|png|gif"
          }
        }
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
      passport_checked(kyc_validation);
    }
    if ($('#national-id').is(':checked')) {
      national_id_checked(kyc_validation);
    }
    if ($('#driver-license').is(':checked')) {
      license_checked(kyc_validation);
    }

    $('#passport').on('click', function(e) {
      passport_checked(kyc_validation);
    });
    $('#national-id').on('click', function(e) {
      national_id_checked(kyc_validation);
    });
    $('#driver-license').on('click', function(e) {
      license_checked(kyc_validation);
    });
  }

}).call(this)
