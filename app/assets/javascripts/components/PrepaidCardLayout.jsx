class PrepaidCardLayout extends React.Component {
  constructor(props) {
    super(props);
    I18n.locale = props.locale;

    this.state = {
      showCreateRequestForm: props.showCreateRequestForm,
      cardDetail: props.cardDetail || {},
      usdBalance: props.usdBalance,
      cardBalance: props.cardBalance || {}
    };
  }

  updateCardDetail(cardDetail) {
    this.setState({cardDetail: cardDetail});
  }

  updateCardBalance(cardBalance) {
    this.setState({cardBalance: cardBalance});
  }

  updateUSDBalance(usdBalance) {
    this.setState({usdBalance: usdBalance});
  }

  hideCardCreateRequestForm() {
    this.setState({showCreateRequestForm: false});
  }

  render() {
    const { showCreateRequestForm, cardDetail, usdBalance, cardBalance } = this.state;
    const createRequest = showCreateRequestForm ?
      <CardRequestLayout
        currentPage={this.props.currentPage}
        standardIssuanceFee={this.props.standardIssuanceFee}
        expressIssuanceFee={this.props.expressIssuanceFee}
        usdBalance={usdBalance}
        hideCardCreateRequestForm={this.hideCardCreateRequestForm.bind(this)}
        updateCardDetail={this.updateCardDetail.bind(this)}
        updateCardBalance={this.updateCardBalance.bind(this)} /> :
      <CardItem
        currentPage={this.props.currentPage}
        cardDetail={cardDetail}
        cardBalance={cardBalance}
        usdBalance={usdBalance}
        updateCardDetail={this.updateCardDetail.bind(this)}
        updateCardBalance={this.updateCardBalance.bind(this)}
        updateUSDBalance={this.updateUSDBalance.bind(this)} />;

    return (
      <div>
        <div className='row wrapper border-bottom page-heading'>
          <div className='col-lg-10'>
            <h2>カード関連</h2>
          </div>
          <div className='col-lg-2'></div>
        </div>

        <div className='wrapper wrapper-content animated fadeInRight'>
          {createRequest}
        </div>
      </div>
    );
  }
}
