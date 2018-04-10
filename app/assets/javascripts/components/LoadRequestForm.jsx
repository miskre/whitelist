class LoadRequestForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      submitDisabled: true,
      transactionAmount: '',
      password: '',
      errorMessages: {
        transactionAmount: '',
        password: ''
      }
    };
  }

  componentDidMount() {
    this.enableSubmit();
  }

  handleChangeTransactionAmount(e) {
    this.setState({transactionAmount: e.target.value});
  }

  handleChangePassword(e) {
    this.setState({password: e.target.value});
  }

  disableSubmit() {
    this.setState({submitDisabled: true});
  }

  enableSubmit() {
    this.setState({submitDisabled: false});
  }

  clearInputs() {
    this.setState({transactionAmount: '', password: ''});
  }

  errorMessageForTransactionAmount() {
    const { transactionAmount } = this.state;
    if(transactionAmount === '') {
      return '*入力してください';
    } else if (!this.isInteger(transactionAmount)) {
      return '*整数のみ有効です';
    } else {
      return '';
    }
  }

  errorMessageForPassword() {
    const { password } = this.state;
    if(password === '') {
      return '*入力してください';
    } else {
      return '';
    } 
  }

  isInteger(str) {
    const n = ~~Number(str);
    return String(n) === str && n >= 0;
  }

  handleSubmitLoadForm(e) {
    e.preventDefault();

    this.disableSubmit();
    this.validateInputs(this.alertInputError.bind(this));

    setTimeout(this.confirmCardLoad.bind(this, this.postLoadForm.bind(this)), 100);
  }

  inputErrorExists() {
    const { transactionAmount, password } = this.state.errorMessages;
    return transactionAmount !== '' || 
           password          !== '';
  }

  validateInputs(callback) {
    const errorMessages = {
      transactionAmount: this.errorMessageForTransactionAmount(),
      password: this.errorMessageForPassword()
    };

    this.setState({errorMessages: errorMessages}, () => {
      if(callback && typeof(callback) === 'function') {
        callback();
      }
    });
  }

  alertInputError() {
    if(this.inputErrorExists()) {
      this.enableSubmit();
      return alert('入力事項を確認してください');
    }
  }

  confirmCardLoad(callback) {
    if(this.inputErrorExists()) return;
    
    const { transactionAmount } = this.state;
    if(!confirm(`${transactionAmount} USDをチャージします。よろしいでしょうか？`)) {
      return this.enableSubmit();
    }

    if(callback && typeof(callback) === 'function') {
      callback();
    }
  }

  dataForPostLoadForm() {
    const { transactionAmount, password } = this.state;
    return {
      transactionAmount: transactionAmount,
      password: password
    }
  }

  postLoadForm() {
    $.ajax({
      type: 'POST',
      url: 'prepaid_cards/load',
      dataType: 'json',
      data: this.dataForPostLoadForm(),
      success: this.handlePostLoadSuccess.bind(this),
      error: this.handlePostLoadError.bind(this)
    });
  }

  handlePostLoadSuccess(data) {
    console.log(data);
    this.props.updateCardBalance(data.cardBalance);
    this.props.updateUSDBalance(data.usdBalance);
    this.clearInputs();
    this.enableSubmit();
  }

  handlePostLoadError(xhr) {
    this.enableSubmit();
    const err = JSON.parse(xhr.responseText).errorMessage;
    alert(err);
  }

  render() {
    const { submitDisabled, transactionAmount, password, errorMessages } = this.state;

    return (
      <form onSubmit={this.handleSubmitLoadForm.bind(this)}>
        <div className='form-group'>
          <p className='m-b-lg'>{I18n.t('components.prepaid_card.comment04')}</p>
          <div className='row'>
            <div className='col-sm-6'>
              <label htmlFor='usdBalance'>{I18n.t('components.prepaid_card.usd_balance')}</label>
              <div className='form-control m-t-sm'>{this.props.usdBalance}</div>
            </div>

            <div className='col-sm-6'>
              <label htmlFor='transactionAmount'>{I18n.t('components.prepaid_card.amount')} (USD)</label>
              <p className='text-danger'>{errorMessages.transactionAmount}</p>
              <input
                type='text'
                className='form-control'
                id='transactionAmount'
                value={transactionAmount}
                placeholder={I18n.t('components.prepaid_card.amount_example')}
                onChange={this.handleChangeTransactionAmount.bind(this)}/>
            </div>
          </div>

          <div className='row'>
            <div className='col-sm-6 m-t'>
              <label htmlFor='password'>{I18n.t('components.prepaid_card.password')}</label>
              <p className='text-danger'>{errorMessages.password}</p>
              <input
                type='password'
                className='form-control'
                id='password'
                value={password}
                onChange={this.handleChangePassword.bind(this)}/>
            </div>
          </div>

          <div className='text-center m-t'>
            <input
              type='submit'
              className='btn btn-revo'
              value={I18n.t('components.prepaid_card.reload')}
              disabled={submitDisabled}/>
          </div>
        </div>
      </form>
    );
  }
}
