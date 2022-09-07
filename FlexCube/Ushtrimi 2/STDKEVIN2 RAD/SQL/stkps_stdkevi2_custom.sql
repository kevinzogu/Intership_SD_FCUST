CREATE OR REPLACE PACKAGE BODY stpks_stdkevi2_custom AS
     /*-----------------------------------------------------------------------------------------------------
     **
     ** File Name  : stpks_stdkevi2_custom.sql
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
         l_Msg := 'stpks_stdkevi2_Custom ==>'||p_Msg;
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
      p_stdkevi2     IN  OUT stpks_stdkevi2_Main.ty_stdkevi2,
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
         Debug.Pr_Debug('**','In When Others Of stpks_stdkevi2_Custom.Fn_Post_Build_type_structure ..');
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
      p_stdkevi2 IN OUT  stpks_stdkevi2_Main.Ty_stdkevi2,
      p_Err_Code       IN  OUT VARCHAR2,
      p_Err_Params     IN  OUT VARCHAR2)
   RETURN BOOLEAN

      IS
     l_p_id VARCHAR2(25);
   BEGIN

      Dbg('In Fn_Pre_Check_Mandatory');
      if p_Action_Code='NEW' THEN
         p_stdkevi2.v_master_stdkevi2.product_id := stdkevi2_seq_d.NEXTVAL;
        FOR I IN 1..p_stdkevi2.v_DETAIL_stdkevi2.COUNT LOOP
        p_stdkevi2.v_DETAIL_stdkevi2(I).product_id :=  p_stdkevi2.v_master_stdkevi2.product_id;
       END LOOP;
       END IF;
                DBG('OUTSIDE EXECUTE QUERY');
                DBG('p_Action_Code ' || p_Action_Code);
               
         DBG('p_stdkevi2.v_master_stdkevi2.RELATIONSHIP : ' || p_stdkevi2.v_master_stdkevi2.RELATIONSHIP);
         DBG('p_stdkevi2.v_master_stdkevi2.TAB_CATEGORY : ' || p_stdkevi2.v_master_stdkevi2.TAB_CATEGORY);
         
       if p_Action_Code='EXECUTEQUERY' AND p_stdkevi2.v_master_stdkevi2.RELATIONSHIP IS NOT NULL AND 
                                           p_stdkevi2.v_master_stdkevi2.TAB_CATEGORY IS NOT NULL 
                                           THEN
         DBG('INSIDE EXECUTE QUERY');

        BEGIN
        SELECT product_id
          INTO l_p_id
          FROM master_stdkevi2
         WHERE RELATIONSHIP=
               p_stdkevi2.v_master_stdkevi2.RELATIONSHIP 
           AND TAB_CATEGORY=
               p_stdkevi2.v_master_stdkevi2.TAB_CATEGORY;
      
        Dbg('l_p_id is :  ' || l_p_id);
        
              EXCEPTION
        WHEN NO_DATA_FOUND THEN
          dbg('Fail in geting ID ');
          RETURN FALSE;
      END;
       IF l_p_id IS NULL  THEN
        dbg('CAN`T FIND THE ID FOR THIS CATEGORY AND RELATIONSHIP...');
         Pr_Log_Error(p_Function_Id,p_Source ,'CS-MAIL03' , Null);
   
        
        ELSE
            p_stdkevi2.v_master_stdkevi2.product_id :=l_p_id;
        END IF;
              END IF;

      Dbg('Returning Success From Fn_Pre_Check_Mandatory..');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi2_Custom.Fn_Pre_Check_Mandatory ..');
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
      p_stdkevi2 IN   stpks_stdkevi2_Main.ty_stdkevi2,
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
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi2_Custom.Fn_Post_Check_Mandatory ..');
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
      p_stdkevi2 IN   stpks_stdkevi2_Main.ty_stdkevi2,
      p_Prev_stdkevi2 IN OUT stpks_stdkevi2_Main.ty_stdkevi2,
      p_Wrk_stdkevi2 IN OUT  stpks_stdkevi2_Main.ty_stdkevi2,
      p_Err_Code       IN  OUT VARCHAR2,
      p_Err_Params     IN  OUT VARCHAR2)
   RETURN BOOLEAN
      IS
   BEGIN

      Dbg('In Fn_Pre_Default_And_Validate..');

      Dbg('Returning Success From fn_pre_default_and_validate..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi2_Custom.Fn_Pre_Default_And_Validate ..');
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
      p_stdkevi2 IN   stpks_stdkevi2_Main.Ty_stdkevi2,
      p_Prev_stdkevi2 IN OUT stpks_stdkevi2_Main.Ty_stdkevi2,
      p_Wrk_stdkevi2 IN OUT  stpks_stdkevi2_Main.Ty_stdkevi2,
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
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi2_Custom.Fn_Post_Default_And_Validate ..');
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
      p_stdkevi2 IN stpks_stdkevi2_Main.Ty_stdkevi2,
      p_Prev_stdkevi2 IN stpks_stdkevi2_Main.Ty_stdkevi2,
      p_Wrk_stdkevi2 IN OUT  stpks_stdkevi2_Main.Ty_stdkevi2,
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
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi2_Custom.Fn_Pre_Upload_Db ..');
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
      p_stdkevi2 IN stpks_stdkevi2_Main.Ty_stdkevi2,
      p_prev_stdkevi2 IN stpks_stdkevi2_Main.Ty_stdkevi2,
      p_wrk_stdkevi2 IN OUT  stpks_stdkevi2_Main.Ty_stdkevi2,
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
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi2_Custom.Fn_Post_Upload_Db ..');
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
      p_stdkevi2 IN   stpks_stdkevi2_Main.Ty_stdkevi2,
      p_Wrk_stdkevi2 IN OUT   stpks_stdkevi2_Main.Ty_stdkevi2,
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
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi2_Custom.Fn_Pre_Query ..');
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
      p_stdkevi2 IN   stpks_stdkevi2_Main.ty_stdkevi2,
      p_wrk_stdkevi2 IN OUT   stpks_stdkevi2_Main.ty_stdkevi2,
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
         Debug.Pr_Debug('**','In When others of stpks_stdkevi2_Custom.Fn_Post_Query ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Post_Query;


END stpks_stdkevi2_custom;
/