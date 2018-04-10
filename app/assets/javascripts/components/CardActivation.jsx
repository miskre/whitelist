class CardActivation extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      submitDisabled: true,
      lastFourDigits: '',
      errorMessage: ''
    };
  }

  componentDidMount() {
    this.enableSubmit();
  }

  toggleActivationForm(e) {
    e.preventDefault();
    this.clearLastFourDigits();
  }

  clearLastFourDigits() {
    this.setState({lastFourDigits: ''});
  }

  handleChangeLastFourDigit(e) {
    this.setState({lastFourDigits: e.target.value});
  }

  validateInput() {
    this.setState({errorMessage: this.errorMessage()});
  }

  errorMessage() {
    const { lastFourDigits } = this.state;
    if(lastFourDigits === '') {
      return '*入力してください';
    } else if (lastFourDigits.length !== 4) {
      return '*4ケタで入力してください';
    } else if (!Number(lastFourDigits)) {
      return '数字のみ有効です';
    } else {
      return '';
    }
  }

  disableSubmit() {
    this.setState({submitDisabled: true});
  }

  enableSubmit() {
    this.setState({submitDisabled: false});
  }

  handleSubmitActivationForm(e) {
    e.preventDefault();

    this.disableSubmit();
    this.validateInput();

    setTimeout(this.postActivationForm.bind(this), 10);
  }

  inputErrorExists() {
    return this.state.errorMessage !== '';
  }

  postActivationForm() {
    if(this.inputErrorExists()) {
      this.enableSubmit();
      return alert('入力事項を確認してください');
    }

    $.ajax({
      type: 'POST',
      url: 'prepaid_cards/activate',
      dataType: 'json',
      data: {lastFourDigits: this.state.lastFourDigits},
      success: this.handlePostActivationSuccess.bind(this),
      error: this.handlePostActivationError.bind(this)
    });
  }

  handlePostActivationSuccess(data) {
    const { cardDetail } = this.props;
    console.log(data);

    this.props.updateCardDetail({
      ...cardDetail,
      pan: data.pan,
      cardStatus: data.newStatus
    });
  }

  handlePostActivationError(err) {
    this.enableSubmit();
    console.log(err.status, err.statusText);
    alert('問題が発生しました');
  }

  render() {
    const { submitDisabled, lastFourDigits, errorMessage } = this.state;
    return (
      <div className='ibox float-e-margins'>
        <div className='ibox-title'>
          <h5>{I18n.t('components.prepaid_card.activation')}</h5>
        </div>

        <div className='ibox-content'>
          <div className='row'>
            <div className='text-center m-b-md'>
              <p>
                {I18n.t('components.prepaid_card.comment05')}
                <br />
                {I18n.t('components.prepaid_card.comment06')}
              </p>
            </div>

            <div className='text-center'>
              <form onSubmit={this.handleSubmitActivationForm.bind(this)}>
                <div className='form-group'>
                  <p className='text-danger'>{errorMessage}</p>
                  <input
                    type='text'
                    id='lastFourDigits'
                    className='form-control'
                    value={lastFourDigits}
                    placeholder='例) 1234'
                    onChange={this.handleChangeLastFourDigit.bind(this)} />
                </div>

                <div className='text-center'>
                  <input
                    type='submit'
                    className='btn btn-revo'
                    value={I18n.t('components.prepaid_card.activation_button')}
                    disabled={submitDisabled}/>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
