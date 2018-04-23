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
        { "searchable": false, "targets": [2, 3, 4] },
        { "sortable": false, "targets": [2, 3, 4] }
      ]
    });
  }
}).call(this);
