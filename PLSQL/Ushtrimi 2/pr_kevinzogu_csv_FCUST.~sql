create or replace procedure pr_kevinzogu_csv_FCUST AS
  l_file    utl_file.file_type;
  l_line    varchar2(255);
  l_ccy_one varchar2(3);
  l_ccy_two varchar2(3);
  l_rate    NUMBER(24,12);
  l_date    DATE;
  l_value   varchar2(20);
begin
  --
  l_file := utl_file.fopen('KEVINZOGU_DIR', 'Rate.csv', 'r');
  --if the file exist, open it

  if utl_file.is_open(l_file) then
  
    dbms_output.put_line('File open');
    --loop to select the value seperatet by , in each row
  
    loop
      --first currency is default EUR if it is not specified
    
      l_ccy_one := 'EUR';
      --get the line
    
      utl_file.get_line(l_file, l_line);
    
      --get the first part of line seperated by , to check if it has note 
    
      l_value := regexp_substr(l_line, '[^,]+', 1, 1);
    
      --get the currency from line  
    
      l_ccy_two := regexp_substr(l_value, '[^1 =]+', 1, 1);
    
      --if in the document is specified the length > 3 so the currency will change and be as in note
    
      if length(l_value) > 3 then
        --select the currency from note
      
        l_ccy_one := regexp_substr(l_value, '[^1 =]+', 1, 2);
      end if;
    
      --get the rate from document 
    
      l_rate := regexp_substr(l_line, '[^,]+', 1, 2);
      --get te date and converted it into date variable in format 'dd/mm/yyyy'
    
      l_date := TO_DATE(regexp_substr(l_line, '[^,]+', 1, 3), 'dd/mm/yyyy');
      --print it to seeif work
    
      dbms_output.put_line(l_ccy_one || '|' || l_ccy_two || '|' || l_rate || '|' ||
                           l_date);
      --create a inner block to puth the value into table
      begin
        --insert into table the value from outer block
        insert into kevinzogu_csv_table_FCUST
          (ccy_one, ccy_two, ex_rate, ex_date)
        values
          (l_ccy_one, l_ccy_two, l_rate, l_date);
        --commit the change
        commit;
        --end of inner block
      end;
      --end of loop
    end loop;
    --end of if
  end if;
  --exception
EXCEPTION
  -- when no data found close the file
  WHEN no_data_found THEN
    utl_file.fclose(l_file);
    -- when others print the error message
  WHEN OTHERS THEN
    dbms_output.put_line(sqlerrm);
    NULL;
  
  --end of procedure
end pr_kevinzogu_csv_FCUST;
