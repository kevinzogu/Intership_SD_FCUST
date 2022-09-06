CREATE TABLE MASTER_STDKEVI2(

PRODUCT_ID VARCHAR2(25),

RELATIONSHIP VARCHAR2(25),
TAB_DESCRIPTION VARCHAR2(255),
TAB_CATEGORY VARCHAR2(35),
PRODUCT_RESCRIPTION VARCHAR2(10),

AUTH_STAT CHAR(1) DEFAULT 'U',
RECORD_STAT CHAR(1) DEFAULT 'O',
MOD_NO NUMBER(4,0),
CHECKER_DT_STAMP DATE,
ONCE_AUTH CHAR(1) DEFAULT 'N',
MAKER_ID VARCHAR2(12),
MAKER_DT_STAMP DATE,
CHECKER_ID VARCHAR2(12),
CONSTRAINT PK_MASTER_STDKEVI2 PRIMARY KEY (PRODUCT_ID)
);

CREATE SYNONYM MASTERS_STDKEVI2 FOR MASTER_STDKEVI2;