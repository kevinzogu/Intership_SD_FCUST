DELETE GWTB_AMEND_NODES A  WHERE A.RAD_FUNCTION_ID = 'STDKEVI2' ;
INSERT INTO GWTB_AMEND_NODES(NODE_NAME,NEW_ALLOWED,DELETE_ALLOWED,ALL_RECORDS,SERVICE_NAME,OPERATION_CODE,RAD_FUNCTION_ID) VALUES(
'MASTER_STDKEVI2',
'Y',
'N',
'Y',
'STDKEVI2',
'STDKEVI2_EXECUTEQUERY',
'STDKEVI2');
INSERT INTO GWTB_AMEND_NODES(NODE_NAME,NEW_ALLOWED,DELETE_ALLOWED,ALL_RECORDS,SERVICE_NAME,OPERATION_CODE,RAD_FUNCTION_ID) VALUES(
'DETAIL_STDKEVI2',
'Y',
'N',
'Y',
'STDKEVI2',
'STDKEVI2_EXECUTEQUERY',
'STDKEVI2');
INSERT INTO GWTB_AMEND_NODES(NODE_NAME,NEW_ALLOWED,DELETE_ALLOWED,ALL_RECORDS,SERVICE_NAME,OPERATION_CODE,RAD_FUNCTION_ID) VALUES(
'MASTER_STDKEVI2',
'N',
'N',
'Y',
'STDKEVI2',
'STDKEVI2_NEW',
'STDKEVI2');
INSERT INTO GWTB_AMEND_NODES(NODE_NAME,NEW_ALLOWED,DELETE_ALLOWED,ALL_RECORDS,SERVICE_NAME,OPERATION_CODE,RAD_FUNCTION_ID) VALUES(
'DETAIL_STDKEVI2',
'N',
'N',
'Y',
'STDKEVI2',
'STDKEVI2_NEW',
'STDKEVI2');
INSERT INTO GWTB_AMEND_NODES(NODE_NAME,NEW_ALLOWED,DELETE_ALLOWED,ALL_RECORDS,SERVICE_NAME,OPERATION_CODE,RAD_FUNCTION_ID) VALUES(
'MASTER_STDKEVI2',
'Y',
'N',
'Y',
'STDKEVI2',
'STDKEVI2_MODIFY',
'STDKEVI2');
INSERT INTO GWTB_AMEND_NODES(NODE_NAME,NEW_ALLOWED,DELETE_ALLOWED,ALL_RECORDS,SERVICE_NAME,OPERATION_CODE,RAD_FUNCTION_ID) VALUES(
'DETAIL_STDKEVI2',
'Y',
'N',
'Y',
'STDKEVI2',
'STDKEVI2_MODIFY',
'STDKEVI2');
COMMIT;