$(function() {
  setDatePickers();

  function setDatePickers() {
    $('#xepChartDatepicker')
      .datepicker('update', getXepLogTimeStamp())
      .on('changeDate', handleChangeDatepicker);
    $('#xepChartPublishOn').datepicker({
      autoclose: true,
      format: 'yyyy-mm-dd'
    });
  }

  function getXepLogTimeStamp() {
    return new Date($('.xepLogTimestamps').eq(0).val() || new Date());
  }

  function handleChangeDatepicker(e) {
    if(e.date === undefined) {
      setSubmitDisabled(true);
      return clearCurrentTimeStamps();
    }

    checkXepLogsExist(e.date);
  }

  function checkXepLogsExist(date) {
    $.ajax({
      type: 'POST',
      dataType: 'json',
      url: '/ja/operator/xep_chart/check_xep_logs_exist',
      data: {dateSelected: date.toISOString()},
      success: handlePostSuccess
    });
  }

  function handlePostSuccess(data) {
    setSubmitDisabled(data.xepLogsExist);

    if(data.xepLogsExist) {
      alert('データがすでに存在します。編集ページから変更を行ってください。');
      $('#xepChartDatepicker').val('').datepicker('update');
      return clearCurrentTimeStamps();
    }

    setCurrentTimeStamps(new Date(data.date));
  }

  function setSubmitDisabled(bool) {
    $('#submitXepLogs').prop('disabled', bool);
  }

  function setCurrentTimeStamps(date) {
    $('.xepLogTimestamps').each(function(i) {
      var timeStamp = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate(), i-9, 0, 0)).toISOString();
      $(this).val(timeStamp);
    });
  }

  function clearCurrentTimeStamps() {
    $('.xepLogTimestamps').val('');
  }

  // var xepData = [
  //   {"open": "160.00", "high": "120.00", "low": "110.00", "close": "167.00", "buy": '123', "sell": '0'},
  //   {"open": "135.26", "high": "135.95", "low": "131.50", "close": "131.85", "buy": '123', "sell": '0'},
  //   {"open": "132.90", "high": "135.27", "low": "128.30", "close": "135.25", "buy": '123', "sell": '0'},
  //   {"open": "134.94", "high": "137.24", "low": "132.63", "close": "135.03", "buy": '123', "sell": '0'},
  //   {"open": "136.76", "high": "136.86", "low": "132.00", "close": "134.01", "buy": '123', "sell": '0'},
  //   {"open": "131.11", "high": "133.00", "low": "125.09", "close": "126.39", "buy": '123', "sell": '0'},
  //   {"open": "123.12", "high": "127.75", "low": "120.30", "close": "125.00", "buy": '123', "sell": '0'},
  //   {"open": "128.32", "high": "129.35", "low": "126.50", "close": "127.79", "buy": '123', "sell": '0'},
  //   {"open": "128.29", "high": "128.30", "low": "123.71", "close": "124.03", "buy": '123', "sell": '0'},
  //   {"open": "160.00", "high": "120.00", "low": "110.00", "close": "167.00", "buy": '123', "sell": '0'},
  //   {"open": "135.26", "high": "135.95", "low": "131.50", "close": "131.85", "buy": '123', "sell": '0'},
  //   {"open": "132.90", "high": "135.27", "low": "128.30", "close": "135.25", "buy": '123', "sell": '0'},
  //   {"open": "134.94", "high": "137.24", "low": "132.63", "close": "135.03", "buy": '123', "sell": '0'},
  //   {"open": "136.76", "high": "136.86", "low": "132.00", "close": "134.01", "buy": '123', "sell": '0'},
  //   {"open": "131.11", "high": "133.00", "low": "125.09", "close": "126.39", "buy": '123', "sell": '0'},
  //   {"open": "123.12", "high": "127.75", "low": "120.30", "close": "125.00", "buy": '123', "sell": '0'},
  //   {"open": "128.32", "high": "129.35", "low": "126.50", "close": "127.79", "buy": '123', "sell": '0'},
  //   {"open": "128.29", "high": "128.30", "low": "123.71", "close": "124.03", "buy": '123', "sell": '0'},
  //   {"open": "131.11", "high": "133.00", "low": "125.09", "close": "126.39", "buy": '123', "sell": '0'},
  //   {"open": "123.12", "high": "127.75", "low": "120.30", "close": "125.00", "buy": '123', "sell": '0'},
  //   {"open": "128.32", "high": "129.35", "low": "126.50", "close": "127.79", "buy": '123', "sell": '0'},
  //   {"open": "128.29", "high": "128.30", "low": "123.71", "close": "124.03", "buy": '123', "sell": '0'},
  //   {"open": "160.00", "high": "120.00", "low": "110.00", "close": "167.00", "buy": '123', "sell": '0'},
  //   {"open": "135.26", "high": "135.95", "low": "131.50", "close": "131.85", "buy": '123', "sell": '0'}
  // ];

  // xepData.forEach(function(ele, i) {
  //   var $tr = $('.table-borderd tbody tr').eq(i);
  //   $tr.find('#xep_logs__open').val(ele.open);
  //   $tr.find('#xep_logs__close').val(ele.close);
  //   $tr.find('#xep_logs__high').val(ele.high);
  //   $tr.find('#xep_logs__low').val(ele.low);
  //   $tr.find('#xep_logs__buy').val(ele.buy);
  //   $tr.find('#xep_logs__sell').val(ele.sell);
  // });
});
