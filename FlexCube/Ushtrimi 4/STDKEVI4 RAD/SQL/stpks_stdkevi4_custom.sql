CREATE OR REPLACE PACKAGE BODY stpks_stdkevi4_custom AS
     /*-----------------------------------------------------------------------------------------------------
     **
     ** File Name  : stpks_stdkevi4_custom.sql
     **
     ** Module     : Static Maintenance
     ** 
     ** This source is part of the Oracle FLEXCUBE Software Product.
     ** Copyright (R) 2008,2022 , Oracle and/or its affiliates.  All rights reserved
     ** 
     ** 
     ** No part of this work may be reproduced, stored in a retrieval system, adopted 
     ** or transmitted in any form or by any means, electronic, mechanical, 
     ** photographic, graphic, optic recording or otherwise, translated in any 
     ** language or computer language, without the prior written permission of 
     ** Oracle and/or its affiliates. 
     ** 
     ** Oracle Financial Services Software Limited.
     ** Oracle Park, Off Western Express Highway,
     ** Goregaon (East), 
     ** Mumbai - 400 063, India
     ** India
     -------------------------------------------------------------------------------------------------------
     CHANGE HISTORY
     
     SFR Number         :  
     Changed By         :  
     Change Description :  
     
     -------------------------------------------------------------------------------------------------------
     */
     

   PROCEDURE Dbg(p_msg VARCHAR2)  IS
      l_Msg     VARCHAR2(32767);
   BEGIN
      IF debug.pkg_debug_on <> 2 THEN
         l_Msg := 'stpks_stdkevi4_Custom ==>'||p_Msg;
         Debug.Pr_Debug('ST' ,l_Msg);
      END IF;
   END Dbg;

   PROCEDURE Pr_Log_Error(p_Function_Id in VARCHAR2,p_Source VARCHAR2,p_Err_Code VARCHAR2, p_Err_Params VARCHAR2) IS
   BEGIN
      Cspks_Req_Utils.Pr_Log_Error(p_Source,p_Function_Id,p_Err_Code,p_Err_Params);
   END Pr_Log_Error;
   PROCEDURE Pr_Skip_Handler(p_Stage in VARCHAR2) IS
   BEGIN
      Dbg('In Pr_Skip_Handler..');
   END Pr_Skip_Handler;
   FUNCTION fn_Post_build_type_structure (p_Source    IN     VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Child_Function    IN  VARCHAR2,
      p_Addl_Info       IN Cspks_Req_Global.Ty_Addl_Info,
      p_stdkevi4     IN  OUT stpks_stdkevi4_Main.ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN
      IS
   BEGIN

      Dbg('In Fn_Post_Build_type_structure..');

      Dbg('Returning Success From Fn_Post_Build_Type_Structure');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others Of stpks_stdkevi4_Custom.Fn_Post_Build_type_structure ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Post_Build_Type_Structure;

   FUNCTION Fn_Pre_Check_Mandatory(p_Source    IN  VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Child_Function    IN  VARCHAR2,
      p_stdkevi4 IN OUT  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code       IN  OUT VARCHAR2,
      p_Err_Params     IN  OUT VARCHAR2)
   RETURN BOOLEAN

      IS
   BEGIN

      Dbg('In Fn_Pre_Check_Mandatory');
      dbg('p_Action_Code' || p_Action_Code);
                IF p_Action_Code = 'VALUE' THEN
            p_stdkevi4.v_master_stdkevi4.CUSTOMER_REFERENCE := ( global.user_id || STDKEVI4_SEQ_R.nextval);
    END IF;
    
    IF p_Action_Code = 'NEW' OR p_Action_Code = 'MODIFY' THEN
      
       FOR I IN 1 .. p_stdkevi4.v_detail_stdkevi4.COUNT  LOOP
         
        p_stdkevi4.v_detail_stdkevi4(I).CUSTOMER_REFERENCE := p_stdkevi4.v_master_stdkevi4.CUSTOMER_REFERENCE;
        IF         p_stdkevi4.v_detail_stdkevi4(I).CUSTOMER_ID IS NULL THEN
          
        p_stdkevi4.v_detail_stdkevi4(I).CUSTOMER_ID := STDKEVI4_SEQ.nextval;
        END IF;
    END LOOP;
    END IF;
      Dbg('Returning Success From Fn_Pre_Check_Mandatory..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Custom.Fn_Pre_Check_Mandatory ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END fn_pre_check_mandatory;

   FUNCTION Fn_Post_Check_Mandatory(p_Source    IN  VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Child_Function    IN  VARCHAR2,
      p_Pk_Or_Full     IN  VARCHAR2 DEFAULT 'FULL',
      p_stdkevi4 IN   stpks_stdkevi4_Main.ty_stdkevi4,
      p_Err_Code       IN  OUT VARCHAR2,
      p_Err_Params     IN  OUT VARCHAR2)
   RETURN BOOLEAN

      IS
   BEGIN

      Dbg('In Fn_Post_Check_Mandatory..');

      Dbg('Returning Success From Fn_Post_Check_Mandatory..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Custom.Fn_Post_Check_Mandatory ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Post_Check_Mandatory;

   FUNCTION Fn_Pre_Default_And_Validate (p_Source    IN  VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Child_Function    IN  VARCHAR2,
      p_stdkevi4 IN   stpks_stdkevi4_Main.ty_stdkevi4,
      p_Prev_stdkevi4 IN OUT stpks_stdkevi4_Main.ty_stdkevi4,
      p_Wrk_stdkevi4 IN OUT  stpks_stdkevi4_Main.ty_stdkevi4,
      p_Err_Code       IN  OUT VARCHAR2,
      p_Err_Params     IN  OUT VARCHAR2)
   RETURN BOOLEAN
      IS
   BEGIN

      Dbg('In Fn_Pre_Default_And_Validate..');
 IF p_Action_Code = 'NEW' OR p_Action_Code = 'MODIFY' THEN
        dbg('p_stdkevi4.v_master_stdkevi4.CUSTOMER_REFERENCE : ' || p_stdkevi4.v_master_stdkevi4.CUSTOMER_REFERENCE);
        
        IF p_Wrk_stdkevi4.v_master_stdkevi4.PRIORITY = 'High' AND p_Wrk_stdkevi4.v_master_stdkevi4.AMOUNT < 1000 THEN
          Pr_Log_Error(p_Function_Id,p_Source ,'stdkevi1' , Null);
          
          ELSIF p_Wrk_stdkevi4.v_master_stdkevi4.PRIORITY = 'Mid' AND p_Wrk_stdkevi4.v_master_stdkevi4.AMOUNT < 500 THEN
             Dbg('Priority Mid');
             Pr_Log_Error(p_Function_Id,p_Source ,'stdkevi2' , Null);
             
             ELSE
               Dbg('Priority Low');
            END IF;
            
            dbg('GLOBAL.application_date'||GLOBAL.application_date);
            IF GLOBAL.application_date < p_Wrk_stdkevi4.v_master_stdkevi4.C_DATE THEN
              Pr_Log_Error(p_Function_Id,p_Source ,'stdkevi3' , Null);
              
            END IF;
            
      END IF;

      Dbg('Returning Success From fn_pre_default_and_validate..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Custom.Fn_Pre_Default_And_Validate ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Pre_Default_And_Validate;

   FUNCTION Fn_Post_Default_And_Validate (p_Source    IN  VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Child_Function    IN  VARCHAR2,
      p_stdkevi4 IN   stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Prev_stdkevi4 IN OUT stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Wrk_stdkevi4 IN OUT  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code       IN  OUT VARCHAR2,
      p_Err_Params     IN  OUT VARCHAR2)
   RETURN BOOLEAN
      IS
   BEGIN

      Dbg('In Fn_Post_Default_And_Validate..');
      
      Dbg('Returning Success From Fn_Post_Default_And_Validate..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Custom.Fn_Post_Default_And_Validate ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Post_Default_And_Validate;

   FUNCTION Fn_Pre_Upload_Db (p_Source    IN  VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Child_Function    IN  VARCHAR2,
      p_Post_Upl_Stat    IN  VARCHAR2,
      p_Multi_Trip_Id    IN  VARCHAR2,
      p_stdkevi4 IN stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Prev_stdkevi4 IN stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Wrk_stdkevi4 IN OUT  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code       IN  OUT VARCHAR2,
      p_Err_Params     IN  OUT VARCHAR2)
   RETURN BOOLEAN
      IS
   BEGIN

      Dbg('In Fn_Pre_Upload_Db..');

      Dbg('Returning Success From Fn_Pre_Upload_Db..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Custom.Fn_Pre_Upload_Db ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Pre_Upload_Db;

   FUNCTION Fn_Post_Upload_Db (p_Source    IN  VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Child_Function    IN  VARCHAR2,
      p_Post_Upl_Stat    IN  VARCHAR2,
      p_Multi_Trip_Id    IN  VARCHAR2,
      p_stdkevi4 IN stpks_stdkevi4_Main.Ty_stdkevi4,
      p_prev_stdkevi4 IN stpks_stdkevi4_Main.Ty_stdkevi4,
      p_wrk_stdkevi4 IN OUT  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code       IN  OUT VARCHAR2,
      p_Err_Params     IN  OUT VARCHAR2)
   RETURN BOOLEAN
      IS
   BEGIN

      Dbg('In Fn_Post_Upload_Db..');

      Dbg('Returning Success From Fn_Post_Upload_Db..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Custom.Fn_Post_Upload_Db ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Post_Upload_Db;

   FUNCTION Fn_Pre_Query  ( p_Source    IN  VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Child_Function    IN  VARCHAR2,
      p_Full_Data     IN  VARCHAR2 DEFAULT 'Y',
      p_With_Lock     IN  VARCHAR2 DEFAULT 'N',
      p_QryData_Reqd IN  VARCHAR2 ,
      p_stdkevi4 IN   stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Wrk_stdkevi4 IN OUT   stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN
      IS
   BEGIN

      Dbg('In Fn_Pre_Query..');

      Dbg('Returning Success From Fn_Pre_Query..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Custom.Fn_Pre_Query ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Pre_Query;

   FUNCTION Fn_Post_Query  ( p_Source    IN  VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Child_Function    IN  VARCHAR2,
      p_Full_Data     IN  VARCHAR2 DEFAULT 'Y',
      p_With_Lock     IN  VARCHAR2 DEFAULT 'N',
      p_QryData_Reqd IN  VARCHAR2 ,
      p_stdkevi4 IN   stpks_stdkevi4_Main.ty_stdkevi4,
      p_wrk_stdkevi4 IN OUT   stpks_stdkevi4_Main.ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_err_params        IN OUT VARCHAR2)
   RETURN BOOLEAN
      IS
   BEGIN

      Dbg('In Fn_Post_Query..');

      Dbg('Returning Success From Fn_Post_Query..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When others of stpks_stdkevi4_Custom.Fn_Post_Query ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Post_Query;


END stpks_stdkevi4_custom;
/