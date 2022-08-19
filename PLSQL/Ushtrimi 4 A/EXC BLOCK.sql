DECLARE

  l_mid_rate NUMBER(24, 12);
BEGIN
  l_mid_rate := fn_kevinzogu_mid_rate_FCUST('GBP', 'USD', '000');
  DBMS_OUTPUT.PUT_LINE(l_mid_rate);
END;
