  --function to find the exchange between to currency for a amount and round it to the decimal forthe type of currency
  CREATE OR REPLACE FUNCTION fn_kevinzogu_exchange_FCUST(p_amt         NUMBER,
                                                         p_ccy1        VARCHAR2,
                                                         p_ccy2        VARCHAR2,
                                                         p_branch_code VARCHAR2)
  return NUMBER is

  l_mid_rate NUMBER(24, 12);
  l_amt      NUMBER(24, 12) := p_amt;
  l_decimal  NUMBER(1);
  l_total    NUMBER;

BEGIN
  --amount * the mid rate of two currency 
  l_mid_rate := l_amt *
                fn_kevinzogu_mid_rate_FCUST(p_ccy1, p_ccy2, p_branch_code);
  --the decimal to round the total 
  SELECT DISTINCT t1.ccy_decimals
    INTO l_decimal
    FROM CYTMS_CCY_DEFN_MASTER t1
   where t1.ccy_code = p_ccy2;
  --check if decimal presicion is in table
  --if exist round it
  --else raise exception no_data_found
  --return the total
  l_total := ROUND(l_mid_rate, l_decimal);
  DBMS_OUTPUT.PUT_LINE('For : ' || p_amt || ' ' || p_ccy1 ||
                       ' Total Value in : ' || p_ccy2 || ' is ' || l_total || ' ' ||
                       p_ccy2);
  dbms_output.put_line('Decimal persition found : ' || l_decimal);
  RETURN l_total;
EXCEPTION
  -- when no data found close the file decimal persition default 1 
  WHEN no_data_found THEN
    dbms_output.put_line('No decimal persition found(Default 1)');
    l_decimal := 1;
    l_total   := ROUND(l_mid_rate, l_decimal);
    DBMS_OUTPUT.PUT_LINE('For : ' || p_amt || ' ' || p_ccy1 ||
                         ' Total Value in : ' || p_ccy2 || ' is ' ||
                         l_total || ' ' || p_ccy2);
    RETURN l_total;
    -- when others print the error message
  WHEN OTHERS THEN
    dbms_output.put_line(sqlerrm);
    --return it if it have excaption
    RETURN l_total;
  
END fn_kevinzogu_exchange_FCUST;
