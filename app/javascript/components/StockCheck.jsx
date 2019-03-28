import React from 'react';
import { Card } from 'react-bootstrap';


class StockCheck extends React.Component {
  constructor(props, context) {
    super(props, context);
  }

  render() {
    return (
      <Card>
        <Card.Body>
          <Card.Title>{this.props.code}</Card.Title>
          <Card.Text>
            <b>Quantity scanned:</b> {this.props.scanned}<br/>
            <b>Quantity in warehouse:</b> {this.props.stored}<br/>
          </Card.Text>
        </Card.Body>
      </Card>
    );
  }
}

export default StockCheck;