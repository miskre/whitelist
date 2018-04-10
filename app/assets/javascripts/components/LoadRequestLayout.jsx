class LoadRequestLayout extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { usdBalance, updateCardBalance, updateUSDBalance } = this.props;

    return (
      <div className='row'>
        <div className='col-sm-12'>
          <div className='ibox float-e-margins'>
            <div className='ibox-title'>
              <h5>{I18n.t('components.prepaid_card.charge')}</h5>
            </div>
            <div className='ibox-content'>
              <div className='row p-sm'>
                <LoadRequestForm
                  usdBalance={usdBalance}
                  updateCardBalance={updateCardBalance}
                  updateUSDBalance={updateUSDBalance}/>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
