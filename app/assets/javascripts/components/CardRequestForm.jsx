class CardRequestForm extends React.Component {
  constructor(props) {
    super(props);
    STANDARD_DELIVERY = 0;
    EXPRESS_DELIVERY = 1;
    WALLET = 'wallet';
    OPERATOR = 'operator';

    this.state = {
      submitDisabled: true,
      newCardReqInfo: {
        userDetail: {
          acceptTermsAndConditions: false,
          acceptEsign: false
        },
        deliveryType: null,
        dlvAddress: {
          addressLineOne: '',
          city: '',
          zipCode: '',
          country: ''
        }
      },
      errorMessages: {
        userDetail: {
          acceptTermsAndConditions: ''
        },
        deliveryType: '',
        dlvAddress: {
          addressLineOne: '',
          city: '',
          zipCode: '',
          country: ''
        }
      }
    };
  }

  componentDidMount() {
    this.enableSubmit();
  }

  handleClickUserDetialAcceptTermsAndConditions() {
    const userDetail = {...this.state.newCardReqInfo.userDetail, acceptTermsAndConditions: !this.state.newCardReqInfo.userDetail.acceptTermsAndConditions};
    const newCardReqInfo = {...this.state.newCardReqInfo, userDetail: userDetail};

    this.setState({newCardReqInfo: newCardReqInfo});
  }

  handleClickDeliveryTypeStandard() {
    const { usdBalance, cnvtStrUSDToInt } = this.props;

    if(cnvtStrUSDToInt(usdBalance) < 5000) {
      return alert('USD残高が不足しています');
    }

    const newCardReqInfo = {...this.state.newCardReqInfo, deliveryType: STANDARD_DELIVERY}
    this.setState({newCardReqInfo: newCardReqInfo});
  }

  handleClickDeliveryTypeExpress() {
    const { usdBalance, cnvtStrUSDToInt } = this.props;
    if(cnvtStrUSDToInt(usdBalance) < 8500) {
      return alert('USD残高が不足しています');
    }

    const newCardReqInfo = {...this.state.newCardReqInfo, deliveryType: EXPRESS_DELIVERY}
    this.setState({newCardReqInfo: newCardReqInfo});
  }

  handleChangeDlvAddressAddressLineOne(e) {
    const dlvAddress = {...this.state.newCardReqInfo.dlvAddress, addressLineOne: e.target.value};
    const newCardReqInfo = {...this.state.newCardReqInfo, dlvAddress: dlvAddress};
    this.setState({newCardReqInfo: newCardReqInfo});
  }

  handleChangeDlvAddressCity(e) {
    const dlvAddress = {...this.state.newCardReqInfo.dlvAddress, city: e.target.value};
    const newCardReqInfo = {...this.state.newCardReqInfo, dlvAddress: dlvAddress};
    this.setState({newCardReqInfo: newCardReqInfo});
  }

  handleChangeDlvAddressZipCode(e) {
    const dlvAddress = {...this.state.newCardReqInfo.dlvAddress, zipCode: e.target.value};
    const newCardReqInfo = {...this.state.newCardReqInfo, dlvAddress: dlvAddress};
    this.setState({newCardReqInfo: newCardReqInfo});
  }

  handleChangeDlvAddressCountry(e) {
    const dlvAddress = {...this.state.newCardReqInfo.dlvAddress, country: e.target.value};
    const newCardReqInfo = {...this.state.newCardReqInfo, dlvAddress: dlvAddress};
    this.setState({newCardReqInfo: newCardReqInfo});
  }

  isOperator() {
    return this.props.currentPage === OPERATOR;
  }

  isWallet() {
    return this.props.currentPage === WALLET;
  }

  urlForPostUserAddress() {
    const path = window.location.pathname;
    return path + '/user_address';
  }

  handleClickCopyAddress(e) {
    e.preventDefault();
    $.ajax({
      type: 'POST',
      url: this.urlForPostUserAddress(),
      dataType: 'json',
      success: data => {
        const newCardReqInfo = {...this.state.newCardReqInfo, dlvAddress: data.userAddress}
        this.setState({newCardReqInfo: newCardReqInfo})
      },
      error: err => {
        console.log(err);
      }
    });
  }

  validateInputs() {
    const errorMessages = {
      userDetail: {
        acceptTermsAndConditions: this.errorMessageForUserAcceptTermsAndConditions()
      },
      deliveryType: this.errorMessageForDeliveryType(),
      dlvAddress: {
        addressLineOne: this.errorMessageForDlvAddressAddressLineOne(),
        city: this.errorMessageForDlvAddressCity(),
        zipCode: this.errorMessageForDlvAddressZipCode(),
        country: this.errorMessageForDlvAddressCountry()
      }
    }

    this.setState({errorMessages: errorMessages});
  }

  errorMessageForUserAcceptTermsAndConditions() {
    const { acceptTermsAndConditions } = this.state.newCardReqInfo.userDetail;
    return acceptTermsAndConditions ? '' : '*同意が必要です';
  }

  errorMessageForDeliveryType() {
    const { deliveryType } = this.state.newCardReqInfo;
    return deliveryType === null ? '*選択してください' : '';
  }

  errorMessageForDlvAddressAddressLineOne() {
    const { addressLineOne } = this.state.newCardReqInfo.dlvAddress;
    if(addressLineOne === '') {
      return '*入力してください';
    } else if(addressLineOne.length < 1 || 35 < addressLineOne.length) {
      return '*1-35ケタ以内で入力してください';
    } else {
      return '';
    }
  }

  errorMessageForDlvAddressCity() {
    const { city } = this.state.newCardReqInfo.dlvAddress;
    if(city === '') {
      return '*入力してください';
    } else if(city.length < 1 || 20 < city.length) {
      return '*1-20ケタ以内で入力してください';
    } else {
      return '';
    }
  }

  errorMessageForDlvAddressZipCode() {
    const { zipCode } = this.state.newCardReqInfo.dlvAddress;
    if(zipCode === '') {
      return '*入力してください';
    } else if(zipCode.length < 3 || 8 < zipCode.length) {
      return '*3-8ケタ以内で入力してください';
    } else {
      return '';
    }
  }

  errorMessageForDlvAddressCountry() {
    const { country } = this.state.newCardReqInfo.dlvAddress;
    if(country === '') {
      return '*入力してください';
    } else if(country.length !== 2) {
      return '*2文字で入力してください';
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

  handleSubmitNewCard(e) {
    e.preventDefault();

    this.disableSubmit();
    this.validateInputs();

    setTimeout(this.postNewCard.bind(this), 10);
  }

  inputErrorExists() {
    const { userDetail, dlvAddress } = this.state.errorMessages;
    const { acceptTermsAndConditions } = userDetail;
    const { addressLineOne, city, zipCode, country } = dlvAddress;

    return acceptTermsAndConditions !== '' ||
           addressLineOne           !== '' ||
           city                     !== '' ||
           zipCode                  !== '' ||
           country                  !== '';
  }

  urlForPostNewCard() {
    const path = window.location.pathname;

    if(this.isWallet()) {
      return path;
    } else if(this.isOperator()) {
      return path + '/create_card';
    }
  }

  postNewCard() {
    if(this.inputErrorExists()) {
      this.enableSubmit();
      return alert('入力事項を確認してください')
    };

    $.ajax({
      type: 'POST',
      url: this.urlForPostNewCard(),
      dataType: 'json',
      data: this.state.newCardReqInfo,
      success: this.handlePostNewCardSuccess.bind(this),
      error: this.handlePostNewCardError.bind(this)
    });
  }

  handlePostNewCardSuccess(data) {
    console.log(data);
    if(!data.cardDetail) return alert('問題が発生しました');;
    this.props.hideCardCreateRequestForm();
    this.props.updateCardDetail(data.cardDetail);
    this.props.updateCardBalance(data.cardBalance);
  }

  handlePostNewCardError(err) {
    this.enableSubmit();
    alert('問題が発生しました');
  }

  render() {
    const { submitDisabled, newCardReqInfo, errorMessages } = this.state;
    const { userDetail, deliveryType, dlvAddress } = newCardReqInfo;

    return (
      <div className='ibox-content'>
        <form onSubmit={this.handleSubmitNewCard.bind(this)}>
          <div className='row'>
            <div className='col-sm-12'>
              <p className='m-b-lg'>{I18n.t('components.prepaid_card.comment01')}</p>
            </div>
          </div>

          <CardRequestFormDlvInfo
            standardIssuanceFee={this.props.standardIssuanceFee}
            expressIssuanceFee={this.props.expressIssuanceFee}
            submitDisabled={submitDisabled}
            deliveryType={deliveryType}
            dlvAddress={dlvAddress}
            handleClickDeliveryTypeStandard={this.handleClickDeliveryTypeStandard.bind(this)}
            handleClickDeliveryTypeExpress={this.handleClickDeliveryTypeExpress.bind(this)}
            handleChangeDlvAddressAddressLineOne={this.handleChangeDlvAddressAddressLineOne.bind(this)}
            handleChangeDlvAddressCity={this.handleChangeDlvAddressCity.bind(this)}
            handleChangeDlvAddressZipCode={this.handleChangeDlvAddressZipCode.bind(this)}
            handleChangeDlvAddressCountry={this.handleChangeDlvAddressCountry.bind(this)}
            handleClickCopyAddress={this.handleClickCopyAddress.bind(this)}
            errorMessages={errorMessages} />

          <hr/>

          <CardRequestFormBasicInfo
            userDetail={userDetail}
            handleClickUserDetialAcceptTermsAndConditions={this.handleClickUserDetialAcceptTermsAndConditions.bind(this)}
            errorMessages={errorMessages} />

          <div className='text-center'>
            <input
              type='submit'
              className='btn btn-revo'
              value={I18n.t('components.prepaid_card.apply')}
              disabled={submitDisabled}/>
          </div>
        </form>
      </div>
    );
  }
}
