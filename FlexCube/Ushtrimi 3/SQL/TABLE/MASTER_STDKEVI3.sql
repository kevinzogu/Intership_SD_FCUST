CREATE TABLE MASTER_STDKEVI3(

COSTUMER_ID VARCHAR2(25),

COSTUMER_TYPE VARCHAR2(25),
COSTUMER_CATEGORY VARCHAR2(35),

AUTH_STAT CHAR(1) DEFAULT 'U',
RECORD_STAT CHAR(1) DEFAULT 'O',
MOD_NO NUMBER(4,0),
CHECKER_DT_STAMP DATE,
ONCE_AUTH CHAR(1) DEFAULT 'N',
MAKER_ID VARCHAR2(12),
MAKER_DT_STAMP DATE,
CHECKER_ID VARCHAR2(12),

CONSTRAINT PK_MASTER_STDKEVI3 PRIMARY KEY (COSTUMER_ID)
);


CREATE SYNONYM MASTERS_STDKEVI3 FOR MASTER_STDKEVI3;