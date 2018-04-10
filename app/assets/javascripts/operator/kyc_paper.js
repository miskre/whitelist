$(document).ready(function(){
  $("#rejection-block").hide()
  $(".rejection-button").on("click", function() {
    $("#rejection-block").toggle()
    $("html, body").animate({scrollTop: 0}, 100);
  });
  if ( $("#wallet_kyc_paper_trading_check_box_agree").prop('checked') ) {
    $("#rev_trading_policy").show();
  } else {
    $("#rev_trading_policy").hide();
  }
  $("#wallet_kyc_paper_trading_check_box_agree").click(function(){
    $("#rev_trading_policy").toggle();
  });
  $('#data_1 .input-group.date').datepicker({
    startView: 2,
    keyboardNavigation: false,
    forceParse: false,
    autoclose: true,
    format: "yyyy/mm/dd"
  });
  $('#tag-1-nav').on('click', function(e) {
    $('#wallet_kyc_paper_type').val('Wallet::PassportKycPaper');
  });
  $('#tag-2-nav').on('click', function(e) {
    $('#wallet_kyc_paper_type').val('Wallet::NationalIdCardKycPaper');
  });
  $('#tag-3-nav').on('click', function(e) {
    $('#wallet_kyc_paper_type').val('Wallet::LicenseKycPaper');
  });
});

