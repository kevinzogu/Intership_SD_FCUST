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
  "ojs/ojbufferingdataprovider",
  "ojs/ojinputtext",
  "ojs/ojdatetimepicker",
  "ojs/ojinputnumber",
  "ojs/ojformlayout",
  "ojs/ojlabelvalue",
  "ojs/ojlabel",
  "ojs/ojselectsingle",
  "ojs/ojbutton",
  "ojs/ojtable",
  "ojs/ojchart"
  ],
    (ko,
      ArrayDataProvider,
      BufferingDataProvider) => {
      function CustomerViewModel() {
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
        this.inputNameValue = ko.observable();
        this.inputSurnameValue = ko.observable();
        this.inputBirthdayValue = ko.observable();
        this.inputAgeValue = ko.observable();
        this.inputBirthplaceValue = ko.observable();
        this.inputGenderValue = ko.observable();
        this.onCreateButtonClick = ko.observable();
        this.dataFromSave = ko.observableArray([]);
        this.data=[];
        this.dataFromGender = ko.observableArray([
          {
                "id": 0,
                "series": "Djem",
                "group": "Group A",
                "value": 10
              },
              {
                "id": 1,
                "series": "Vajza",
                "group": "Group A",
                "value": 10
              }
            ]);
        this.dataprovider = new BufferingDataProvider(new ArrayDataProvider(this.dataFromSave));
        this.genderDataProvider= ko.observableArray([]);
        this.genderDataProvider=new ArrayDataProvider(this.dataFromGender);
        
        var djem = 0;

        var vajza = 0;

        this.onCreateButtonClick = () => {
          
          let dataFromSaved = {
            emri: this.inputNameValue(),
            mbiemri : this.inputSurnameValue(),
            ditelindja : this.inputBirthdayValue(),
            gjinia : this.inputGenderValue(),
            vendlindja : this.inputBirthplaceValue(),
            mosha : this.inputAgeValue()
          };

          alert("Button pressed");

          console.log(dataFromSaved.emri);

        this.dataprovider.addItem({
          metadata: { key: dataFromSaved.emri },
          data: dataFromSaved
      });

      console.log(dataFromSaved);

      if( dataFromSaved.gjinia == "djale"){
        djem ++;
        console.log("djem" +  djem);
      }
      if (dataFromSaved.gjinia == "vajze"){
        vajza ++;
        console.log("vajza" + vajza);
      }
      this.data.push({
        "id": 0,
        "series": "Djem",
        "group": "Group A",
        "value": djem
      });
      this.data.push(
      {
        "id": 1,
        "series": "Vajza",
        "group": "Group B",
        "value": vajza
      });
      console.log(this.data);

        this.genderDataProvider = new ArrayDataProvider(this.data,
          {
            keyAttributes: "id"});
        console.log(this.genderDataProvider);
    }    
      }

        return CustomerViewModel;
      }
  );
  