import React, { Component } from 'react';
import Quagga from 'quagga';

class BarcodeForm extends Component {
  componentDidMount() {
    function order_by_occurrence(arr) {
      var counts = {};
      arr.forEach(function(value){
        if(!counts[value]) {
          counts[value] = 0;
        }
        counts[value]++;
      });

      return Object.keys(counts).sort(function(curKey,nextKey) {
        return counts[curKey] < counts[nextKey];
      });
    }

    if (navigator.mediaDevices && typeof navigator.mediaDevices.getUserMedia === 'function') {
      var last_result = [];
      if (Quagga.initialized == undefined) {
        Quagga.onDetected(function(result) {
          var last_code = result.codeResult.code;
          last_result.push(last_code);
          if (last_result.length > 3) {
            let code = order_by_occurrence(last_result)[0];
            last_result = [];
            Quagga.stop();
            $.ajax({
              type: "POST",
              url: '/items/get_barcode',
              data: { upc: code }
            });
          }
        });
      }

      Quagga.init({
        inputStream : {
          name : "Live",
          type : "LiveStream",
          numOfWorkers: navigator.hardwareConcurrency,
          target: document.querySelector('#barcode-reader-container')
        },
        debug: true,
        decoder: {
          readers : ['ean_reader']
        }
      },function(err) {
        if (err) { console.log(err); return }
        Quagga.initialized = true;
        Quagga.start();
      });
    }
  }

  render() {
    return (
      <div className="App">
        <div className="App-header">
          <div id="barcode-reader-container" />
        </div>
      </div>
    );
  }
}
export default BarcodeForm;