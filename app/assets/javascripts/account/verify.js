(function(){
  $(document).on("ready", function() {
    init();
  });

  var init = function() {
    set_paper_type();
  };
  
  var set_paper_type = function() {
    function passport_checked() {
      $("#kyc_passport_number").show();
      $("#kyc_license_number").hide();
      $("#kyc_national_id_card_number").hide();
      $("#passport-session").show();
      $("#national-id-session").hide();
      $("#license-session").hide();
    }
    function national_id_checked() {
      $("#kyc_national_id_card_number").show();
      $("#kyc_passport_number").hide()
      $("#kyc_license_number").hide();
      $("#passport-session").hide();
      $("#national-id-session").show();
      $("#license-session").hide();
    }

    function license_checked() {
      $("#kyc_license_number").show();
      $("#kyc_passport_number").hide()
      $("#kyc_national_id_card_number").hide();
      $("#passport-session").hide();
      $("#national-id-session").hide();
      $("#license-session").show();
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
