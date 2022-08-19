--Function to find the mid reate between two currency(using it in the   fn_kevinzogu_mid_rate_linear_FCUST  )
CREATE OR REPLACE FUNCTION fn_kevinzogu_mid_rate_linear_FCUST(p_ccy1
                                                              VARCHAR2,
                                                              p_ccy2
                                                              VARCHAR2,
                                                              p_branch_code
                                                              VARCHAR2)
  return NUMBER is l_mid_rate NUMBER(24, 12);
l_ccy1 VARCHAR2(3) := p_ccy1;
l_ccy2 VARCHAR2(3) := p_ccy2;
l_b_code VARCHAR2(3) := p_branch_code;

BEGIN
  --select the mid rate between two corrency from parameter with branch like parameter and type standart
  SELECT t1.MID_RATE
    INTO l_mid_rate
    FROM CYTMS_RATES t1
   WHERE t1.ccy1 = l_ccy1
     AND t1.ccy2 = l_ccy2
     AND t1.rate_type = 'STANDARD'
     AND t1.branch_code = l_b_code;
  --return the value
  RETURN l_mid_rate;

EXCEPTION
  -- when no data found close the file
  WHEN no_data_found THEN
    dbms_output.put_line('No data found');
    -- when others print the error message
  WHEN OTHERS THEN
    dbms_output.put_line(sqlerrm);
    --return it if it have excaption
    l_mid_rate := 0;
    RETURN l_mid_rate;
END fn_kevinzogu_mid_rate_linear_FCUST;
