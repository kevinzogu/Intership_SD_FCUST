CREATE OR REPLACE FUNCTION fn_kevinzogu_isHolliday_FCUST(p_myDay date,
                                                         p_n NUMBER,
                                                         p_HorW OUT
                                                         VARCHAR2,
                                                         p_error_message OUT
                                                         VARCHAR2)
  return boolean is

l_FunctionResult BOOLEAN;

l_myday DATE := p_myDay;
l_n NUMBER := p_n;
l_HorW VARCHAR2(1);
l_month NUMBER(2);
l_year NUMBER(4);
l_new_date DATE;
l_day NUMBER(2);
l_line varchar2(50);

BEGIN
  --check if n is positiv or negativ so add or substract
  IF l_n > 0 THEN
    -- if n > 0 so positiv add day
    l_new_date := l_myday + l_n;
  ELSE
    -- else if n negetive substract day
    l_new_date := l_myday - (-l_n);
  
  END IF;

  --Exctract value of day month and year from l_new_date
  l_day   := EXTRACT(DAY FROM l_new_date);
  l_month := EXTRACT(MONTH FROM l_new_date);
  l_year  := EXTRACT(YEAR FROM l_new_date);

  --select from tablethe specifik colon that contain day work or holiday

  SELECT STTMS_LCL_HOLIDAY.HOLIDAY_LIST
    INTO l_line
    FROM STTMS_LCL_HOLIDAY
   WHERE STTMS_LCL_HOLIDAY.YEAR = l_year
     AND STTMS_LCL_HOLIDAY.MONTH = l_month;

  --check all the character from line to check if the day we need is H or W
  FOR i IN 1 .. LENGTH(l_line) LOOP
    DBMS_OUTPUT.PUT_LINE('Character at index ' || i || ' is ' ||
                         SUBSTR(l_line, i, 1));
    --where i = with day we need getthe char to seeif it is H or W
  
    IF i = l_day THEN
      l_HorW := SUBSTR(l_line, i, 1);
    
    END IF;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Day : ' || l_day || ' Date: ' || l_new_date ||
                       ' is ' || l_HorW);
  DBMS_OUTPUT.put_line('0= FALSE ( W -> WORK ) 1= TRUE( H -> Holiday )');
  --check if the character is H or W to return the boolean 
  IF l_HorW = 'H' THEN
    l_FunctionResult := TRUE;
  ELSE
    l_FunctionResult := FALSE;
  END IF;
  --return value
  RETURN l_FunctionResult;
EXCEPTION
  -- when no data found close the file
  WHEN no_data_found THEN
    dbms_output.put_line('No data found');
    -- when others print the error message
  WHEN OTHERS THEN
    dbms_output.put_line(sqlerrm);
    --return it if it have excaption
    RETURN l_FunctionResult;
END fn_kevinzogu_isHolliday_FCUST;
