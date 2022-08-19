DECLARE
  l_myDay         DATE := to_date('25/08/2022 05:05:00',
                                  'DD/MM/YYYY HH:MI:SS');
  l_n             number := 3;
  l_error_message VARCHAR2(100) := NULL;
  l_horW          VARCHAR2(1) := NULL;
  l_value         BOOLEAN;
  l_month         NUMBER(2);
  l_year          NUMBER(4);
  l_line          VARCHAR2(50);

BEGIN
  l_value := fn_kevinzogu_isHolliday_FCUST(l_myDay,
                                                    l_n,
                                                    l_horW,
                                                    l_error_message);
  l_month := EXTRACT(MONTH FROM l_myDay);
  l_year  := EXTRACT(YEAR FROM l_myDay);
  DBMS_OUTPUT.put_line('VALUE IS : ' || sys.diutil.bool_to_int(l_value));

END;
