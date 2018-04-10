class CardDisplay extends React.Component {
  constructor(props)  {
    super(props);
  }

  render() {
    const { pan, expiryDate, nameOnCard, cvv, cardStatus } = this.props.cardDetail;

    return (
      <div className='flip-container'>
        <div className='flipper'>
          <div className='front'>
            <div className='card'>
              <div className='card__sim'></div>
              <div className='card__number'>{pan}</div>
              <div className='card__little-letter'>VALID THRU</div>
              <div className='card__expiration'>{expiryDate}</div>
              <div className='card__name'>{nameOnCard}</div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
