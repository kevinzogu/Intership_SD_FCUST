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
"ojs/ojinputtext",
"ojs/ojdatetimepicker",
"ojs/ojinputnumber",
"ojs/ojformlayout",
"ojs/ojlabelvalue",
"ojs/ojlabel",
"ojs/ojselectsingle",
"ojs/ojbutton"
],
  (ko,
    ArrayDataProvider) => {
    function CustomerViewModel() {
      this._initValirable();
      this._initAllObservable();
      this.onCreateButtonClick=this._onCreateButtonClick.bind(this);
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
    }

    /**
 * @function
 * @description all the variable
 */

    CustomerViewModel.prototype._initValirable = function(){
this.inputGenderDataProviter=new ArrayDataProvider([
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
    alert("Button pressed");
    }

    return CustomerViewModel;
  }
);
