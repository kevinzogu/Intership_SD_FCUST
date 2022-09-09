var reference;
function fnPostNew_CUSTOM(){
	appendData();
	var prevgAction=gAction;
	gAction='VALUE';
	fcjRequestDOM=buildUBSXml();
    debugs('FCZ req',fcjRequestDOM);
	fcjResponseDOM=fnPost(fcjRequestDOM,servletURL,functionId);
	debugs('FCZ req',fcjRequestDOM);
	debugs('FCZ resp',fcjResponseDOM);
	if(!fnProcessResponse())
	{
		return true;
	}
		debugs('FCZ final',fcjRequestDOM);
		gAction=prevgAction;
};

function fnPreCopy_CUSTOM(){
reference = document.getElementById('BLK_MASTER__CUSTOMER_REFERENCE').value;
console.log(' pre copy : '+ reference);
return true;
};

function fnPostCopy_CUSTOM(){
document.getElementById("BLK_MASTER__CUSTOMER_REFERENCE").value= reference + 'C';
console.log(' post copy : '+ reference + 'C');
return true;
};


function fnPopulateKevin() {
    var fileSize = 0;
    //get file
    var theFile = document.getElementById("BLK_MASTER__LBL_FILE");
    
     var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
     //check if file is CSV
     if (regex.test(theFile.value.toLowerCase())) {
     //check if browser support FileReader
        if (typeof (FileReader) != "undefined") {
       //get table element
        var table = document.getElementById("myTable");
        var headerLine = "";
        //create html5 file reader object
        var myReader = new FileReader();
        // call filereader. onload function
        myReader.onload = function(e) {
            var content = myReader.result;
            //split csv file using "\n" for new line ( each row)
            var lines = content.split("\r");
            //loop all rows
            for (var count = 0; count < lines.length; count++) {
                //create a tr element
                var row = document.createElement("tr");
                //split each row content
                var rowContent = lines[count].split(",");
                //loop throw all columns of a row
                for (var i = 0; i < rowContent.length; i++) {
                   //create td element 
                    var cellElement = document.createElement("td");
                    if (count == 0) {
                        cellElement = document.createElement("th");
                    } else {
                        cellElement = document.createElement("td");
                    }
                    //add a row element as a node for table
                    var cellContent = document.createTextNode(rowContent[i]);
                    
                    cellElement.appendChild(cellContent);
                    //append row child
                    row.appendChild(cellElement);
                }
                //append table contents
                myTable.appendChild(row);
            }
        }
         //call file reader onload
          myReader.readAsText(theFile.files[0]);
        }
        else 
        {
              alert("This browser does not support HTML5.");
        }
        
    }
    else {
                alert("Please upload a valid CSV file.");
    }
    return false;
}