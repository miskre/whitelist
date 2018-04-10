class InsufficientUSDBalance extends React.Component {
  render() {
    return (
      <div className='ibox-content'>
        <div className='row'>
          <div className='col-sm-12'>
            <h4 className='m-b'>{'<注意>'}</h4>
            <p className='m-b-lg'>カード発行には50 USD以上のデポジットが必要です</p>
          </div>
        </div>

        <div className='row'>
          <div className='col-sm-12'>
            <h4 className='m-b'>{'<カード発行手数料>'}</h4>
          </div>
        </div>

        <div className='row'>
          <div className='col-sm-6'>
            <p className='m-b-lg'>スタンダード発送: 50 USD</p>
          </div>

          <div className='col-sm-6'>
            <p className='m-b-lg'>エクスプレス発送: 85 USD</p>
          </div>
        </div>
      </div>
    );
  }
}
