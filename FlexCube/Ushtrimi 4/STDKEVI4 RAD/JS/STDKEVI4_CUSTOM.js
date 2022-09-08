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