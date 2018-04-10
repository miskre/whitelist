class CardRequestLayout extends React.Component {
  constructor(props) {
    super(props);
  }

  cnvtStrUSDToInt(str) {
    return Number(str.substring(2).replace(/,/g, '').replace('.', ''));
  }

  render() {
    const { currentPage, usdBalance, hideCardCreateRequestForm, updateCardDetail, updateCardBalance } = this.props;
    const content = this.cnvtStrUSDToInt(usdBalance) >= 5000 ?
      <CardRequestForm
        standardIssuanceFee={this.props.standardIssuanceFee}
        expressIssuanceFee={this.props.expressIssuanceFee}
        currentPage={currentPage}
        usdBalance={usdBalance}
        hideCardCreateRequestForm={hideCardCreateRequestForm.bind(this)}
        updateCardDetail={updateCardDetail.bind(this)}
        updateCardBalance={updateCardBalance.bind(this)}
        cnvtStrUSDToInt={this.cnvtStrUSDToInt.bind(this)}/> :
      <InsufficientUSDBalance />;

    return (
      <div className='row'>
        <div className='col-lg-9'>
          <div className='ibox float-e-margins'>
            <div className='ibox-title'>
              <h5>{I18n.t('components.prepaid_card.create_card')}</h5>
            </div>

            {content}
          </div>
        </div>
      </div>
    );
  }
}
