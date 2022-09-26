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
  "ojs/ojchart",
  djem = 0,
  vajza = 0,
  data=[]
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

        this.dataprovider = new BufferingDataProvider(new ArrayDataProvider(this.dataFromSave));

        data=[{
          id: 0,
          series: "Djem",
          group: "Group A",
          value: djem
          },
          {
          id: 1,
          series: "Vajza",
          group: "Group A",
          value: vajza
        }
        ];

        var chartData = ko.observableArray(data);

        this.genderDataProvider=new ArrayDataProvider(chartData, {
          keyAttributes: "id"
      });
        


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

      console.log(data);

      data[0].value=djem;

      data[1].value=vajza;

      chartData(data);
      
      this.genderDataProvider= new ArrayDataProvider(chartData, {
        keyAttributes: "id"
      });
    }
  }
        return CustomerViewModel;
      }
  );
  