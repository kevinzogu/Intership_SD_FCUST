function fn_kevin_populate(){
	appendData();
	var prevgAction=gAction;
	gAction='POPULATE';
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