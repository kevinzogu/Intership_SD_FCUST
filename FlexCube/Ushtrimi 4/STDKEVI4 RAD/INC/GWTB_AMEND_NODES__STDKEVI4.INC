DELETE GWTB_AMEND_NODES A  WHERE A.RAD_FUNCTION_ID = 'STDKEVI4' ;
INSERT INTO GWTB_AMEND_NODES(NODE_NAME,NEW_ALLOWED,DELETE_ALLOWED,ALL_RECORDS,SERVICE_NAME,OPERATION_CODE,RAD_FUNCTION_ID) VALUES(
'MASTER_STDKEVI4',
'Y',
'N',
'Y',
'STDKEVI4',
'STDKEVI4_EXECUTEQUERY',
'STDKEVI4');
INSERT INTO GWTB_AMEND_NODES(NODE_NAME,NEW_ALLOWED,DELETE_ALLOWED,ALL_RECORDS,SERVICE_NAME,OPERATION_CODE,RAD_FUNCTION_ID) VALUES(
'DETAIL_STDKEVI4',
'Y',
'N',
'Y',
'STDKEVI4',
'STDKEVI4_EXECUTEQUERY',
'STDKEVI4');
INSERT INTO GWTB_AMEND_NODES(NODE_NAME,NEW_ALLOWED,DELETE_ALLOWED,ALL_RECORDS,SERVICE_NAME,OPERATION_CODE,RAD_FUNCTION_ID) VALUES(
'MASTER_STDKEVI4',
'Y',
'N',
'Y',
'STDKEVI4',
'STDKEVI4_NEW',
'STDKEVI4');
INSERT INTO GWTB_AMEND_NODES(NODE_NAME,NEW_ALLOWED,DELETE_ALLOWED,ALL_RECORDS,SERVICE_NAME,OPERATION_CODE,RAD_FUNCTION_ID) VALUES(
'DETAIL_STDKEVI4',
'Y',
'N',
'Y',
'STDKEVI4',
'STDKEVI4_NEW',
'STDKEVI4');
INSERT INTO GWTB_AMEND_NODES(NODE_NAME,NEW_ALLOWED,DELETE_ALLOWED,ALL_RECORDS,SERVICE_NAME,OPERATION_CODE,RAD_FUNCTION_ID) VALUES(
'MASTER_STDKEVI4',
'Y',
'N',
'Y',
'STDKEVI4',
'STDKEVI4_MODIFY',
'STDKEVI4');
INSERT INTO GWTB_AMEND_NODES(NODE_NAME,NEW_ALLOWED,DELETE_ALLOWED,ALL_RECORDS,SERVICE_NAME,OPERATION_CODE,RAD_FUNCTION_ID) VALUES(
'DETAIL_STDKEVI4',
'Y',
'Y',
'Y',
'STDKEVI4',
'STDKEVI4_MODIFY',
'STDKEVI4');
COMMIT;