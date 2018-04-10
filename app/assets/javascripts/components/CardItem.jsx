class CardItem extends React.Component {
  constructor(props) {
    super(props);
    OPERATOR = 'operator';
  }
  
  isActive() {
    return this.props.cardDetail.cardStatus === 'ACTIVE'
  }

  isOperator() {
    return this.props.currentPage === OPERATOR;
  }

  rightPanel() {
    if(this.isOperator()) return;
    const { cardDetail, usdBalance, updateCardDetail, updateCardBalance, updateUSDBalance } = this.props;

    return !this.isActive() ?
      <CardActivation
        cardDetail={cardDetail}
        updateCardDetail={updateCardDetail.bind(this)}/> :
      <LoadRequestLayout
        usdBalance={usdBalance}
        updateCardBalance={updateCardBalance}
        updateUSDBalance={updateUSDBalance.bind(this)}/> ;
  }

  render() {
    const { cardDetail, cardBalance } = this.props;
    const rightPanel = this.rightPanel();

    const pinRequest = this.isActive() && !this.isOperator() ?
      <div className='col-lg-6'>
        <PinRequest/>
      </div> : null;

    return (
      <div>
        <div className='row'>
          <div className='col-lg-6'>
            <CardInfo
              cardDetail={cardDetail}
              cardBalance={cardBalance}/>
          </div>

          <div className='col-lg-6'>
            {rightPanel}
          </div>
        </div>
       
        <div className='row'>
          {pinRequest}
        </div>

        <div className='row'>
          <div className='col-lg-12'>
            <p className='text-center'>The card is issued by Wave Crest Holdings Limited pursuant to a license from Visa Europe. Visa is a registered trademark of Visa Incorporated.<br /> Wave Crest Holdings Limited is a licensed electronic money institution by the Financial Services Commission, Gibraltar.<br />Copyright (c) 2016, All Rights Reserved</p>
          </div>
        </div>
      </div>
    );
  }
}
