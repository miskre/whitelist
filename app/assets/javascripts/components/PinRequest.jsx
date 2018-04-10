class PinRequest extends React.Component {
  componentDidMount() {
    // wc_cors.init('https://wcapi.wavecrest.in');
    wc_cors.init('https://api.wavecrest.gi');
  }

  postCORSToken() {
    $.ajax({
      type: 'POST',
      url: 'prepaid_cards/cors_token',
      dataType: 'json',
      data: {operation: 'viewPin'},
      success: this.getPIN.bind(this),
      error: this.handlePostCORSTokenFailed.bind(this)
    });
  }

  handlePostCORSTokenFailed(xhr) {
    const error = JSON.parse(xhr.responseText).errorMessage;
    alert(error);
  }

  getPIN(data) {
    console.log(data.corsToken);
    wc_cors.getCardData(data.corsToken);
  }

  handleClickWcCORS(e) {
    e.preventDefault();
    this.postCORSToken();
  }

  render() {
    return (
       <div className='ibox float-e-margins'>
         <div className='ibox-title'>
           <h5>{I18n.t('components.prepaid_card.pin_code')}</h5>
         </div>

         <div className='ibox-content'>
           <div className='row'>
             <div className='text-center m-b-md'>
               <p>
                 {I18n.t('components.prepaid_card.comment07')}
               </p>
             </div>

             <div className='text-center'>
               <div>
                 <div id='wc_cors_wrap'>
                    <button id='wc_cors_button'
                      type='button'
                      className='btn btn-revo'
                      onClick={this.handleClickWcCORS.bind(this)}>{I18n.t('components.prepaid_card.get_pin')}</button>
                 </div>
               </div>
             </div>
           </div>
         </div>
       </div>
    );
  }
}
