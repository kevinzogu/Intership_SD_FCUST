
CREATE TABLE DETAIL_STDKEVI3(
    COSTUMER_ID VARCHAR2(25),
    COSTUMER_DETAIL_ID VARCHAR2(25),
    FIELD_DESCRIPTION VARCHAR2(35),
    MANDATORY_VALIDATION VARCHAR2(35),
    PRIMARY KEY (COSTUMER_ID,COSTUMER_DETAIL_ID),
    CONSTRAINT FK_DETAIL_STDKEVI3 FOREIGN KEY (COSTUMER_ID)
    REFERENCES MASTER_STDKEVI3(COSTUMER_ID)
);
CREATE SYNONYM DETAILS_STDKEVI3 FOR DETAIL_STDKEVI3;