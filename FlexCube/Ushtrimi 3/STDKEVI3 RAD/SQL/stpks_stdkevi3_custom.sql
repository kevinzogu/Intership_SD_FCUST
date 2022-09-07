CREATE OR REPLACE PACKAGE BODY stpks_stdkevi3_custom AS
  /*-----------------------------------------------------------------------------------------------------
  **
  ** File Name  : stpks_stdkevi3_custom.sql
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

  PROCEDURE Dbg(p_msg VARCHAR2) IS
    l_Msg VARCHAR2(32767);
  BEGIN
    IF debug.pkg_debug_on <> 2 THEN
      l_Msg := 'stpks_stdkevi3_Custom ==>' || p_Msg;
      Debug.Pr_Debug('ST', l_Msg);
    END IF;
  END Dbg;

  PROCEDURE Pr_Log_Error(p_Function_Id in VARCHAR2,
                         p_Source      VARCHAR2,
                         p_Err_Code    VARCHAR2,
                         p_Err_Params  VARCHAR2) IS
  BEGIN
    Cspks_Req_Utils.Pr_Log_Error(p_Source,
                                 p_Function_Id,
                                 p_Err_Code,
                                 p_Err_Params);
  END Pr_Log_Error;
  PROCEDURE Pr_Skip_Handler(p_Stage in VARCHAR2) IS
  BEGIN
    Dbg('In Pr_Skip_Handler..');
  END Pr_Skip_Handler;
  FUNCTION fn_Post_build_type_structure(p_Source           IN VARCHAR2,
                                        p_Source_Operation IN VARCHAR2,
                                        p_Function_Id      IN VARCHAR2,
                                        p_Action_Code      IN VARCHAR2,
                                        p_Child_Function   IN VARCHAR2,
                                        p_Addl_Info        IN Cspks_Req_Global.Ty_Addl_Info,
                                        p_stdkevi3         IN OUT stpks_stdkevi3_Main.ty_stdkevi3,
                                        p_Err_Code         IN OUT VARCHAR2,
                                        p_Err_Params       IN OUT VARCHAR2)
    RETURN BOOLEAN IS
  BEGIN
  
    Dbg('In Fn_Post_Build_type_structure..');
  
    Dbg('Returning Success From Fn_Post_Build_Type_Structure');
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      Debug.Pr_Debug('**',
                     'In When Others Of stpks_stdkevi3_Custom.Fn_Post_Build_type_structure ..');
      Debug.Pr_Debug('**', SQLERRM);
      p_Err_Code   := 'ST-OTHR-001';
      p_Err_Params := NULL;
      RETURN FALSE;
  END Fn_Post_Build_Type_Structure;

  FUNCTION Fn_Pre_Check_Mandatory(p_Source           IN VARCHAR2,
                                  p_Source_Operation IN VARCHAR2,
                                  p_Function_id      IN VARCHAR2,
                                  p_Action_Code      IN VARCHAR2,
                                  p_Child_Function   IN VARCHAR2,
                                  p_stdkevi3         IN OUT stpks_stdkevi3_Main.Ty_stdkevi3,
                                  p_Err_Code         IN OUT VARCHAR2,
                                  p_Err_Params       IN OUT VARCHAR2)
    RETURN BOOLEAN
  
   IS
  l_p_id VARCHAR2(25);
  BEGIN
  
    Dbg('In Fn_Pre_Check_Mandatory');
    IF p_Action_Code = 'POPULATE' THEN
      p_stdkevi3.v_master_stdkevi3.COSTUMER_ID := stdkevi3_seq.NEXTVAL;
      
    END IF;
    
    IF p_Action_Code = 'NEW' THEN
      p_stdkevi3.v_master_stdkevi3.COSTUMER_ID := p_stdkevi3.v_master_stdkevi3.COSTUMER_ID;
      dbg(' p_stdkevi3.v_master_stdkevi3.COSTUMER_ID ' ||
          p_stdkevi3.v_master_stdkevi3.COSTUMER_ID);
      FOR I IN 1 .. p_stdkevi3.v_detail_stdkevi3.count LOOP
        p_stdkevi3.v_detail_stdkevi3(I).COSTUMER_ID := p_stdkevi3.v_master_stdkevi3.COSTUMER_ID;
        p_stdkevi3.v_detail_stdkevi3(I).COSTUMER_DETAIL_ID := stdkevi3_seq_d.nextval;
      END LOOP;
    END IF;
    
    --
    
                    DBG('p_Action_Code ' || p_Action_Code);
                    
                    
             DBG('p_stdkevi3.v_master_stdkevi3.COSTUMER_TYPE : ' || p_stdkevi3.v_master_stdkevi3.COSTUMER_TYPE);
         DBG('p_stdkevi3.v_master_stdkevi3.COSTUMER_CATEGORY : ' || p_stdkevi3.v_master_stdkevi3.COSTUMER_CATEGORY);
         
    if p_Action_Code='EXECUTEQUERY' AND p_stdkevi3.v_master_stdkevi3.COSTUMER_TYPE IS NOT NULL AND 
                                           p_stdkevi3.v_master_stdkevi3.COSTUMER_CATEGORY IS NOT NULL 
                                           THEN
         DBG('INSIDE EXECUTE QUERY');

        BEGIN
        SELECT COSTUMER_ID
          INTO l_p_id
          FROM master_stdkevi3
         WHERE COSTUMER_TYPE=
               p_stdkevi3.v_master_stdkevi3.COSTUMER_TYPE 
           AND COSTUMER_CATEGORY=
               p_stdkevi3.v_master_stdkevi3.COSTUMER_CATEGORY;
      
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
            p_stdkevi3.v_master_stdkevi3.COSTUMER_ID :=l_p_id;
        END IF;
              END IF;
    Dbg('Returning Success From Fn_Pre_Check_Mandatory..');
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      Debug.Pr_Debug('**',
                     'In When Others of stpks_stdkevi3_Custom.Fn_Pre_Check_Mandatory ..');
      Debug.Pr_Debug('**', SQLERRM);
      p_Err_Code   := 'ST-OTHR-001';
      p_Err_Params := NULL;
      RETURN FALSE;
  END fn_pre_check_mandatory;

  FUNCTION Fn_Post_Check_Mandatory(p_Source           IN VARCHAR2,
                                   p_Source_Operation IN VARCHAR2,
                                   p_Function_Id      IN VARCHAR2,
                                   p_Action_Code      IN VARCHAR2,
                                   p_Child_Function   IN VARCHAR2,
                                   p_Pk_Or_Full       IN VARCHAR2 DEFAULT 'FULL',
                                   p_stdkevi3         IN stpks_stdkevi3_Main.ty_stdkevi3,
                                   p_Err_Code         IN OUT VARCHAR2,
                                   p_Err_Params       IN OUT VARCHAR2)
    RETURN BOOLEAN
  
   IS
  BEGIN
  
    Dbg('In Fn_Post_Check_Mandatory..');
  
    Dbg('Returning Success From Fn_Post_Check_Mandatory..');
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      Debug.Pr_Debug('**',
                     'In When Others of stpks_stdkevi3_Custom.Fn_Post_Check_Mandatory ..');
      Debug.Pr_Debug('**', SQLERRM);
      p_Err_Code   := 'ST-OTHR-001';
      p_Err_Params := NULL;
      RETURN FALSE;
  END Fn_Post_Check_Mandatory;

  FUNCTION Fn_Pre_Default_And_Validate(p_Source           IN VARCHAR2,
                                       p_Source_Operation IN VARCHAR2,
                                       p_Function_Id      IN VARCHAR2,
                                       p_Action_Code      IN VARCHAR2,
                                       p_Child_Function   IN VARCHAR2,
                                       p_stdkevi3         IN stpks_stdkevi3_Main.ty_stdkevi3,
                                       p_Prev_stdkevi3    IN OUT stpks_stdkevi3_Main.ty_stdkevi3,
                                       p_Wrk_stdkevi3     IN OUT stpks_stdkevi3_Main.ty_stdkevi3,
                                       p_Err_Code         IN OUT VARCHAR2,
                                       p_Err_Params       IN OUT VARCHAR2)
    RETURN BOOLEAN IS
  BEGIN
  
    Dbg('In Fn_Pre_Default_And_Validate..');
  
    Dbg('Returning Success From fn_pre_default_and_validate..');
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      Debug.Pr_Debug('**',
                     'In When Others of stpks_stdkevi3_Custom.Fn_Pre_Default_And_Validate ..');
      Debug.Pr_Debug('**', SQLERRM);
      p_Err_Code   := 'ST-OTHR-001';
      p_Err_Params := NULL;
      RETURN FALSE;
  END Fn_Pre_Default_And_Validate;

  FUNCTION Fn_Post_Default_And_Validate(p_Source           IN VARCHAR2,
                                        p_Source_Operation IN VARCHAR2,
                                        p_Function_Id      IN VARCHAR2,
                                        p_Action_Code      IN VARCHAR2,
                                        p_Child_Function   IN VARCHAR2,
                                        p_stdkevi3         IN stpks_stdkevi3_Main.Ty_stdkevi3,
                                        p_Prev_stdkevi3    IN OUT stpks_stdkevi3_Main.Ty_stdkevi3,
                                        p_Wrk_stdkevi3     IN OUT stpks_stdkevi3_Main.Ty_stdkevi3,
                                        p_Err_Code         IN OUT VARCHAR2,
                                        p_Err_Params       IN OUT VARCHAR2)
    RETURN BOOLEAN IS
    l_index NUMBER := 1;    
    l_count Number := 0;
    l_count1 Number := 0;
    
  BEGIN
  
    Dbg('In Fn_Post_Default_And_Validate..');
  
    ---ketu 
    Dbg('p_Action_Code ' || p_Action_Code);
    
    IF p_Action_Code = 'POPULATE' THEN
      Dbg('p_Action_Code is populate ');
      Dbg('p_Wrk_stdkevi3.v_master_stdkevi3.COSTUMER_TYPE: ' ||
          p_Wrk_stdkevi3.v_master_stdkevi3.COSTUMER_TYPE);
      Dbg(' p_Wrk_stdkevi3.v_master_stdkevi3.COSTUMER_CATEGORY: ' ||
          p_Wrk_stdkevi3.v_master_stdkevi3.COSTUMER_CATEGORY);
    
      BEGIN
      
        SELECT COUNT(*)
          INTO l_count
          FROM master_stdkevi3
         WHERE costumer_type =
               p_Wrk_stdkevi3.v_master_stdkevi3.COSTUMER_TYPE
           AND COSTUMER_CATEGORY =
               p_Wrk_stdkevi3.v_master_stdkevi3.COSTUMER_CATEGORY;
      
        Dbg('Count is :  ' || l_count);
        
              EXCEPTION
        WHEN NO_DATA_FOUND THEN
          dbg('Fail in geting count ');
          RETURN FALSE;
      END;
      
        IF l_count > 0 THEN
        dbg('Count greater than 0 category and type are dublicated ');
         Pr_Log_Error(p_Function_Id,p_Source ,'CS-MAIL08' , Null);
   
        
        ELSE
  
             DBG('Working with populate');
             
             p_Wrk_stdkevi3.v_detail_stdkevi3.delete;
             
             FOR var IN (SELECT field_description, mandatory_validation
                        FROM STDKEVI3_Customer
                       WHERE costumer_type =
                             p_Wrk_stdkevi3.v_master_stdkevi3.COSTUMER_TYPE
                         AND COSTUMER_CATEGORY =
                             p_Wrk_stdkevi3.v_master_stdkevi3.COSTUMER_CATEGORY) LOOP
            Dbg('inside loop index value : ' || l_index);
            p_Wrk_stdkevi3.v_detail_stdkevi3(l_index).FIELD_DESCRIPTION := var.field_description;
            p_Wrk_stdkevi3.v_detail_stdkevi3(l_index).MANDATORY_VALIDATION := var.mandatory_validation;
            dbg('p_Wrk_stdkevi3.v_detail_stdkevi3(l_index).FIELD_DESCRIPTION : ' || p_Wrk_stdkevi3.v_detail_stdkevi3(l_index).FIELD_DESCRIPTION);
            dbg('p_Wrk_stdkevi3.v_detail_stdkevi3(l_index).MANDATORY_VALIDATION' || p_Wrk_stdkevi3.v_detail_stdkevi3(l_index).MANDATORY_VALIDATION);
            l_index := l_index + 1;
            Dbg('index value : ' || l_index);
            END LOOP;
    end if;
    END IF;
    
  
    Dbg('Returning Success From Fn_Post_Default_And_Validate..');
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      Debug.Pr_Debug('**',
                     'In When Others of stpks_stdkevi3_Custom.Fn_Post_Default_And_Validate ..');
      Debug.Pr_Debug('**', SQLERRM);
      p_Err_Code   := 'ST-OTHR-001';
      p_Err_Params := NULL;
      RETURN FALSE;
  END Fn_Post_Default_And_Validate;

  FUNCTION Fn_Pre_Upload_Db(p_Source           IN VARCHAR2,
                            p_Source_Operation IN VARCHAR2,
                            p_Function_Id      IN VARCHAR2,
                            p_Action_Code      IN VARCHAR2,
                            p_Child_Function   IN VARCHAR2,
                            p_Post_Upl_Stat    IN VARCHAR2,
                            p_Multi_Trip_Id    IN VARCHAR2,
                            p_stdkevi3         IN stpks_stdkevi3_Main.Ty_stdkevi3,
                            p_Prev_stdkevi3    IN stpks_stdkevi3_Main.Ty_stdkevi3,
                            p_Wrk_stdkevi3     IN OUT stpks_stdkevi3_Main.Ty_stdkevi3,
                            p_Err_Code         IN OUT VARCHAR2,
                            p_Err_Params       IN OUT VARCHAR2)
    RETURN BOOLEAN IS
  BEGIN
  
    Dbg('In Fn_Pre_Upload_Db..');
  
    Dbg('Returning Success From Fn_Pre_Upload_Db..');
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      Debug.Pr_Debug('**',
                     'In When Others of stpks_stdkevi3_Custom.Fn_Pre_Upload_Db ..');
      Debug.Pr_Debug('**', SQLERRM);
      p_Err_Code   := 'ST-OTHR-001';
      p_Err_Params := NULL;
      RETURN FALSE;
  END Fn_Pre_Upload_Db;

  FUNCTION Fn_Post_Upload_Db(p_Source           IN VARCHAR2,
                             p_Source_Operation IN VARCHAR2,
                             p_Function_Id      IN VARCHAR2,
                             p_Action_Code      IN VARCHAR2,
                             p_Child_Function   IN VARCHAR2,
                             p_Post_Upl_Stat    IN VARCHAR2,
                             p_Multi_Trip_Id    IN VARCHAR2,
                             p_stdkevi3         IN stpks_stdkevi3_Main.Ty_stdkevi3,
                             p_prev_stdkevi3    IN stpks_stdkevi3_Main.Ty_stdkevi3,
                             p_wrk_stdkevi3     IN OUT stpks_stdkevi3_Main.Ty_stdkevi3,
                             p_Err_Code         IN OUT VARCHAR2,
                             p_Err_Params       IN OUT VARCHAR2)
    RETURN BOOLEAN IS
  BEGIN
  
    Dbg('In Fn_Post_Upload_Db..');
  
    Dbg('Returning Success From Fn_Post_Upload_Db..');
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      Debug.Pr_Debug('**',
                     'In When Others of stpks_stdkevi3_Custom.Fn_Post_Upload_Db ..');
      Debug.Pr_Debug('**', SQLERRM);
      p_Err_Code   := 'ST-OTHR-001';
      p_Err_Params := NULL;
      RETURN FALSE;
  END Fn_Post_Upload_Db;

  FUNCTION Fn_Pre_Query(p_Source           IN VARCHAR2,
                        p_Source_Operation IN VARCHAR2,
                        p_Function_Id      IN VARCHAR2,
                        p_Action_Code      IN VARCHAR2,
                        p_Child_Function   IN VARCHAR2,
                        p_Full_Data        IN VARCHAR2 DEFAULT 'Y',
                        p_With_Lock        IN VARCHAR2 DEFAULT 'N',
                        p_QryData_Reqd     IN VARCHAR2,
                        p_stdkevi3         IN stpks_stdkevi3_Main.Ty_stdkevi3,
                        p_Wrk_stdkevi3     IN OUT stpks_stdkevi3_Main.Ty_stdkevi3,
                        p_Err_Code         IN OUT VARCHAR2,
                        p_Err_Params       IN OUT VARCHAR2) RETURN BOOLEAN IS
  BEGIN
  
    Dbg('In Fn_Pre_Query..');
  
    Dbg('Returning Success From Fn_Pre_Query..');
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      Debug.Pr_Debug('**',
                     'In When Others of stpks_stdkevi3_Custom.Fn_Pre_Query ..');
      Debug.Pr_Debug('**', SQLERRM);
      p_Err_Code   := 'ST-OTHR-001';
      p_Err_Params := NULL;
      RETURN FALSE;
  END Fn_Pre_Query;

  FUNCTION Fn_Post_Query(p_Source           IN VARCHAR2,
                         p_Source_Operation IN VARCHAR2,
                         p_Function_Id      IN VARCHAR2,
                         p_Action_Code      IN VARCHAR2,
                         p_Child_Function   IN VARCHAR2,
                         p_Full_Data        IN VARCHAR2 DEFAULT 'Y',
                         p_With_Lock        IN VARCHAR2 DEFAULT 'N',
                         p_QryData_Reqd     IN VARCHAR2,
                         p_stdkevi3         IN stpks_stdkevi3_Main.ty_stdkevi3,
                         p_wrk_stdkevi3     IN OUT stpks_stdkevi3_Main.ty_stdkevi3,
                         p_Err_Code         IN OUT VARCHAR2,
                         p_err_params       IN OUT VARCHAR2) RETURN BOOLEAN IS
  BEGIN
  
    Dbg('In Fn_Post_Query..');
  
    Dbg('Returning Success From Fn_Post_Query..');
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      Debug.Pr_Debug('**',
                     'In When others of stpks_stdkevi3_Custom.Fn_Post_Query ..');
      Debug.Pr_Debug('**', SQLERRM);
      p_Err_Code   := 'ST-OTHR-001';
      p_Err_Params := NULL;
      RETURN FALSE;
  END Fn_Post_Query;

END stpks_stdkevi3_custom;
/