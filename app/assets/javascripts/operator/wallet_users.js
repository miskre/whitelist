(function() {
  $(document).ready(function() {
    init();
  });

  var init = function () {
    dataTableForWalletUser();
  }

  var dataTableForWalletUser = function() {
    $("#operator-wallet-user").DataTable({
      "columnDefs": [
        { "searchable": false, "targets": [6,7] },
        { "sortable": false, "targets": [6,7] }
      ]
    });
  }
}).call(this);
