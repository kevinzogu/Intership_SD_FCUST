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



function fnPostCopy_CUSTOM(){
	appendData();
	var prevgAction=gAction;
	gAction='COPY';
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