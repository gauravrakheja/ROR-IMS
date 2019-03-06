import React from 'react';
import { Button, Modal } from 'react-bootstrap';
import BarcodeForm from './BarcodeForm';

class BarcodeModal extends React.Component {
  constructor(props, context) {
    super(props, context);

    this.handleShow = this.handleShow.bind(this);
    this.handleClose = this.handleClose.bind(this);
    this.handleUpdate = this.handleUpdate.bind(this);

    this.state = {
      show: false
    };
  }

  handleClose() {
    this.setState({ show: false });
  }

  handleShow() {
    this.setState({ show: true });
  }

  handleUpdate(code){
    if(this.state.show === true){
      let inputCode   = document.getElementById("code");
      let inputChange = document.getElementById("change");
      let barCodeForm = document.getElementById("get-code-form");

      inputCode.value   = code;
      inputChange.value = this.props.change;

      barCodeForm.submit();
    }
  }

  render() {
    return (
      <div className="full-height">
        <Button variant={this.props.buttonClass} onClick={this.handleShow}>
          {this.props.buttonTitle}
        </Button>

        <Modal show={this.state.show} onHide={this.handleClose}>
          <Modal.Header closeButton>
            <Modal.Title>{this.props.heading}</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <BarcodeForm
              container  = {this.props.container}
              change     = {this.props.change}
              updateCode = {this.handleUpdate}
            />
          </Modal.Body>
        </Modal>
      </div>
    );
  }
}

export default BarcodeModal;