import React from 'react';
import { Card } from 'react-bootstrap';

class NullStockCheck extends React.Component {
  constructor(props, context) {
    super(props, context);
  }

  render() {
    return (
      <Card>
        <Card.Body>
          <Card.Title>{this.props.code}</Card.Title>
          <Card.Text>
            Item with this code does not exist.
            <b>Quantity scanned:</b> {this.props.scanned}<br/>
          </Card.Text>
        </Card.Body>
      </Card>
    );
  }
}

export default NullStockCheck;