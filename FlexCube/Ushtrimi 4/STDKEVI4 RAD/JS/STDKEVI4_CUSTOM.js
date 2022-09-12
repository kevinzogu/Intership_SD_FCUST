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


var fcjRequestDOM;
var fcjResponseDOM;

var msgStatus;
var cellArr=[];
var fileData;
var imported = document.createElement('script');
imported.src = '/FCJNeoWeb/Script/ExtJS/ExtCsvParser_FCZ.js';
document.head.appendChild(imported);


function fnPostLoad_CUSTOM(){
    document.getElementById("BLK_DETAIL").parentNode.style.display = "inline";
    document.getElementById("TAB_DETAIL__SEC_DETAIL__P_DETAIL1__FST_DETAIL").style.display = "inline";
    
    document.getElementById("BLK_MASTER__BTN_POPULATE").disabled = false;
	document.getElementById("BLK_MASTER__BTN_POPULATE").style.display = "block";
}
function fnPostNew_CUSTOM(){
    msgStatus = "NEW";
    return true;
}
function fnPreSave_CUSTOM(){
    if(msgStatus != "SUCCESS"){
        alert("File needs to be properly uploaded before being able to save");
        return false;
    }
    
    return true;
}

//file

function fnPopulateKevin()
{	
    debugs('Start Custom...','A');

    if(!fnValidate()){
        return false;
    }
     
    //give the PK value so it doesnt raise an error
    if(!document.getElementById('BLK_MASTER__CUSTOMER_REFERENCE').value){
        document.getElementById('BLK_MASTER__CUSTOMER_REFERENCE').value = " ";
    }
    
     var evt = document.getElementById('BLK_MASTER__LBL_FILE');
     var file = evt.files[0];
     var reader = new FileReader();
     reader.readAsText(file);
     reader.onload = function(event) { 
     fileData = event.target.result; //all the data that was inside the file is now here
     var cvsData = Papa.parse(fileData); //we parse it into a 2D array
     cellArr = cvsData.data; 
     console.log(cellArr);
     var filename = document.getElementById('BLK_MASTER__LBL_FILE').value;
     filename = filename.substring(filename.length - 3);
     
     debugs('File name extention: ',filename);
    
    var g_prevAction = gAction;
	gAction = 'RUN_IMPORT';
    
    //build the request header
	exlRequestDOM=buildUBSXml();
    console.log(exlRequestDOM);
    //the request body needs to be built separately with the data from the file and depending on the file type
    if(filename.toLowerCase() == 'xml'){ 
        var bodyReq = fnCreateXMLUploadRequest();
    }else if(filename.toLowerCase() == 'csv'){
        var bodyReq = fnCreateCSVUploadRequest();
    }else{
        alert("The file type needs to be XML or CSV");
        return false;
    }
	debugs('Request:',exlRequestDOM.xml);
	debugs('Body:',bodyReq);
    try{
        //replace the request body with the one we built manually
        var y = exlRequestDOM.childNodes[0];
        y.replaceChild(bodyReq.childNodes[0],y.childNodes[1]);

        var filePrevious = document.getElementById('BLK_MASTER__LBL_FILE');
        var fileNew = filePrevious.cloneNode(false); 
    }catch(err){
        debugs('error in block 82-92: ',err.message);
        alert("This screen works only on Google Chrome");
        return false;
    }
    try{
        fcjResponseDOM = fnPost(exlRequestDOM, servletURL, functionId);
        msgStatus = getNodeText(selectSingleNode(fcjResponseDOM,"FCUBS_RES_ENV/FCUBS_HEADER/MSGSTAT"));
    }catch(err){
        debugs('error in block 119-120, errmsgs: ', err.message);
        return false;
    }
    if (selectSingleNode(fcjResponseDOM,"FCUBS_RES_ENV/FCUBS_BODY/FCUBS_ERROR_RESP")){
        var errorsReturned = getNodeText(selectSingleNode(fcjResponseDOM,"FCUBS_RES_ENV/FCUBS_BODY/FCUBS_ERROR_RESP"));
	}
	debugs(errorsReturned,'Err');
	
    document.getElementById("cmdAddRow_BLK_DETAIL").disabled = true;
    document.getElementById("cmdDelRow_BLK_DETAIL").disabled = true;

	if (!fnProcessResponse())	{
		debugs('Error in fnProcessResponse...','ERR');
		filePrevious.parentNode.replaceChild(fileNew,filePrevious);
		return false;
	}
	
	if (msgStatus == 'FAILURE') {
		filePrevious.parentNode.replaceChild(fileNew,filePrevious);
		return false;
	}
	
	if (errorsReturned != null){
        filePrevious.parentNode.replaceChild(fileNew,filePrevious);
        gAction = g_prevAction;
		return expandcontent('TAB_ERR');
	}
	
	debugs('Action Restored','Info');
	gAction = g_prevAction;
}
}


function fnCreateCSVUploadRequest(){

	reqDom=document.createElementNS(null,"FCUBS_BODY");
    var body =reqDom;
    debugs('Step 1:',reqDom);
    
	var itemsLen = cellArr.length;
    try{
        var recNode = document.createElementNS(null,"REC");
            //TYPE="BLK_MAIN" RECID="1"
            recNode.setAttributeNS(null,"TYPE", "BLK_MASTER");
            recNode.setAttributeNS(null,"RECID", "1");
            body.appendChild(recNode);
        var fvRecNode = document.createElementNS(null,"FV");
            recNode.appendChild(fvRecNode);
        var	recText = document.createTextNode(
											  document.getElementById("BLK_DETAIL__SUBJECT").value + '~'
                                            + document.getElementById("BLK_DETAIL__DETAIL_DESCRIPTION").value + '~'
                                            + itemsLen + '~'
                                            );
            fvRecNode.appendChild(recText);
        debugs('Step 2:',reqDom);
    }catch(err){
        debugs('error in block 169-185',err.message);
        return false;
    }
	var i;
	for(i = 4; i < itemsLen - 3; i++){
        try{
            var rowArr = cellArr[i];
            var newNode = document.createElementNS(null,"REC");
                newNode.setAttributeNS(null,"TYPE", "BLK_DETAIL");
            var newFvNode = document.createElementNS(null,"FV");
                newNode.appendChild(newFvNode);
        }catch(err){
            debugs('Row not found,error in block 195-204',err.message);
            alert("The csv file is not in the correct format");
            return false;
        }
        try{

            var	recText=document.createTextNode(convDate(rowArr[1]) + '~' 
                                                + rowArr[2] + '~'
                                                );
            newFvNode.appendChild(recText);
            recNode.appendChild(newNode);
        }catch(err){
            debugs('One or more attributes are missing from the csv file, error in block 211-221',err.message);
            alert("The csv file is not in the correct format");
            return false;
        }
	}
	var miscNode = document.createElementNS(null,"MISC");
		body.appendChild(miscNode);
	var remarksNode = document.createElementNS(null,"REMARKS");
		miscNode.appendChild(remarksNode);
	debugs('Step 3:',reqDom);
	return reqDom;
}