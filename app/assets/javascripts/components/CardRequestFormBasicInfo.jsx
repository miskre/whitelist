class CardRequestFormBasicInfo extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const {
      userDetail,
      handleClickUserDetialAcceptTermsAndConditions,
      errorMessages
    } = this.props;

    return (
      <div>
        {/* <div className='row'>
          <div className='col-sm-6'>
            <div className='form-group'>
              <label htmlFor='userDetailCurrency'>通貨</label>
              <input
                type='text'
                className='form-control'
                id='userDetailCurrency'
                value='USD'
                disabled={true}/>
            </div>
          </div>
        </div>
        */}
        <div className='row'>
          <div className='col-sm-3'>
          </div>
          <div className='col-sm-6'>
            <div className='form-group'>
              <p className='text-danger'>{errorMessages.userDetail.acceptTermsAndConditions}</p>
              <input
                type='checkbox'
                className='form-control ag-check02'
                id='userDetailAcceptTermsAndConditions'
                checked={userDetail.acceptTermsAndConditions}
                onClick={handleClickUserDetialAcceptTermsAndConditions.bind(this)}/>
              <div className='m-l-lg'>{I18n.t('components.prepaid_card.terms01')}<a href='/Revollet_Cardholder_Agreement.pdf' target='_blank'>{I18n.t('components.prepaid_card.terms02')}</a>{I18n.t('components.prepaid_card.terms03')}</div>
              <br />
            </div>
          </div>
          <div className='col-sm-3'>
          </div>
        </div>
      </div>
    );
  }
}
