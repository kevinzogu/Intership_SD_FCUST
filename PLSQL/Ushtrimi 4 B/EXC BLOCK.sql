  DECLARE

  l_mid_rate NUMBER(24, 12);
BEGIN
  l_mid_rate := fn_kevinzogu_exchange_FCUST(15.235, 'GBP', 'EUR', '000'); 
  DBMS_OUTPUT.PUT_LINE(l_mid_rate);
END;
