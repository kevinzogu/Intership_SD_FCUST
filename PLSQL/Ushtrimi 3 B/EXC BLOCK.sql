  DECLARE

  l_udf_name VARCHAR2(150) := 'CL_ACC_LINK'; 
  l_field_val VARCHAR2(150) := '000LOMT202760510';
  l_module VARCHAR2(2) := 'SI';
  l_result VARCHAR2(1);

BEGIN

  l_result := fn_kevinzogu_does_contract_exist_no_FCUST(l_udf_name, l_field_val, l_module); 
  IF l_result = 'Y' THEN
     DBMS_OUTPUT.put_line('Kontrata EGZISTON'); 
     ELSE DBMS_OUTPUT.put_line('Kontrata nuk EGZISTON');
END IF; 

DBMS_OUTPUT.put_line(l_result);
END;
