class CardRequestFormDlvInfo extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const {
      submitDisabled,
      deliveryType,
      dlvAddress,
      handleClickDeliveryTypeStandard,
      handleClickDeliveryTypeExpress,
      handleChangeDlvAddressAddressLineOne,
      handleChangeDlvAddressCity,
      handleChangeDlvAddressZipCode,
      handleChangeDlvAddressCountry,
      handleClickCopyAddress,
      errorMessages
    } = this.props;

    return (
      <div>
        <div className='row'>
          <div className='col-sm-6'>
            <h4 className='m-b'>{I18n.t('components.prepaid_card.divinfo')}</h4>
          </div>
        </div>

        <div className='row'>
          <div className='col-sm-6'>
            <p>・{I18n.t('components.prepaid_card.comment02')}</p>
            <p className='text-danger'>{errorMessages.deliveryType}</p>
          </div>
        </div>

        <div className='row m-t-md'>
          <div className='col-sm-6'>
            <div
              className='form-group table-bordered p-sm'
              onClick={handleClickDeliveryTypeStandard.bind(this)}>
              <input
                type='radio'
                className=''
                id='deliveryTypeStandard'
                checked={deliveryType === STANDARD_DELIVERY}
                readOnly={true}/>
              <label
                htmlFor='deliveryTypeStandard'
                className='m-l-md'>
                {I18n.t('components.prepaid_card.standard')}
              </label>
              <br />
              <div className='m-t-sm top-border'>
                <u>◎{I18n.t('components.prepaid_card.fee')}</u>
                <br />
                $ {this.props.standardIssuanceFee}
              </div>
              <br />
              <div>
                <u>◎{I18n.t('components.prepaid_card.shipping')}</u>
                <br />
                {I18n.t('components.prepaid_card.standard_ship')}
              </div>
            </div>
          </div>

          <div className='col-sm-6'>
            <div
              className='form-group table-bordered p-sm'
              onClick={handleClickDeliveryTypeExpress.bind(this)}>
              <input
                type='radio'
                className=''
                id='deliveryTypeExpress'
                checked={deliveryType === EXPRESS_DELIVERY}
                readOnly={true}/>
              <label
                htmlFor='deliveryTypeExpress'
                className='m-l-md'>
                {I18n.t('components.prepaid_card.express')}
              </label>
              <br />
              <div className='m-t-sm top-border'>
                <u>◎{I18n.t('components.prepaid_card.fee')}</u>
                <br />
                $ {this.props.expressIssuanceFee}
              </div>
              <br />
              <div>
                <u>◎{I18n.t('components.prepaid_card.shipping')}</u>
                <br />
                {I18n.t('components.prepaid_card.express_ship')}
              </div>
            </div>
          </div>
        </div>

        <div className='row m-t-xl'>
          <div className='col-sm-6'>
            <p>・{I18n.t('components.prepaid_card.comment03')}</p>
          </div>
        </div>

        <div className='row m-t-md'>
          <div className='col-sm-4'>
            <div className='form-group'>
              <button
                className='form-control btn-solid-revo'
                onClick={handleClickCopyAddress.bind(this)}
                disabled={submitDisabled}>
                {I18n.t('components.prepaid_card.same_address')}
              </button>
            </div>
          </div>
        </div>

        <div className='row'>
          <div className='col-sm-6'>
            <div className='form-group'>
              <label htmlFor='dlvAddressAddressLineOne'>{I18n.t('components.prepaid_card.address01')}</label>
              <p className='text-danger'>{errorMessages.dlvAddress.addressLineOne}</p>
              <input
                type='text'
                className='form-control'
                id='dlvAddressAddressLineOne'
                value={dlvAddress.addressLineOne}
                placeholder=''
                onChange={handleChangeDlvAddressAddressLineOne.bind(this)}/>
            </div>
          </div>

          <div className='col-sm-6'>
            <div className='form-group'>
              <label htmlFor='dlvAddressCity'>{I18n.t('components.prepaid_card.address02')}</label>
              <p className='text-danger'>{errorMessages.dlvAddress.city}</p>
              <input
                type='text'
                className='form-control'
                id='dlvAddressCity'
                value={dlvAddress.city}
                placeholder=''
                onChange={handleChangeDlvAddressCity.bind(this)}/>
            </div>
          </div>
        </div>

        <div className='row'>
          <div className='col-sm-6'>
            <div className='form-group'>
              <label htmlFor='dlvAddressZipCode'>{I18n.t('components.prepaid_card.zip')}</label>
              <p className='text-danger'>{errorMessages.dlvAddress.zipCode}</p>
              <input
                type='text'
                className='form-control'
                id='dlvAddressZipCode'
                value={dlvAddress.zipCode}
                placeholder=''
                onChange={handleChangeDlvAddressZipCode.bind(this)}/>
            </div>
          </div>

          <div className='col-sm-6'>
            <div className='form-group'>
              <label htmlFor='dlvAddressCountry'>{I18n.t('components.prepaid_card.country')}</label>
              <p className='text-danger'>{errorMessages.dlvAddress.country}</p>
              <input
                type='text'
                className='form-control'
                id='dlvAddressCountry'
                value={dlvAddress.country}
                placeholder=''
                onChange={handleChangeDlvAddressCountry.bind(this)}/>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
