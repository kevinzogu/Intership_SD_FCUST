DELETE GWTM_AMEND_FIELDS A  WHERE A.EXT_SYSTEM = 'FLEXCUBE' AND RAD_FUNCTION_ID = 'STDKEVI3' ;
INSERT INTO GWTM_AMEND_FIELDS(EXT_SYSTEM,SOURCE_OPERATION,NODE_NAME,FIELD_NAME,RAD_FUNCTION_ID,ORIGIN_SYSTEM) VALUES(
'FLEXCUBE',
'STDKEVI3_EXECUTEQUERY',
'MASTER_STDKEVI3',
'COSTUMER_CATEGORY',
'STDKEVI3',
'FLEXCUBE');
INSERT INTO GWTM_AMEND_FIELDS(EXT_SYSTEM,SOURCE_OPERATION,NODE_NAME,FIELD_NAME,RAD_FUNCTION_ID,ORIGIN_SYSTEM) VALUES(
'FLEXCUBE',
'STDKEVI3_EXECUTEQUERY',
'MASTER_STDKEVI3',
'COSTUMER_TYPE',
'STDKEVI3',
'FLEXCUBE');
INSERT INTO GWTM_AMEND_FIELDS(EXT_SYSTEM,SOURCE_OPERATION,NODE_NAME,FIELD_NAME,RAD_FUNCTION_ID,ORIGIN_SYSTEM) VALUES(
'FLEXCUBE',
'STDKEVI3_EXECUTEQUERY',
'DETAIL_STDKEVI3',
'FIELD_DESCRIPTION',
'STDKEVI3',
'FLEXCUBE');
INSERT INTO GWTM_AMEND_FIELDS(EXT_SYSTEM,SOURCE_OPERATION,NODE_NAME,FIELD_NAME,RAD_FUNCTION_ID,ORIGIN_SYSTEM) VALUES(
'FLEXCUBE',
'STDKEVI3_EXECUTEQUERY',
'DETAIL_STDKEVI3',
'MANDATORY_VALIDATION',
'STDKEVI3',
'FLEXCUBE');
INSERT INTO GWTM_AMEND_FIELDS(EXT_SYSTEM,SOURCE_OPERATION,NODE_NAME,FIELD_NAME,RAD_FUNCTION_ID,ORIGIN_SYSTEM) VALUES(
'FLEXCUBE',
'STDKEVI3_MODIFY',
'MASTER_STDKEVI3',
'COSTUMER_CATEGORY',
'STDKEVI3',
'FLEXCUBE');
INSERT INTO GWTM_AMEND_FIELDS(EXT_SYSTEM,SOURCE_OPERATION,NODE_NAME,FIELD_NAME,RAD_FUNCTION_ID,ORIGIN_SYSTEM) VALUES(
'FLEXCUBE',
'STDKEVI3_MODIFY',
'MASTER_STDKEVI3',
'COSTUMER_TYPE',
'STDKEVI3',
'FLEXCUBE');
INSERT INTO GWTM_AMEND_FIELDS(EXT_SYSTEM,SOURCE_OPERATION,NODE_NAME,FIELD_NAME,RAD_FUNCTION_ID,ORIGIN_SYSTEM) VALUES(
'FLEXCUBE',
'STDKEVI3_MODIFY',
'MASTER_STDKEVI3',
'MAKER_ID',
'STDKEVI3',
'FLEXCUBE');
INSERT INTO GWTM_AMEND_FIELDS(EXT_SYSTEM,SOURCE_OPERATION,NODE_NAME,FIELD_NAME,RAD_FUNCTION_ID,ORIGIN_SYSTEM) VALUES(
'FLEXCUBE',
'STDKEVI3_MODIFY',
'MASTER_STDKEVI3',
'MAKER_DT_STAMP',
'STDKEVI3',
'FLEXCUBE');
INSERT INTO GWTM_AMEND_FIELDS(EXT_SYSTEM,SOURCE_OPERATION,NODE_NAME,FIELD_NAME,RAD_FUNCTION_ID,ORIGIN_SYSTEM) VALUES(
'FLEXCUBE',
'STDKEVI3_MODIFY',
'DETAIL_STDKEVI3',
'FIELD_DESCRIPTION',
'STDKEVI3',
'FLEXCUBE');
INSERT INTO GWTM_AMEND_FIELDS(EXT_SYSTEM,SOURCE_OPERATION,NODE_NAME,FIELD_NAME,RAD_FUNCTION_ID,ORIGIN_SYSTEM) VALUES(
'FLEXCUBE',
'STDKEVI3_MODIFY',
'DETAIL_STDKEVI3',
'MANDATORY_VALIDATION',
'STDKEVI3',
'FLEXCUBE');
COMMIT;