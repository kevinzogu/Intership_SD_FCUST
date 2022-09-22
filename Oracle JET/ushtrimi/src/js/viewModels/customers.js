/**
 * @license
 * Copyright (c) 2014, 2022, Oracle and/or its affiliates.
 * Licensed under The Universal Permissive License (UPL), Version 1.0
 * as shown at https://oss.oracle.com/licenses/upl/
 * @ignore
 */
/*
 * Your customer ViewModel code goes here
 */
define([
"knockout",
"ojs/ojarraydataprovider",
"ojs/ojbootstrap",
"ojs/ojbufferingdataprovider",
"ojs/ojinputtext",
"ojs/ojdatetimepicker",
"ojs/ojinputnumber",
"ojs/ojformlayout",
"ojs/ojlabelvalue",
"ojs/ojlabel",
"ojs/ojselectsingle",
"ojs/ojbutton",
"ojs/ojtable"
],
  (ko,
    ArrayDataProvider,
    ojbootstrap_1,
    BufferingDataProvider) => {
    function CustomerViewModel() {
      this._initValirable();
      this._initAllObservable();
      this.onCreateButtonClick=this._onCreateButtonClick.bind(this);
      (0, ojbootstrap_1.whenDocumentReady)().then(() => {
        const vm = new CustomerViewModel();
        ko.applyBindings(vm, document.getElementById('table'));
    });
    }

/**
 * @function
 * @description all the observable values
 */

    CustomerViewModel.prototype._initAllObservable = function(){
      this.inputNameValue = ko.observable(null);
      this.inputSurnameValue = ko.observable(null);
      this.inputBirthdayValue = ko.observable(null);
      this.inputAgeValue = ko.observable(null);
      this.inputBirthplaceValue = ko.observable(null);
      this.inputGenderValue = ko.observable(null);
      this.onCreateButtonClick = ko.observable(null);
      
      this.dataFromSave = ko.observableArray([]);
      this.dataprovider = new BufferingDataProvider(new ArrayDataProvider(this.dataFromSave, {
        keyAttributes: 'emri'
    }));
    }

    /**
 * @function
 * @description all the variable
 */

    CustomerViewModel.prototype._initValirable = function(){
this.inputGenderDataProvider=new ArrayDataProvider([
  {
  value: "djale",
  label: "Mashkull"
  },
  {
    value: "vajze",
    label: "Femer"
  }
], {
  keyAttributes: "value",
});
    }

        /**
 * @function
 * @description save information
 */

    CustomerViewModel.prototype._onCreateButtonClick = function(){
      
      let dataFromSave = [{
      emri: this.inputNameValue(),
      mbiemri : this.inputSurnameValue(),
      ditelindja : this.inputBirthdayValue(),
      gjinia : this.inputGenderValue(),
      vendlindja : this.inputBirthplaceValue(),
      mosha : this.inputAgeValue()
    }];
    
    alert("Button pressed");

    console.log(dataFromSave);

    this.dataprovider.addItem({
      metadata: { key: this.dataFromSave.emri },
      data: this.dataFromSave
  });
    // this.arraytojson = JSON.parse(dataFromSave);
  }
  
    return new CustomerViewModel();
  }
);
