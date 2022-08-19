-- function that check if two currency have mid rate

CREATE OR REPLACE FUNCTION fn_kevin_check_mid_rate_FCUST(p_ccy1 varchar2,
                                                         p_ccy2 varchar2,
                                                         p_branch_code
                                                         varchar2)
  return number AS l_count NUMBER;
BEGIN
  --count between two corrency from parameter with branch like parameter and typestandart
  SELECT COUNT(*)
    INTO l_count
    FROM CYTMS_RATES
   WHERE BRANCH_CODE = p_branch_code
     AND CCY1 = p_ccy1
     AND CCY2 = p_ccy2
     AND rate_type = 'STANDARD';
  RETURN l_count;

EXCEPTION
  -- when no data found close the file
  WHEN no_data_found THEN
    dbms_output.put_line('No data found');
    -- when others print the error message
  WHEN OTHERS THEN
    dbms_output.put_line(sqlerrm);
    --return it if it have excaption
    l_count := 0;
    RETURN l_count;
  
END fn_kevin_check_mid_rate_FCUST;
