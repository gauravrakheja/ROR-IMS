import React from 'react';


class StockCheckReport extends React.Component {
  constructor(props, context) {
    super(props, context);
    this.state = {
      stockChecks: []
    }
  }

  render() {
    return (
      <div id="new_stock_check_report">
      </div>
    );
  }
}

export default StockCheckReport;