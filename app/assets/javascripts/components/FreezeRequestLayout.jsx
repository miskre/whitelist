class FreezeRequestLayout extends React.Component {
  constructor(props) {
    super(props);
  }

  handleSubmitFreezeRequest(e) {
    e.preventDefault();

    $.ajax({
      type: 'POST',
      url: 'prepaid_cards/change_status',
      dateType: 'json',
      data: {newStatus: ''},
      success: data => {

      },
      error: err => {

      }
    });
  }

  render() {
    return (
      <div className='row'>
        <div className='col-sm-12'>
          <div className='ibox float-e-margins'>
            <div className='ibox-title'>
              <h5>凍結</h5>
            </div>

            <div className='ibox-content'>
              <div className='row'>
                <form onSubmit={this.handleSubmitFreezeRequest.bind(this)}>
                  <div className='text-center m-b-md'>
                    <p>ボタンをクリックして頂くことでカードを凍結します。</p>
                  </div>

                  <div className='text-center'>
                    <select>
                      <option disabled selected value> -- 選択してください -- </option>
                      <option value='LOST'>紛失</option>
                      <option value='STOLEN'>盗難</option>
                      <option value='DAMAGED'>損害</option>
                      <option value='CLOSED'>永久に凍結</option>
                      <option value='SUSPENDED'>一時的に凍結</option>
                      <option value='DECEASED'>亡くなった</option>
                      <option value='UNSUSPEND'>一時的な凍結を解除</option>
                      <option value='ACTIVE'>アクティベート</option>
                    </select>
                  </div>

                  <div className='text-center'>
                    <input
                      type='submit'
                      className='btn btn-revo'
                      value='凍結する'/>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
