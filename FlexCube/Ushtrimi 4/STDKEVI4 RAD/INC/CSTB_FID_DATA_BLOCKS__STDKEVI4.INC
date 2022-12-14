DELETE CSTB_FID_DATA_BLOCKS A  WHERE A.FUNCTION_ID = 'STDKEVI4' ;
INSERT INTO CSTB_FID_DATA_BLOCKS(FUNCTION_ID,BLOCK_NAME,BLOCK_NO,BLOCK_TYPE,BLOCK_PARENT,RELATION_TYPE,MULTI_RECORD,BLOCK_TITLE,XSD_NODE,DSN_LIST,DSN_LIST_1,DSN_LIST_2,FLD_TAG_FIELDS,FLD_TAG_FIELDS_1,FLD_TAG_FIELDS_2,FLD_TAG_XSD_TAGS,FLD_TAG_XSD_TAGS_1,FLD_TAG_XSD_TAGS_2) VALUES(
'STDKEVI4',
'BLK_MASTER',
1,
'NORMAL',
NULL,
'1',
'N',
NULL,
'Master',
'MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~MASTER_STDKEVI4~',
NULL,
NULL,
'AMOUNT~CCY~CUSTOMER_ACCOUNT~CUSTOMER_NAME~CUSTOMER_NO~C_DATE~EMAIL~PHONE_NUMBER~PRIORITY~CUSTOMER_REFERENCE~DESCRIPTION_REFERENCE~MAKER~MAKERSTAMP~CHECKER~CHECKERSTAMP~MODNO~TXNSTAT~AUTHSTAT~ONCEAUTH~',
NULL,
NULL,
'AMOUNT~CCYY~ACCOPT~CUSTOMER_NAME~CUSTOMER_NO~INCORPDT~EMAIL~PHONE_NUMBER~PRIORITY~REFERENCE~FLDDES~MAKER~MAKERSTAMP~CHECKER~CHECKERSTAMP~MODNO~TXNSTAT~AUTHSTAT~ONCEAUTH~',
NULL,
NULL);
INSERT INTO CSTB_FID_DATA_BLOCKS(FUNCTION_ID,BLOCK_NAME,BLOCK_NO,BLOCK_TYPE,BLOCK_PARENT,RELATION_TYPE,MULTI_RECORD,BLOCK_TITLE,XSD_NODE,DSN_LIST,DSN_LIST_1,DSN_LIST_2,FLD_TAG_FIELDS,FLD_TAG_FIELDS_1,FLD_TAG_FIELDS_2,FLD_TAG_XSD_TAGS,FLD_TAG_XSD_TAGS_1,FLD_TAG_XSD_TAGS_2) VALUES(
'STDKEVI4',
'BLK_DETAIL',
2,
'NORMAL',
'BLK_MASTER',
'N',
'Y',
NULL,
'Detail',
'DETAIL_STDKEVI4~DETAIL_STDKEVI4~DETAIL_STDKEVI4~DETAIL_STDKEVI4~DETAIL_STDKEVI4~DETAIL_STDKEVI4~',
NULL,
NULL,
'CUSTOMER_ID~CUSTOMER_REFERENCE~DETAIL_DESCRIPTION~DETAIL_USER~D_DATE~SUBJECT~',
NULL,
NULL,
'CUSTOMER_ID~CUSTOMER_REFERENCE~FLDDES~USER~INCORPDT~SUBJECT~',
NULL,
NULL);
COMMIT;