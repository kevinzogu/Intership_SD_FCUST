  --return VARCHAR2 – Y|N

  CREATE OR REPLACE FUNCTION fn_kevinzogu_does_contract_exist_no_FCUST(p_udf_name  VARCHAR2,
                                                                       p_udf_value VARCHAR2,
                                                                       p_fc_module VARCHAR2)
  return VARCHAR2 is
  l_result    VARCHAR2(1);
  l_field_num NUMBER(3);
  l_udf_name  varchar2(150) := p_udf_name;
  l_field_val VARCHAR2(150) := p_udf_value;
  l_module    VARCHAR2(2) := p_fc_module;
  l_check     NUMBER;
  l_qry       VARCHAR2(150);
BEGIN
  --select the number of field 
  SELECT cstm_product_udf_fields_map.field_num
    INTO l_field_num
    FROM cstm_product_udf_fields_map
   WHERE cstm_product_udf_fields_map.field_name = l_udf_name;
  --use a string to doa dinamic query to check if the contrat exist
  l_qry := 'select count(*) from cstm_contract_userdef_fields f where f.field_val_' ||
           l_field_num || '=''' || l_field_val || ''' and f.module =''' ||
           l_module || '''';
  --execute the query and the result save in l_check
  EXECUTE IMMEDIATE l_qry
    INTO l_check;

  DBMS_OUTPUT.put_line(l_check);
  --if l_check > 0 contrat exist
  IF l_check > 0 THEN
    l_result := 'Y';
    --else doest exist
  ELSE
    l_result := 'N';
  END IF;
  --return the value
  RETURN l_result;
EXCEPTION
  -- when no data found close the file
  WHEN no_data_found THEN
    dbms_output.put_line('No data found');
    -- when others print the error message
  WHEN OTHERS THEN
    dbms_output.put_line(sqlerrm);
END fn_kevinzogu_does_contract_exist_no_FCUST;
