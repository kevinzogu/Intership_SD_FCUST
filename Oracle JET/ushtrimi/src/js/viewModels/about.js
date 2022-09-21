/**
 * @license
 * Copyright (c) 2014, 2022, Oracle and/or its affiliates.
 * Licensed under The Universal Permissive License (UPL), Version 1.0
 * as shown at https://oss.oracle.com/licenses/upl/
 * @ignore
 */
/*
 * Your about ViewModel code goes here
 */
define([
  "knockout",
  "ojs/ojtable"
],
 function(ko) {
    function AboutViewModel() {
      "use strict";
      
      class ViewModel {
          constructor() {
              this.deptArray = JSON.parse(deptData);
              this.dataprovider = new ArrayDataProvider(this.deptArray, {
                  keyAttributes: "DepartmentId",
                  implicitSort: [{ attribute: "DepartmentId", direction: "ascending" }],
              });
          }
      }
    }
    /*
     * Returns an instance of the ViewModel providing one instance of the ViewModel. If needed,
     * return a constructor for the ViewModel so that the ViewModel is constructed
     * each time the view is displayed.
     */
    return AboutViewModel;
  }
);
