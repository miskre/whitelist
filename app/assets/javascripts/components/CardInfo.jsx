class CardInfo extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div className='ibox float-e-margins'>
        <div className='ibox-title'>
          <h5>{I18n.t('components.prepaid_card.item')}</h5>
        </div>

        <div className='ibox-content'>
          <div className='row'>
            <CardDisplay cardDetail={this.props.cardDetail}/>
          </div>

          <div className='row p-sm'>
            <p className='text-center border-bottom p-xxs table-confirm'>
              <span className='ic-size m-r'>{I18n.t('components.prepaid_card.balance')}：</span>
              <span className='ic-size font-bold'>{this.props.cardBalance.avlBal}</span>
            </p>
          </div>
        </div>
      </div>
    );
  }
}
