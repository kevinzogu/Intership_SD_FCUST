-- function that find mid rate between two currency 

CREATE OR REPLACE FUNCTION fn_kevinzogu_mid_rate_FCUST(p_ccy1 VARCHAR2,
                                                       p_ccy2 VARCHAR2,
                                                       p_branch_code
                                                       VARCHAR2)
  return NUMBER is l_mid_rate NUMBER(24, 12);
l_ccy1 VARCHAR2(3) := p_ccy1;
l_ccy2 VARCHAR2(3) := p_ccy2;
l_b_code VARCHAR2(3) := p_branch_code;

l_cnt_row1 NUMBER;
l_cnt_row2 NUMBER;

l_cnt_row3 NUMBER;
l_cnt_row4 NUMBER;

l_cnt_row5 NUMBER;
l_cnt_row6 NUMBER;

l_ccy3 VARCHAR2(3);

l_mid_rate1 NUMBER(24, 12);
l_mid_rate2 NUMBER(24, 12);

BEGIN
  --check if ccy1 and ccy2 have a mid rate between each other and oposite ccy2 ccy1
  l_cnt_row1 := fn_kevin_check_mid_rate_FCUST(l_ccy1, l_ccy2, l_b_code);
  l_cnt_row2 := fn_kevin_check_mid_rate_FCUST(l_ccy2, l_ccy1, l_b_code);

  DBMS_OUTPUT.PUT_LINE('COUNT 1 ' || l_cnt_row1);
  DBMS_OUTPUT.PUT_LINE('COUNT 2 ' || l_cnt_row2);

  -- if they have find it linear

  IF l_cnt_row1 > 0 OR l_cnt_row2 > 0 THEN
  
    IF l_cnt_row1 > 0 THEN
      --ccy1 ccy2 linear
      DBMS_OUTPUT.PUT_LINE('Linear');
    
      l_mid_rate := fn_kevinzogu_mid_rate_linear_FCUST(l_ccy1,
                                                       l_ccy2,
                                                       l_b_code);
      DBMS_OUTPUT.PUT_LINE('cc1 cc2');
    
    ELSIF l_cnt_row2 > 0 THEN
      --ccy2 ccy1 change place at parameter linear
      DBMS_OUTPUT.PUT_LINE('cc2 cc1');
      l_mid_rate := 1 / fn_kevinzogu_mid_rate_linear_FCUST(l_ccy2,
                                                           l_ccy1,
                                                           l_b_code);
    
    END IF;
    --if cy1 and ccy2 dont have mid rate find it with derivative way
  ELSE
  
    DBMS_OUTPUT.PUT_LINE('Derivative');
    --check where the cy1 or ccy2 are in table
  
    SELECT COUNT(t3.ccy1)
      INTO l_cnt_row3
      FROM CYTMS_RATES t3
     WHERE t3.ccy1 = l_ccy1
       AND t3.rate_type = 'STANDARD'
       AND t3.branch_code = l_b_code;
  
    SELECT COUNT(t4.ccy2)
      INTO l_cnt_row4
      FROM CYTMS_RATES t4
     WHERE t4.ccy2 = l_ccy2
       AND t4.rate_type = 'STANDARD'
       AND t4.branch_code = l_b_code;
  
    DBMS_OUTPUT.PUT_LINE('COUNT 3 ' || l_cnt_row3);
    DBMS_OUTPUT.PUT_LINE('COUNT 4 ' || l_cnt_row4);
  
    --in this case ccy1 and ccy2 are in respektiv colomns but not in the same index
  
    IF l_cnt_row3 > 0 AND l_cnt_row4 > 0 THEN
    
      DBMS_OUTPUT.PUT_LINE('ccy 1 - ccy3   ccy3 - ccy2');
    
      --find a comman currency to find the derviate rate 
    
      SELECT DISTINCT t2.ccy2
        INTO l_ccy3
        FROM CYTMS_RATES t2
       WHERE t2.ccy1 = l_ccy1
         AND t2.rate_type = 'STANDARD'
         AND t2.branch_code = l_b_code;
      --Check if they ccy if connon for ccy1 and ccy2
      l_cnt_row5 := fn_kevin_check_mid_rate_FCUST(l_ccy1, l_ccy3, l_b_code);
      l_cnt_row6 := fn_kevin_check_mid_rate_FCUST(l_ccy3, l_ccy2, l_b_code);
    
      DBMS_OUTPUT.PUT_LINE('ccy3 ' || l_ccy3);
      DBMS_OUTPUT.PUT_LINE('COUNT 5 ' || l_cnt_row5);
      DBMS_OUTPUT.PUT_LINE('COUNT 6 ' || l_cnt_row6);
    
      --find mid rate by mid rate of ccy1 - ccy3 and ccy3 ccy2 to find ccy1 - ccy2 
    
      l_mid_rate1 := fn_kevinzogu_mid_rate_linear_FCUST(l_ccy1,
                                                        l_ccy3,
                                                        l_b_code);
      l_mid_rate2 := fn_kevinzogu_mid_rate_linear_FCUST(l_ccy3,
                                                        l_ccy2,
                                                        l_b_code);
      l_mid_rate  := l_mid_rate1 * l_mid_rate2;
    
      --in this case ccy1 and ccy2 are in the save ROW(1)
    
    ELSIF l_cnt_row3 > 0 and l_cnt_row4 = 0 THEN
    
      DBMS_OUTPUT.PUT_LINE('ccy 1 - ccy3   ccy2 - ccy3');
    
      --find a comman currency to find the derviate rate 
      SELECT DISTINCT t2.ccy2
        INTO l_ccy3
        FROM CYTMS_RATES t2
       WHERE t2.ccy1 = l_ccy1
         AND t2.rate_type = 'STANDARD'
         AND t2.branch_code = l_b_code;
      --Check if they ccy if connon for ccy1 and ccy2
    
      l_cnt_row5 := fn_kevin_check_mid_rate_FCUST(l_ccy1, l_ccy3, l_b_code);
      l_cnt_row6 := fn_kevin_check_mid_rate_FCUST(l_ccy3, l_ccy2, l_b_code);
    
      DBMS_OUTPUT.PUT_LINE('ccy3 ' || l_ccy3);
      DBMS_OUTPUT.PUT_LINE('COUNT 5 ' || l_cnt_row5);
      DBMS_OUTPUT.PUT_LINE('COUNT 6 ' || l_cnt_row6);
      --find mid rate by mid rate of ccy1 - ccy3 and ccy3 ccy2 to find ccy1 - ccy2 
      l_mid_rate1 := fn_kevinzogu_mid_rate_linear_FCUST(l_ccy1,
                                                        l_ccy3,
                                                        l_b_code);
      l_mid_rate2 := fn_kevinzogu_mid_rate_linear_FCUST(l_ccy2,
                                                        l_ccy3,
                                                        l_b_code);
    
      l_mid_rate := (1 / l_mid_rate1) * l_mid_rate2;
    
      --in this case ccy1 and ccy2 are in the save ROW(2)
    
    ELSIF l_cnt_row3 = 0 and l_cnt_row4 > 0 THEN
    
      --find a comman currency to find the derviate rate 
    
      DBMS_OUTPUT.PUT_LINE('ccy 3 - ccy1   ccy3 - ccy2');
    
      SELECT DISTINCT t2.ccy1
        INTO l_ccy3
        FROM CYTMS_RATES t2
       WHERE t2.ccy2 = l_ccy2
         AND t2.rate_type = 'STANDARD'
         AND t2.branch_code = l_b_code;
      --Check if they ccy if connon for ccy1 and ccy2
      l_cnt_row5 := fn_kevin_check_mid_rate_FCUST(l_ccy1, l_ccy3, l_b_code);
      l_cnt_row6 := fn_kevin_check_mid_rate_FCUST(l_ccy3, l_ccy2, l_b_code);
    
      DBMS_OUTPUT.PUT_LINE('ccy3 ' || l_ccy3);
      DBMS_OUTPUT.PUT_LINE('COUNT 5 ' || l_cnt_row5);
      DBMS_OUTPUT.PUT_LINE('COUNT 6 ' || l_cnt_row6);
      --find mid rate by mid rate of ccy1 - ccy3 and ccy3 ccy2 to find ccy1 - ccy2 
      l_mid_rate1 := fn_kevinzogu_mid_rate_linear_FCUST(l_ccy3,
                                                        l_ccy1,
                                                        l_b_code);
      l_mid_rate2 := fn_kevinzogu_mid_rate_linear_FCUST(l_ccy3,
                                                        l_ccy2,
                                                        l_b_code);
      l_mid_rate  := l_mid_rate1 * (1 / l_mid_rate2);
    
      --in this case ccy1 and ccy2 are in reverse colomns but not in the same index
    
    ELSIF l_cnt_row3 = 0 and l_cnt_row4 = 0 THEN
    
      --find a comman currency to find the derviate rate 
    
      DBMS_OUTPUT.PUT_LINE('ccy 2 - ccy3   ccy3 - ccy1');
    
      SELECT DISTINCT t2.ccy2
        INTO l_ccy3
        FROM CYTMS_RATES t2
       WHERE t2.ccy1 = l_ccy2
         AND t2.rate_type = 'STANDARD'
         AND t2.branch_code = l_b_code;
      --Check if they ccy if connon for ccy1 and ccy2
      l_cnt_row5 := fn_kevin_check_mid_rate_FCUST(l_ccy1, l_ccy3, l_b_code);
      l_cnt_row6 := fn_kevin_check_mid_rate_FCUST(l_ccy3, l_ccy2, l_b_code);
    
      DBMS_OUTPUT.PUT_LINE('ccy3 ' || l_ccy3);
      DBMS_OUTPUT.PUT_LINE('COUNT 5 ' || l_cnt_row5);
      DBMS_OUTPUT.PUT_LINE('COUNT 6 ' || l_cnt_row6);
      --find mid rate by mid rate of ccy1 - ccy3 and ccy3 ccy2 to find ccy1 - ccy2 
      l_mid_rate1 := fn_kevinzogu_mid_rate_linear_FCUST(l_ccy2,
                                                        l_ccy3,
                                                        l_b_code);
      l_mid_rate2 := fn_kevinzogu_mid_rate_linear_FCUST(l_ccy3,
                                                        l_ccy1,
                                                        l_b_code);
      l_mid_rate  := (1 / l_mid_rate1) * (1 / l_mid_rate2);
    
      -- else connon currency don't exist 
    ELSE
      DBMS_OUTPUT.PUT_LINE('NUK KA TE DHENA PER TE GJETUR MID RATE');
      l_mid_rate := 0;
    
    END IF;
  END IF;
  DBMS_OUTPUT.PUT_LINE('Mid rate: ' || l_mid_rate);
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
END fn_kevinzogu_mid_rate_FCUST;
