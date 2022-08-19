--procedure
CREATE OR REPLACE PROCEDURE pr_kevinzogu_xml_FCUST AS
  l_xml_data  XMLTYPE;
  
  --acursore to select element in xml 
   cursor c_getXml is
SELECT tab.*
  FROM
   XMLTABLE('/Msg/Docs/Doc/Cctinit/Document/CstmrCdtTrfInitn/PmtInf/CdtTrfTxInf'
         PASSING l_xml_data
         COLUMNS
         ENDTOENDID varchar2(12) PATH 'PmtId/EndToEndId',
         AMT NUMBER(22,3) PATH 'Amt/InstdAmt',
         CCY varchar2(3) PATH 'Amt/InstdAmt/@Ccy',
         IBAN varchar2(20) PATH 'CdtrAcct/Id/IBAN',
         BIC varchar2(11)  PATH 'CdtrAgt/FinInstnId/BIC' 
       )tab;
BEGIN
  --open xml file with irectory and file name
l_xml_data :=XMLTYPE (BFILENAME ('KEVINZOGU_DIR', 'test.xml'),
NLS_CHARSET_ID ('UTF8')
);
--loop xml file and insert values in table
    for x in c_getXML
   loop
     INSERT INTO kevinzogu_xml_table_FCUST(endToEndId,amt,ccy,iban,bic) 
     VALUES (x.ENDTOENDID,x.AMT,x.CCY,x.IBAN,x.BIC);
     dbms_output.put_line('ENDTOENDID: '||x.ENDTOENDID);
     dbms_output.put_line('AMT: '||x.AMT);
     dbms_output.put_line('CCY: '||x.CCY);
      dbms_output.put_line('IBAN: '||x.IBAN);
       dbms_output.put_line('Confirm: '||x.BIC);
       dbms_output.put_line('------------------------------ ');
   end loop;
   
EXCEPTION
  -- when no data found 
  WHEN no_data_found THEN
    dbms_output.put_line('No data found');
    -- when others print the error message
  WHEN OTHERS THEN
    dbms_output.put_line(sqlerrm);
END pr_kevinzogu_xml_FCUST;
