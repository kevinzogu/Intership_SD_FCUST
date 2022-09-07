CREATE OR REPLACE PACKAGE BODY stpks_stdkevi4_main AS
     /*-----------------------------------------------------------------------------------------------------
     **
     ** File Name  : stpks_stdkevi4_main.sql
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
     

   g_Ui_Name            VARCHAR2(50) := 'STDKEVI4';
   g_stdkevi4         stpks_stdkevi4_Main.ty_stdkevi4;
   g_Req_Key                 VARCHAR2(32767);
   g_Key_Id                  VARCHAR2(32767);
   g_Post_Upl_Stat     VARCHAR2(1);
   g_Curr_Stage        VARCHAR2(20);
   g_Tanking_Status      VARCHAR2(1);
   --Skip Handler Variables
   g_Skip_Sys       BOOLEAN := FALSE;
   g_Skip_Custom    BOOLEAN := FALSE;
   PROCEDURE Dbg(p_msg VARCHAR2)  IS
      l_Msg     VARCHAR2(32767);
   BEGIN
      IF debug.pkg_debug_on <> 2 THEN
         l_Msg := 'stpks_stdkevi4_Main ==>'||p_Msg;
         Debug.Pr_Debug('ST' ,l_Msg);
      END IF;
   END Dbg;

   PROCEDURE Pr_Log_Error(p_Source VARCHAR2,p_Err_Code VARCHAR2, p_Err_Params VARCHAR2) IS
      l_Fid    VARCHAR2(32767) := 'STDKEVI4';
   BEGIN
      Cspks_Req_Utils.Pr_Log_Error(p_Source,l_Fid,p_Err_Code,p_Err_Params);
   END Pr_Log_Error;
   FUNCTION  Fn_Get_Curr_Stage RETURN VARCHAR2 IS
   BEGIN
      RETURN g_Curr_Stage;
   END  Fn_Get_Curr_Stage;
   FUNCTION  Fn_Get_Tanked_Stat RETURN VARCHAR2 IS
   BEGIN
      RETURN g_Tanking_Status;
   END  Fn_get_tanked_stat;
   PROCEDURE Pr_Skip_Handler(p_Stage in VARCHAR2) IS
   BEGIN
      stpks_stdkevi4_Custom.Pr_Skip_Handler (P_Stage);
   END Pr_Skip_Handler;
   PROCEDURE Pr_Set_Skip_Sys IS
   BEGIN
      g_Skip_Sys := TRUE;
   END Pr_Set_Skip_Sys;
   PROCEDURE Pr_Set_Activate_Sys IS
   BEGIN
      g_Skip_Sys := FALSE;
   END Pr_Set_Activate_Sys;
   FUNCTION  Fn_Skip_Sys RETURN BOOLEAN IS
   BEGIN
      RETURN G_Skip_Sys;
   END  Fn_Skip_Sys;
   PROCEDURE Pr_Set_Skip_Custom IS
   BEGIN
      g_Skip_Custom := TRUE;
   END Pr_Set_Skip_Custom;
   PROCEDURE Pr_Set_Activate_Custom IS
   BEGIN
      g_Skip_Custom := FALSE;
   END Pr_Set_Activate_Custom;
   FUNCTION  Fn_Skip_Custom RETURN BOOLEAN IS
   BEGIN
      IF g_curr_stage IS NOT NULL THEN
         RETURN G_Skip_Custom;
      ELSIF Cspks_Req_Global.g_Release_Type IN(Cspks_Req_Global.p_Kernel,Cspks_Req_Global.P_Cluster) THEN
         RETURN TRUE;
      ELSIF Cspks_Req_Global.g_Release_Type =Cspks_Req_Global.p_Custom THEN
         RETURN FALSE;
      ELSE
         RETURN G_Skip_Custom;
      END IF;
   END  Fn_Skip_Custom;
   FUNCTION Fn_Sys_Build_Fc_Type (p_Source    IN     VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Addl_Info       IN Cspks_Req_Global.Ty_Addl_Info,
      p_stdkevi4       IN   OUT stpks_stdkevi4_Main.ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN   IS

      l_Pk_counter        NUMBER :=1;
      l_Count             NUMBER;
      l_Parent_Rec        NUMBER :=0;
      l_Key               VARCHAR2(255);
      l_Pkey              VARCHAR2(32767);
      l_PVal              VARCHAR2(32767);
      l_Val               VARCHAR2(32767);
      l_Tag               VARCHAR2(100);
      l_Node              VARCHAR2(100);
      l_Key_Vals          VARCHAR2(32767);
      l_Key_Tags          VARCHAR2(32767);
      l_Source_Operation  VARCHAR2(100) := p_Source_Operation;
      l_Dsn_Rec_Cnt_2    NUMBER;
      l_Bnd_Cntr_2    NUMBER;

   BEGIN

      dbg('In Fn_Sys_Build_Fc_Type..');

      l_Node := Cspks_Req_Global.Fn_GetNode;
      WHILE (l_Node <> 'EOPL')
      LOOP
         --Dbg('Node Name  :'||l_Node);
         IF  l_Node = 'BLK_MASTER' THEN
            p_stdkevi4.v_master_stdkevi4.AMOUNT := Cspks_Req_Global.Fn_GetVal;
            p_stdkevi4.v_master_stdkevi4.CCY := Cspks_Req_Global.Fn_GetVal;
            p_stdkevi4.v_master_stdkevi4.CUSTOMER_ACCOUNT := Cspks_Req_Global.Fn_GetVal;
            p_stdkevi4.v_master_stdkevi4.CUSTOMER_NAME := Cspks_Req_Global.Fn_GetVal;
            p_stdkevi4.v_master_stdkevi4.CUSTOMER_NO := Cspks_Req_Global.Fn_GetVal;
            l_Val       := Cspks_Req_Global.Fn_GetVal;
            IF Length(l_Val) > Length(Cspks_Req_Global.g_Date_Format) THEN
               p_stdkevi4.v_master_stdkevi4.C_DATE := TO_DATE(l_val,Cspks_Req_Global.g_Date_Time_Format);
            ELSE
               p_stdkevi4.v_master_stdkevi4.C_DATE := TO_DATE(l_val,Cspks_Req_Global.g_Date_Format);
            END IF;
            p_stdkevi4.v_master_stdkevi4.EMAIL := Cspks_Req_Global.Fn_GetVal;
            p_stdkevi4.v_master_stdkevi4.PHONE_NUMBER := Cspks_Req_Global.Fn_GetVal;
            p_stdkevi4.v_master_stdkevi4.PRIORITY := Cspks_Req_Global.Fn_GetVal;
            p_stdkevi4.v_master_stdkevi4.MAKER_ID := Cspks_Req_Global.Fn_GetVal;
            l_Val       := Cspks_Req_Global.Fn_GetVal;
            IF Length(l_Val) > Length(Cspks_Req_Global.g_Date_Format) THEN
               p_stdkevi4.v_master_stdkevi4.MAKER_DT_STAMP := TO_DATE(l_val,Cspks_Req_Global.g_Date_Time_Format);
            ELSE
               p_stdkevi4.v_master_stdkevi4.MAKER_DT_STAMP := TO_DATE(l_val,Cspks_Req_Global.g_Date_Format);
            END IF;
            p_stdkevi4.v_master_stdkevi4.CHECKER_ID := Cspks_Req_Global.Fn_GetVal;
            l_Val       := Cspks_Req_Global.Fn_GetVal;
            IF Length(l_Val) > Length(Cspks_Req_Global.g_Date_Format) THEN
               p_stdkevi4.v_master_stdkevi4.CHECKER_DT_STAMP := TO_DATE(l_val,Cspks_Req_Global.g_Date_Time_Format);
            ELSE
               p_stdkevi4.v_master_stdkevi4.CHECKER_DT_STAMP := TO_DATE(l_val,Cspks_Req_Global.g_Date_Format);
            END IF;
            p_stdkevi4.v_master_stdkevi4.MOD_NO := Cspks_Req_Global.Fn_GetVal;
            p_stdkevi4.v_master_stdkevi4.RECORD_STAT := Cspks_Req_Global.Fn_GetVal;
            p_stdkevi4.v_master_stdkevi4.AUTH_STAT := Cspks_Req_Global.Fn_GetVal;
            p_stdkevi4.v_master_stdkevi4.ONCE_AUTH := Cspks_Req_Global.Fn_GetVal;
         ELSIF  l_Node = 'BLK_DETAIL' THEN
            l_Dsn_Rec_Cnt_2 :=  p_stdkevi4.v_detail_stdkevi4.count +1 ;
            p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).CUSTOMER_ID := Cspks_Req_Global.Fn_GetVal;
            p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).CUSTOMER_NO := Cspks_Req_Global.Fn_GetVal;
            p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).DETAIL_DESCRIPTION := Cspks_Req_Global.Fn_GetVal;
            p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).DETAIL_USER := Cspks_Req_Global.Fn_GetVal;
            l_Val       := Cspks_Req_Global.Fn_GetVal;
            IF Length(l_Val) > Length(Cspks_Req_Global.g_Date_Format) THEN
               p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).D_DATE := TO_DATE(l_val,Cspks_Req_Global.g_Date_Time_Format);
            ELSE
               p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).D_DATE := TO_DATE(l_val,Cspks_Req_Global.g_Date_Format);
            END IF;
            p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).SUBJECT := Cspks_Req_Global.Fn_GetVal;
            p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).customer_no :=p_stdkevi4.v_master_stdkevi4.customer_no;
         END IF;
         l_Node := Cspks_Req_Global.Fn_GetNode;
      END LOOP;

      p_stdkevi4.Addl_Info := p_Addl_Info;
      Dbg('Returning Success From Fn_Sys_Build_Fc_Type.. ');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Main.Fn_Sys_Build_Fc_Type ');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Sys_Build_Fc_Type;
   FUNCTION Fn_Sys_Build_Ws_Type (p_Source    IN     VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Addl_Info       IN Cspks_Req_Global.Ty_Addl_Info,
      p_stdkevi4       IN   OUT stpks_stdkevi4_Main.ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN   IS

      l_Pk_counter        NUMBER :=1;
      l_Count             NUMBER;
      l_Parent_Rec        NUMBER :=0;
      l_Key               VARCHAR2(255);
      l_Pkey              VARCHAR2(32767);
      l_PVal              VARCHAR2(32767);
      l_Val               VARCHAR2(32767);
      l_Tag               VARCHAR2(100);
      l_Node              VARCHAR2(100);
      l_Key_Vals          VARCHAR2(32767);
      l_Key_Tags          VARCHAR2(32767);
      l_Source_Operation  VARCHAR2(100) := p_Source_Operation;
      Invalid_Date        EXCEPTION;
      l_Dsn_Rec_Cnt_2    NUMBER;
      l_Bnd_Cntr_2    NUMBER;

   BEGIN

      dbg('In Fn_Sys_Build_Ws_Type..');

      l_Node := Cspks_Req_Global.Fn_GetNode;
      WHILE (l_Node <> 'EOPL')
      LOOP
         --Dbg('Node Name  :'||l_Node);
         IF  l_Node IN ( 'BLK_MASTER','Master-Full','Master-IO') THEN
            l_Key       := Cspks_Req_Global.Fn_GetTag;
            l_Val       := Cspks_Req_Global.Fn_GetVal;
            WHILE (l_Key <> 'EOPL')
            LOOP
               --dbg('Key/Value   :'||l_Key ||':'||l_Val);
               IF l_Key = 'AMOUNT' THEN
                  p_stdkevi4.v_master_stdkevi4.AMOUNT := l_Val;
               ELSIF l_Key = 'CCY' THEN
                  p_stdkevi4.v_master_stdkevi4.CCY := l_Val;
               ELSIF l_Key IN( 'ACCOPT','CUSTOMER_ACCOUNT')  THEN
                  p_stdkevi4.v_master_stdkevi4.CUSTOMER_ACCOUNT := l_Val;
               ELSIF l_Key = 'CUSTOMER_NAME' THEN
                  p_stdkevi4.v_master_stdkevi4.CUSTOMER_NAME := l_Val;
               ELSIF l_Key = 'CUSTOMER_NO' THEN
                  p_stdkevi4.v_master_stdkevi4.CUSTOMER_NO := l_Val;
               ELSIF l_Key IN( 'INCORPDT','C_DATE')  THEN
                  BEGIN
                     IF Length(l_Val) > Length(Cspks_Req_Global.g_Date_Format) THEN
                        p_stdkevi4.v_master_stdkevi4.C_DATE := TO_DATE(l_val,Cspks_Req_Global.g_Date_Time_Format);
                     ELSE
                        p_stdkevi4.v_master_stdkevi4.C_DATE := TO_DATE(l_val,Cspks_Req_Global.g_Date_Format);
                     END IF;
                  EXCEPTION
                     WHEN OTHERS THEN
                        RAISE Invalid_Date;
                  END;
               ELSIF l_Key = 'EMAIL' THEN
                  p_stdkevi4.v_master_stdkevi4.EMAIL := l_Val;
               ELSIF l_Key = 'PHONE_NUMBER' THEN
                  p_stdkevi4.v_master_stdkevi4.PHONE_NUMBER := l_Val;
               ELSIF l_Key = 'PRIORITY' THEN
                  p_stdkevi4.v_master_stdkevi4.PRIORITY := l_Val;
               ELSIF l_Key = 'MAKER' THEN
                  p_stdkevi4.v_master_stdkevi4.MAKER_ID := l_Val;
               ELSIF l_Key = 'MAKERSTAMP' THEN
                  BEGIN
                     IF Length(l_Val) > Length(Cspks_Req_Global.g_Date_Format) THEN
                        p_stdkevi4.v_master_stdkevi4.MAKER_DT_STAMP := TO_DATE(l_val,Cspks_Req_Global.g_Date_Time_Format);
                     ELSE
                        p_stdkevi4.v_master_stdkevi4.MAKER_DT_STAMP := TO_DATE(l_val,Cspks_Req_Global.g_Date_Format);
                     END IF;
                  EXCEPTION
                     WHEN OTHERS THEN
                        RAISE Invalid_Date;
                  END;
               ELSIF l_Key = 'CHECKER' THEN
                  p_stdkevi4.v_master_stdkevi4.CHECKER_ID := l_Val;
               ELSIF l_Key = 'CHECKERSTAMP' THEN
                  BEGIN
                     IF Length(l_Val) > Length(Cspks_Req_Global.g_Date_Format) THEN
                        p_stdkevi4.v_master_stdkevi4.CHECKER_DT_STAMP := TO_DATE(l_val,Cspks_Req_Global.g_Date_Time_Format);
                     ELSE
                        p_stdkevi4.v_master_stdkevi4.CHECKER_DT_STAMP := TO_DATE(l_val,Cspks_Req_Global.g_Date_Format);
                     END IF;
                  EXCEPTION
                     WHEN OTHERS THEN
                        RAISE Invalid_Date;
                  END;
               ELSIF l_Key = 'MODNO' THEN
                  p_stdkevi4.v_master_stdkevi4.MOD_NO := l_Val;
               ELSIF l_Key = 'TXNSTAT' THEN
                  p_stdkevi4.v_master_stdkevi4.RECORD_STAT := l_Val;
               ELSIF l_Key = 'AUTHSTAT' THEN
                  p_stdkevi4.v_master_stdkevi4.AUTH_STAT := l_Val;
               ELSIF l_Key = 'ONCEAUTH' THEN
                  p_stdkevi4.v_master_stdkevi4.ONCE_AUTH := l_Val;
               END IF;
               l_Key       := Cspks_Req_Global.Fn_GetTag;
               l_Val       := Cspks_Req_Global.Fn_GetVal;
            END LOOP;
         ELSIF  l_Node IN ( 'BLK_DETAIL','Detail') THEN
            l_Dsn_Rec_Cnt_2 :=  p_stdkevi4.v_detail_stdkevi4.count +1 ;
            l_Key       := Cspks_Req_Global.Fn_GetTag;
            l_Val       := Cspks_Req_Global.Fn_GetVal;
            WHILE (l_Key <> 'EOPL')
            LOOP
               --dbg('Key/Value   :'||l_Key ||':'||l_Val);
               IF l_Key = 'CUSTOMER_ID' THEN
                  p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).CUSTOMER_ID := l_Val;
               ELSIF l_Key = 'CUSTOMER_NO' THEN
                  p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).CUSTOMER_NO := l_Val;
               ELSIF l_Key IN( 'FILE_CON_CDE_DESC','DETAIL_DESCRIPTION')  THEN
                  p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).DETAIL_DESCRIPTION := l_Val;
               ELSIF l_Key IN( 'USER','DETAIL_USER')  THEN
                  p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).DETAIL_USER := l_Val;
               ELSIF l_Key IN( 'INCORPDT','D_DATE')  THEN
                  BEGIN
                     IF Length(l_Val) > Length(Cspks_Req_Global.g_Date_Format) THEN
                        p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).D_DATE := TO_DATE(l_val,Cspks_Req_Global.g_Date_Time_Format);
                     ELSE
                        p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).D_DATE := TO_DATE(l_val,Cspks_Req_Global.g_Date_Format);
                     END IF;
                  EXCEPTION
                     WHEN OTHERS THEN
                        RAISE Invalid_Date;
                  END;
               ELSIF l_Key = 'SUBJECT' THEN
                  p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).SUBJECT := l_Val;
               END IF;
               l_Key       := Cspks_Req_Global.Fn_GetTag;
               l_Val       := Cspks_Req_Global.Fn_GetVal;
            END LOOP;
            p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).customer_no :=p_stdkevi4.v_master_stdkevi4.customer_no;
         END IF;
         l_Node := Cspks_Req_Global.Fn_GetNode;
      END LOOP;

      p_stdkevi4.Addl_Info := p_Addl_Info;
      Dbg('Returning Success From Fn_Sys_Build_Fc_Type.. ');
      RETURN TRUE;

   EXCEPTION
      WHEN Invalid_Date THEN
         Pr_Log_Error(p_Source,'ST-OTHR-003',l_Key||'~'||Cspks_Req_Global.g_Date_Format) ;
         RETURN FALSE;
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Main.Fn_Sys_Build_Fc_Type ');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Sys_Build_Ws_Type;
   FUNCTION Fn_Sys_Build_Fc_Ts (p_Source    IN     VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_stdkevi4          IN stpks_stdkevi4_Main.ty_stdkevi4,
      p_Err_Code        IN OUT VARCHAR2,
      p_Err_Params      IN OUT VARCHAR2)
   RETURN BOOLEAN   IS
      l_Level_Format  VARCHAR2(32767);
      l_Parent_Format VARCHAR2(32767);
      l_Date_Val      VARCHAR2(32767);
      l_Master_Childs NUMBER := 0;
      l_Desc_Vc          VARCHAR2(32767);
      l_Source_Operation       VARCHAR2(100) := p_Source_Operation;
      l_0_Lvl_Counter NUMBER := 0;
      l_1_Lvl_Counter NUMBER := 0;
      l_2_Lvl_Counter   NUMBER := 0;
      l_Dsn_Rec_Cnt_2    NUMBER;
      l_Bnd_Cntr_2    NUMBER;
      l_Cntr_Before   NUMBER := 0;
      l_Master_Where  VARCHAR2(32767);
      l_Count         NUMBER := 0;

   BEGIN
      Dbg('In Fn_Sys_Build_Fc_Ts..');

      --Dbg('Building Childs Of :..');
      l_1_Lvl_Counter := 0;
      l_0_Lvl_Counter   := l_0_Lvl_Counter +1;
      l_Level_Format      := l_0_Lvl_Counter;
      Cspks_Req_Global.Pr_Write('P','BLK_MASTER',l_Level_Format);
      Cspks_Req_Global.Pr_Write('V','AMOUNT',p_stdkevi4.v_master_stdkevi4.amount);
      Cspks_Req_Global.Pr_Write('V','CCY',p_stdkevi4.v_master_stdkevi4.ccy);
      Cspks_Req_Global.Pr_Write('V','CUSTOMER_ACCOUNT',p_stdkevi4.v_master_stdkevi4.customer_account);
      Cspks_Req_Global.Pr_Write('V','CUSTOMER_NAME',p_stdkevi4.v_master_stdkevi4.customer_name);
      Cspks_Req_Global.Pr_Write('V','CUSTOMER_NO',p_stdkevi4.v_master_stdkevi4.customer_no);
      IF trunc(p_stdkevi4.v_master_stdkevi4.c_date) <>
            p_stdkevi4.v_master_stdkevi4.c_date THEN
         l_Date_Val :=  TO_CHAR( p_stdkevi4.v_master_stdkevi4.c_date,Cspks_Req_Global.g_Ws_Date_Time_Format);
      ELSE
         l_Date_Val :=  TO_CHAR( p_stdkevi4.v_master_stdkevi4.c_date,Cspks_Req_Global.g_Ws_Date_Format);
      END IF;
      Cspks_Req_Global.Pr_Write('V','C_DATE',l_Date_Val);
      Cspks_Req_Global.Pr_Write('V','EMAIL',p_stdkevi4.v_master_stdkevi4.email);
      Cspks_Req_Global.Pr_Write('V','PHONE_NUMBER',p_stdkevi4.v_master_stdkevi4.phone_number);
      Cspks_Req_Global.Pr_Write('V','PRIORITY',p_stdkevi4.v_master_stdkevi4.priority);
      Cspks_Req_Global.Pr_Write('V','MAKER',p_stdkevi4.v_master_stdkevi4.maker_id);
      IF trunc(p_stdkevi4.v_master_stdkevi4.maker_dt_stamp) <>
            p_stdkevi4.v_master_stdkevi4.maker_dt_stamp THEN
         l_Date_Val :=  TO_CHAR( p_stdkevi4.v_master_stdkevi4.maker_dt_stamp,Cspks_Req_Global.g_Ws_Date_Time_Format);
      ELSE
         l_Date_Val :=  TO_CHAR( p_stdkevi4.v_master_stdkevi4.maker_dt_stamp,Cspks_Req_Global.g_Ws_Date_Format);
      END IF;
      Cspks_Req_Global.Pr_Write('V','MAKERSTAMP',l_Date_Val);
      Cspks_Req_Global.Pr_Write('V','CHECKER',p_stdkevi4.v_master_stdkevi4.checker_id);
      IF trunc(p_stdkevi4.v_master_stdkevi4.checker_dt_stamp) <>
            p_stdkevi4.v_master_stdkevi4.checker_dt_stamp THEN
         l_Date_Val :=  TO_CHAR( p_stdkevi4.v_master_stdkevi4.checker_dt_stamp,Cspks_Req_Global.g_Ws_Date_Time_Format);
      ELSE
         l_Date_Val :=  TO_CHAR( p_stdkevi4.v_master_stdkevi4.checker_dt_stamp,Cspks_Req_Global.g_Ws_Date_Format);
      END IF;
      Cspks_Req_Global.Pr_Write('V','CHECKERSTAMP',l_Date_Val);
      Cspks_Req_Global.Pr_Write('V','MODNO',p_stdkevi4.v_master_stdkevi4.mod_no);
      Cspks_Req_Global.Pr_Write('V','TXNSTAT',p_stdkevi4.v_master_stdkevi4.record_stat);
      Cspks_Req_Global.Pr_Write('V','AUTHSTAT',p_stdkevi4.v_master_stdkevi4.auth_stat);
      Cspks_Req_Global.Pr_Write('V','ONCEAUTH',p_stdkevi4.v_master_stdkevi4.once_auth);

      --Dbg('Building Childs Of :BLK_MASTER..');
      l_Dsn_Rec_Cnt_2 := 0;
      IF p_stdkevi4.v_detail_stdkevi4.COUNT > 0 THEN
         FOR i_2 IN  1..p_stdkevi4.v_detail_stdkevi4.COUNT LOOP
            l_Dsn_Rec_Cnt_2 := i_2;
            l_Master_Childs  :=  l_Master_Childs +1;
            l_1_Lvl_Counter   := l_1_Lvl_Counter +1;
            l_Level_Format      := l_0_Lvl_Counter||'.'||l_1_Lvl_Counter;
            Cspks_Req_Global.Pr_Write('P','BLK_DETAIL',l_Level_Format);
            Cspks_Req_Global.Pr_Write('V','CUSTOMER_ID',p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).customer_id);
            Cspks_Req_Global.Pr_Write('V','CUSTOMER_NO',p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).customer_no);
            Cspks_Req_Global.Pr_Write('V','DETAIL_DESCRIPTION',p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).detail_description);
            Cspks_Req_Global.Pr_Write('V','DETAIL_USER',p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).detail_user);
            IF trunc(p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).d_date) <>
                  p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).d_date THEN
               l_Date_Val :=  TO_CHAR( p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).d_date,Cspks_Req_Global.g_Ws_Date_Time_Format);
            ELSE
               l_Date_Val :=  TO_CHAR( p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).d_date,Cspks_Req_Global.g_Ws_Date_Format);
            END IF;
            Cspks_Req_Global.Pr_Write('V','D_DATE',l_Date_Val);
            Cspks_Req_Global.Pr_Write('V','SUBJECT',p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).subject);
         END LOOP;
      END IF;
      Dbg('Returning Success From Fn_Sys_Build_Fc_Ts..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Sys_Build_Fc_Ts..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Sys_Build_Fc_Ts;
   FUNCTION Fn_Sys_Build_Ws_Ts (p_Source    IN     VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Exchange_Pattern IN       VARCHAR2,
      p_stdkevi4          IN stpks_stdkevi4_Main.ty_stdkevi4,
      p_Err_Code        IN OUT VARCHAR2,
      p_Err_Params      IN OUT VARCHAR2)
   RETURN BOOLEAN   IS
      l_Level_Format  VARCHAR2(32767);
      l_Parent_Format VARCHAR2(32767);
      l_Date_Val      VARCHAR2(32767);
      l_Master_Childs NUMBER := 0;
      l_Desc_Vc          VARCHAR2(32767);
      l_Source_Operation       VARCHAR2(100) := p_Source_Operation;
      l_Key_Cols          VARCHAR2(32767);
      l_Key_Vals          VARCHAR2(32767);
      l_0_Lvl_Counter NUMBER := 0;
      l_1_Lvl_Counter NUMBER := 0;
      l_2_Lvl_Counter   NUMBER := 0;
      l_Dsn_Rec_Cnt_2    NUMBER;
      l_Bnd_Cntr_2    NUMBER;
      l_Cntr_Before   NUMBER := 0;
      l_Master_Where  VARCHAR2(32767);
      l_Count         NUMBER := 0;

   BEGIN
      Dbg('In Fn_Sys_Build_Ws_Ts..');
      IF SUBSTR(p_Exchange_Pattern,3,4) = 'FS' THEN
         Dbg('Building Full Screen Reply..');

         --Dbg('Building Childs Of :..');
         IF (  p_stdkevi4.v_master_stdkevi4.customer_no IS NOT NULL 
          )
          THEN
            l_1_Lvl_Counter := 0;
            l_0_Lvl_Counter   := l_0_Lvl_Counter +1;
            l_Level_Format      := l_0_Lvl_Counter;
            Cspks_Req_Global.Pr_Write('P','Master-Full',l_Level_Format);
            Cspks_Req_Global.Pr_Write('V','AMOUNT',p_stdkevi4.v_master_stdkevi4.amount);
            Cspks_Req_Global.Pr_Write('V','CCY',p_stdkevi4.v_master_stdkevi4.ccy);
            Cspks_Req_Global.Pr_Write('V','ACCOPT',p_stdkevi4.v_master_stdkevi4.customer_account);
            Cspks_Req_Global.Pr_Write('V','CUSTOMER_NAME',p_stdkevi4.v_master_stdkevi4.customer_name);
            Cspks_Req_Global.Pr_Write('V','CUSTOMER_NO',p_stdkevi4.v_master_stdkevi4.customer_no);
            IF trunc(p_stdkevi4.v_master_stdkevi4.c_date) <>
                  p_stdkevi4.v_master_stdkevi4.c_date THEN
               l_Date_Val :=  TO_CHAR( p_stdkevi4.v_master_stdkevi4.c_date,Cspks_Req_Global.g_Ws_Date_Time_Format);
            ELSE
               l_Date_Val :=  TO_CHAR( p_stdkevi4.v_master_stdkevi4.c_date,Cspks_Req_Global.g_Ws_Date_Format);
            END IF;
            Cspks_Req_Global.Pr_Write('V','INCORPDT',l_Date_Val);
            Cspks_Req_Global.Pr_Write('V','EMAIL',p_stdkevi4.v_master_stdkevi4.email);
            Cspks_Req_Global.Pr_Write('V','PHONE_NUMBER',p_stdkevi4.v_master_stdkevi4.phone_number);
            Cspks_Req_Global.Pr_Write('V','PRIORITY',p_stdkevi4.v_master_stdkevi4.priority);
            Cspks_Req_Global.Pr_Write('V','MAKER',p_stdkevi4.v_master_stdkevi4.maker_id);
            IF trunc(p_stdkevi4.v_master_stdkevi4.maker_dt_stamp) <>
                  p_stdkevi4.v_master_stdkevi4.maker_dt_stamp THEN
               l_Date_Val :=  TO_CHAR( p_stdkevi4.v_master_stdkevi4.maker_dt_stamp,Cspks_Req_Global.g_Ws_Date_Time_Format);
            ELSE
               l_Date_Val :=  TO_CHAR( p_stdkevi4.v_master_stdkevi4.maker_dt_stamp,Cspks_Req_Global.g_Ws_Date_Format);
            END IF;
            Cspks_Req_Global.Pr_Write('V','MAKERSTAMP',l_Date_Val);
            Cspks_Req_Global.Pr_Write('V','CHECKER',p_stdkevi4.v_master_stdkevi4.checker_id);
            IF trunc(p_stdkevi4.v_master_stdkevi4.checker_dt_stamp) <>
                  p_stdkevi4.v_master_stdkevi4.checker_dt_stamp THEN
               l_Date_Val :=  TO_CHAR( p_stdkevi4.v_master_stdkevi4.checker_dt_stamp,Cspks_Req_Global.g_Ws_Date_Time_Format);
            ELSE
               l_Date_Val :=  TO_CHAR( p_stdkevi4.v_master_stdkevi4.checker_dt_stamp,Cspks_Req_Global.g_Ws_Date_Format);
            END IF;
            Cspks_Req_Global.Pr_Write('V','CHECKERSTAMP',l_Date_Val);
            Cspks_Req_Global.Pr_Write('V','MODNO',p_stdkevi4.v_master_stdkevi4.mod_no);
            Cspks_Req_Global.Pr_Write('V','TXNSTAT',p_stdkevi4.v_master_stdkevi4.record_stat);
            Cspks_Req_Global.Pr_Write('V','AUTHSTAT',p_stdkevi4.v_master_stdkevi4.auth_stat);

            --Dbg('Building Childs Of :BLK_MASTER..');
            l_Dsn_Rec_Cnt_2 := 0;
            IF p_stdkevi4.v_detail_stdkevi4.COUNT > 0 THEN
               FOR i_2 IN  1..p_stdkevi4.v_detail_stdkevi4.COUNT LOOP
                  l_Dsn_Rec_Cnt_2 := i_2;
                  l_Master_Childs  :=  l_Master_Childs +1;
                  l_1_Lvl_Counter   := l_1_Lvl_Counter +1;
                  l_Level_Format      := l_0_Lvl_Counter||'.'||l_1_Lvl_Counter;
                  Cspks_Req_Global.Pr_Write('P','Detail',l_Level_Format);
                  Cspks_Req_Global.Pr_Write('V','FILE_CON_CDE_DESC',p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).detail_description);
                  Cspks_Req_Global.Pr_Write('V','USER',p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).detail_user);
                  IF trunc(p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).d_date) <>
                        p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).d_date THEN
                     l_Date_Val :=  TO_CHAR( p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).d_date,Cspks_Req_Global.g_Ws_Date_Time_Format);
                  ELSE
                     l_Date_Val :=  TO_CHAR( p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).d_date,Cspks_Req_Global.g_Ws_Date_Format);
                  END IF;
                  Cspks_Req_Global.Pr_Write('V','INCORPDT',l_Date_Val);
                  Cspks_Req_Global.Pr_Write('V','SUBJECT',p_stdkevi4.v_detail_stdkevi4(l_Dsn_Rec_Cnt_2).subject);
               END LOOP;
            END IF;
         END IF;
      ELSE
         Dbg('Building Primary Key Reply..');
         Cspks_Req_Global.pr_Write('P','Master-PK','1');
         l_Key_Cols := 'CUSTOMER_NO~';
         l_Key_Vals := p_stdkevi4.v_master_stdkevi4.customer_no||'~';
         Cspks_Req_Global.pr_Write('V',l_Key_Cols,l_Key_Vals);
      END IF;
      Dbg('Returning Success From Fn_Sys_Build_Ws_Ts..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Sys_Build_Fc_Ts..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Sys_Build_Ws_Ts;
   FUNCTION Fn_Sys_Check_Mandatory (p_Source    IN  VARCHAR2,
      p_Pk_Or_Full     IN  VARCHAR2 DEFAULT 'FULL',
      p_stdkevi4 IN  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code       IN  OUT VARCHAR2,
      p_Err_Params     IN  OUT VARCHAR2)
   RETURN BOOLEAN IS

      l_Count          NUMBER:= 0;
      l_Key            VARCHAR2(5000);
      l_Blk            VARCHAR2(100);
      l_Fld            VARCHAR2(100);
      l_Rec_Sent       BOOLEAN := TRUE;
      l_Base_Data_From_Fc  VARCHAR2(1):= 'Y';

   BEGIN

      Dbg('In Fn_Sys_Check_Mandatory..');

      l_Fld := 'MASTER_STDKEVI4.CUSTOMER_NO';
      IF p_stdkevi4.v_master_stdkevi4.customer_no IS Null THEN
         Dbg('Field customer_no is Null..');
         p_Err_Code    := 'ST-MAND-001';
         p_Err_Params := '@'||l_Fld;
         RETURN FALSE;
      END IF;

      IF p_Pk_Or_Full = 'FULL'  THEN
         Dbg('Full Mandatory Checks..');

         l_Blk := 'MASTER_STDKEVI4';

         l_Blk := 'DETAIL_STDKEVI4';
         l_Count := p_stdkevi4.v_detail_stdkevi4.COUNT;
         IF l_Count > 0 THEN
            FOR l_index IN 1 .. p_stdkevi4.v_detail_stdkevi4.COUNT LOOP
               l_Fld := 'DETAIL_STDKEVI4.CUSTOMER_ID';
               IF p_stdkevi4.v_detail_stdkevi4(l_Index).customer_id IS Null THEN
                  Dbg('Primary Key Column customer_id Cannot Be Null');
                  l_Key := Null;
                  Pr_Log_Error(p_Source,'ST-MAND-003','@'||l_Fld||'~@'||l_Blk||'~'||l_index );
               END IF;
            END LOOP;
         END IF;
      END IF;

      Dbg('Returning Success From Fn_Sys_Check_Mandatory ..');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_debug('**','In When Others of Fn_Sys_Check_Mandatory ..');
         Debug.Pr_debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := Null;
         RETURN FALSE;
   END Fn_Sys_Check_Mandatory;
   FUNCTION Fn_Sys_Basic_Vals        (p_Source            IN VARCHAR2,
      p_stdkevi4     IN  stpks_stdkevi4_Main.ty_stdkevi4,
      p_Err_code          IN OUT VARCHAR2,
      p_Err_params        IN OUT VARCHAR2)
   RETURN BOOLEAN   IS

      l_Count          NUMBER:= 0;
      l_Key            VARCHAR2(5000):= NULL;
      i                NUMBER := 1;
      l_Blk            VARCHAR2(100):= 0;
      l_Fld            VARCHAR2(100):= 0;
      l_Inv_Chr        VARCHAR2(5) :=NULL;
   BEGIN

      Dbg('In Fn_Sys_Basic_Vals..');
      Dbg('Duplicate Records Check For :v_detail_stdkevi4..');
      l_Count      := p_stdkevi4.v_detail_stdkevi4.COUNT;
      IF l_Count > 0 THEN
         FOR l_index  IN 1 .. l_count LOOP
            l_key := NULL;
            IF l_index < l_Count THEN
               FOR l_index1 IN l_index+1 .. l_Count LOOP
                  IF (NVL(p_stdkevi4.v_detail_stdkevi4(l_index).customer_no,'@')=  NVL(p_stdkevi4.v_detail_stdkevi4(l_index1).customer_no,'@')) AND (NVL(p_stdkevi4.v_detail_stdkevi4(l_index).customer_id,'@')=  NVL(p_stdkevi4.v_detail_stdkevi4(l_index1).customer_id,'@')) THEN
                     Dbg('Duplicare Record Found for :'||l_Key);
                     l_key := Cspks_Req_Utils.Fn_Get_Item_Desc(p_source,g_ui_name,'DETAIL_STDKEVI4.CUSTOMER_NO')||'-'||
                     p_stdkevi4.v_detail_stdkevi4(l_index).customer_no||':'||
                     Cspks_Req_Utils.Fn_Get_Item_Desc(p_source,g_ui_name,'DETAIL_STDKEVI4.CUSTOMER_ID')||'-'||
                     p_stdkevi4.v_detail_stdkevi4(l_index).customer_id;
                     Pr_Log_Error(p_Source,'ST-VALS-009','@DETAIL_STDKEVI4~'||l_Key);
                  END IF;
               END LOOP;
            END IF;
         END LOOP;
      END IF;
      Dbg('Returning Success From Fn_Sys_Basic_Vals..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Sys_Basic_Vals..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Sys_Basic_Vals;

   FUNCTION Fn_Sys_Default_Vals        (p_Source            IN VARCHAR2,
      p_Wrk_stdkevi4     IN  OUT stpks_stdkevi4_Main.ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN   IS

      l_Count          NUMBER:= 0;
   BEGIN

      Dbg('In Fn_Sys_Default_Vals..');
      Dbg('Returning Success From Fn_Sys_Default_Vals..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Sys_Default_Vals..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Sys_Default_Vals;

   FUNCTION Fn_Sys_Merge_Amendables        (p_Source            IN VARCHAR2,
      p_Source_Operation  IN     VARCHAR2,
      p_stdkevi4     IN  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Prev_stdkevi4 IN stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Wrk_stdkevi4 IN OUT stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN   IS

      l_Count          NUMBER:= 0;
      l_Wrk_Count      NUMBER := 0 ;
      l_Deleted_Recs   NUMBER := 0;
      l_Modified_Flds  VARCHAR2(32000):= NULL;
      l_Key            VARCHAR2(5000):= NULL;
      l_Mod_Fld        VARCHAR2(100):= NULL;
      i                NUMBER := 1;
      l_Rec_Found      BOOLEAN := FALSE;
      l_Rec_Modified   BOOLEAN := FALSE;
      l_Rec_Sent       BOOLEAN := FALSE;
      l_Blk            VARCHAR2(100):= 0;
      l_Fld            VARCHAR2(100):= 0;
      l_Pk_Or_Full     VARCHAR2(5) :='FULL';
      l_Inv_Chr        VARCHAR2(5) :=NULL;
      l_Mod_No         NUMBER:= 0;
      l_Base_Data_From_Fc  VARCHAR2(1):= 'Y';
      l_Amendable_Nodes Cspks_Req_Global.Ty_Amend_Nodes;
      l_Amendable_Fields Cspks_Req_Global.Ty_Amend_Fields;
      N_v_detail_stdkevi4       stpks_stdkevi4_Main.Ty_Tb_v_detail_stdkevi4;

      FUNCTION Fn_Amendable(p_Item IN VARCHAR2) RETURN BOOLEAN IS
      BEGIN
         IF l_Amendable_Fields.EXISTS(p_Item) THEN
            RETURN TRUE;
         ELSE
            RETURN FALSE;
         END IF;
      END Fn_Amendable;
   BEGIN

      Dbg('In Fn_Sys_Merge_Amendables');

      Dbg('Calling Cspks_Req_Utils.Fn_Get_Amendable_Details..');
      IF NOT Cspks_Req_Utils.Fn_Get_Amendable_Details(p_source ,
         p_Source_Operation,
         l_Amendable_Nodes,
         l_Amendable_Fields,
         p_Err_Code,
         p_Err_Params) THEN
         Dbg('Failed in Cspks_Req_Utils.Fn_Get_Amendable_Details..');
         Pr_Log_Error(p_Source,p_Err_Code,p_Err_Params);
      END IF;

      l_Blk := 'MASTER_STDKEVI4';
      l_Rec_Modified := FALSE;
      l_Modified_Flds  := NULL;

      l_fld := 'MASTER_STDKEVI4.AMOUNT';
      IF Fn_Amendable('MASTER_STDKEVI4.AMOUNT') THEN
         p_Wrk_stdkevi4.v_master_stdkevi4.amount := p_stdkevi4.v_master_stdkevi4.amount;
      ELSE
         IF p_stdkevi4.v_master_stdkevi4.amount IS NOT NULL THEN
            IF NVL(p_Wrk_stdkevi4.v_master_stdkevi4.amount,-1) <>
               NVL(p_stdkevi4.v_master_stdkevi4.amount,-1)  THEN
               l_Modified_Flds := l_Modified_Flds ||'~'||l_Fld;
               l_Rec_Modified := TRUE;
            END IF;
         END IF;
      END IF;
      l_fld := 'MASTER_STDKEVI4.CCY';
      IF Fn_Amendable('MASTER_STDKEVI4.CCY') THEN
         p_Wrk_stdkevi4.v_master_stdkevi4.ccy := p_stdkevi4.v_master_stdkevi4.ccy;
      ELSE
         IF p_stdkevi4.v_master_stdkevi4.ccy IS NOT NULL THEN
            IF NVL(p_Wrk_stdkevi4.v_master_stdkevi4.ccy,'@') <>
               NVL(p_stdkevi4.v_master_stdkevi4.ccy,'@')  THEN
               l_Modified_Flds := l_Modified_Flds ||'~'||l_Fld;
               l_Rec_Modified := TRUE;
            END IF;
         END IF;
      END IF;
      l_fld := 'MASTER_STDKEVI4.CUSTOMER_ACCOUNT';
      IF Fn_Amendable('MASTER_STDKEVI4.CUSTOMER_ACCOUNT') THEN
         p_Wrk_stdkevi4.v_master_stdkevi4.customer_account := p_stdkevi4.v_master_stdkevi4.customer_account;
      ELSE
         IF p_stdkevi4.v_master_stdkevi4.customer_account IS NOT NULL THEN
            IF NVL(p_Wrk_stdkevi4.v_master_stdkevi4.customer_account,'@') <>
               NVL(p_stdkevi4.v_master_stdkevi4.customer_account,'@')  THEN
               l_Modified_Flds := l_Modified_Flds ||'~'||l_Fld;
               l_Rec_Modified := TRUE;
            END IF;
         END IF;
      END IF;
      l_fld := 'MASTER_STDKEVI4.CUSTOMER_NAME';
      IF Fn_Amendable('MASTER_STDKEVI4.CUSTOMER_NAME') THEN
         p_Wrk_stdkevi4.v_master_stdkevi4.customer_name := p_stdkevi4.v_master_stdkevi4.customer_name;
      ELSE
         IF p_stdkevi4.v_master_stdkevi4.customer_name IS NOT NULL THEN
            IF NVL(p_Wrk_stdkevi4.v_master_stdkevi4.customer_name,'@') <>
               NVL(p_stdkevi4.v_master_stdkevi4.customer_name,'@')  THEN
               l_Modified_Flds := l_Modified_Flds ||'~'||l_Fld;
               l_Rec_Modified := TRUE;
            END IF;
         END IF;
      END IF;
      l_fld := 'MASTER_STDKEVI4.C_DATE';
      IF Fn_Amendable('MASTER_STDKEVI4.C_DATE') THEN
         p_Wrk_stdkevi4.v_master_stdkevi4.c_date := p_stdkevi4.v_master_stdkevi4.c_date;
      ELSE
         IF p_stdkevi4.v_master_stdkevi4.c_date IS NOT NULL THEN
            IF NVL(p_Wrk_stdkevi4.v_master_stdkevi4.c_date,global.min_date) <>
               NVL(p_stdkevi4.v_master_stdkevi4.c_date,global.min_date)  THEN
               l_Modified_Flds := l_Modified_Flds ||'~'||l_Fld;
               l_Rec_Modified := TRUE;
            END IF;
         END IF;
      END IF;
      l_fld := 'MASTER_STDKEVI4.EMAIL';
      IF Fn_Amendable('MASTER_STDKEVI4.EMAIL') THEN
         p_Wrk_stdkevi4.v_master_stdkevi4.email := p_stdkevi4.v_master_stdkevi4.email;
      ELSE
         IF p_stdkevi4.v_master_stdkevi4.email IS NOT NULL THEN
            IF NVL(p_Wrk_stdkevi4.v_master_stdkevi4.email,'@') <>
               NVL(p_stdkevi4.v_master_stdkevi4.email,'@')  THEN
               l_Modified_Flds := l_Modified_Flds ||'~'||l_Fld;
               l_Rec_Modified := TRUE;
            END IF;
         END IF;
      END IF;
      l_fld := 'MASTER_STDKEVI4.PHONE_NUMBER';
      IF Fn_Amendable('MASTER_STDKEVI4.PHONE_NUMBER') THEN
         p_Wrk_stdkevi4.v_master_stdkevi4.phone_number := p_stdkevi4.v_master_stdkevi4.phone_number;
      ELSE
         IF p_stdkevi4.v_master_stdkevi4.phone_number IS NOT NULL THEN
            IF NVL(p_Wrk_stdkevi4.v_master_stdkevi4.phone_number,-1) <>
               NVL(p_stdkevi4.v_master_stdkevi4.phone_number,-1)  THEN
               l_Modified_Flds := l_Modified_Flds ||'~'||l_Fld;
               l_Rec_Modified := TRUE;
            END IF;
         END IF;
      END IF;
      l_fld := 'MASTER_STDKEVI4.PRIORITY';
      IF Fn_Amendable('MASTER_STDKEVI4.PRIORITY') THEN
         p_Wrk_stdkevi4.v_master_stdkevi4.priority := p_stdkevi4.v_master_stdkevi4.priority;
      ELSE
         IF p_stdkevi4.v_master_stdkevi4.priority IS NOT NULL THEN
            IF NVL(p_Wrk_stdkevi4.v_master_stdkevi4.priority,'@') <>
               NVL(p_stdkevi4.v_master_stdkevi4.priority,'@')  THEN
               l_Modified_Flds := l_Modified_Flds ||'~'||l_Fld;
               l_Rec_Modified := TRUE;
            END IF;
         END IF;
      END IF;

      l_Modified_Flds := LTRIM(l_Modified_Flds,'~');
      IF  l_Rec_Modified THEN
         IF l_Modified_Flds IS NOT NULL THEN
            i :=  1;
            l_Mod_Fld := Cspkes_Misc.fn_GetParam(l_modified_flds,i,'~');
            WHILE l_Mod_Fld <> 'EOPL' LOOP
               Pr_Log_Error(p_Source,'ST-AMND-002','@'||l_Mod_Fld||'~@'||l_Blk) ;
               i := i +1;
               l_Mod_Fld := Cspkes_Misc.fn_GetParam(l_Modified_Flds,i,'~');
            END LOOP;
         END IF;
      END IF;
      l_Blk := 'DETAIL_STDKEVI4';
      l_Count      := p_stdkevi4.v_detail_stdkevi4.COUNT;
      l_Wrk_Count  := p_Wrk_stdkevi4.v_detail_stdkevi4.COUNT;
      IF l_Count > 0 THEN
         FOR l_index IN 1..l_Count  LOOP
            l_Rec_Found := FALSE;
            l_Rec_Modified := FALSE;
            l_Modified_Flds := NULL;
            IF l_Wrk_Count > 0 THEN
               FOR l_index1 IN 1..l_Wrk_Count  LOOP
                  IF (NVL(p_stdkevi4.v_detail_stdkevi4(l_index).customer_id,'@')=  NVL(p_Wrk_stdkevi4.v_detail_stdkevi4(l_index1).customer_id,'@')) THEN
                     Dbg('Record Found..');
                     l_Rec_Found := TRUE;
                     l_fld := 'DETAIL_STDKEVI4.DETAIL_DESCRIPTION';
                     IF Fn_Amendable('DETAIL_STDKEVI4.DETAIL_DESCRIPTION') THEN
                        p_Wrk_stdkevi4.v_detail_stdkevi4(l_index1).detail_description := p_stdkevi4.v_detail_stdkevi4(l_index).detail_description;
                     ELSE
                        IF p_stdkevi4.v_detail_stdkevi4(l_index).detail_description IS NOT NULL THEN
                           IF NVL(p_Wrk_stdkevi4.v_detail_stdkevi4(l_index1).detail_description,'@') <>
                              NVL(p_stdkevi4.v_detail_stdkevi4(l_index).detail_description,'@')  THEN
                              l_Modified_flds := l_Modified_Flds ||'~'||l_Fld;
                              l_Rec_Modified  := TRUE;
                           END IF;
                        END IF;
                     END IF;
                     l_fld := 'DETAIL_STDKEVI4.DETAIL_USER';
                     IF Fn_Amendable('DETAIL_STDKEVI4.DETAIL_USER') THEN
                        p_Wrk_stdkevi4.v_detail_stdkevi4(l_index1).detail_user := p_stdkevi4.v_detail_stdkevi4(l_index).detail_user;
                     ELSE
                        IF p_stdkevi4.v_detail_stdkevi4(l_index).detail_user IS NOT NULL THEN
                           IF NVL(p_Wrk_stdkevi4.v_detail_stdkevi4(l_index1).detail_user,'@') <>
                              NVL(p_stdkevi4.v_detail_stdkevi4(l_index).detail_user,'@')  THEN
                              l_Modified_flds := l_Modified_Flds ||'~'||l_Fld;
                              l_Rec_Modified  := TRUE;
                           END IF;
                        END IF;
                     END IF;
                     l_fld := 'DETAIL_STDKEVI4.D_DATE';
                     IF Fn_Amendable('DETAIL_STDKEVI4.D_DATE') THEN
                        p_Wrk_stdkevi4.v_detail_stdkevi4(l_index1).d_date := p_stdkevi4.v_detail_stdkevi4(l_index).d_date;
                     ELSE
                        IF p_stdkevi4.v_detail_stdkevi4(l_index).d_date IS NOT NULL THEN
                           IF NVL(p_Wrk_stdkevi4.v_detail_stdkevi4(l_index1).d_date,global.min_date) <>
                              NVL(p_stdkevi4.v_detail_stdkevi4(l_index).d_date,global.min_date)  THEN
                              l_Modified_flds := l_Modified_Flds ||'~'||l_Fld;
                              l_Rec_Modified  := TRUE;
                           END IF;
                        END IF;
                     END IF;
                     l_fld := 'DETAIL_STDKEVI4.SUBJECT';
                     IF Fn_Amendable('DETAIL_STDKEVI4.SUBJECT') THEN
                        p_Wrk_stdkevi4.v_detail_stdkevi4(l_index1).subject := p_stdkevi4.v_detail_stdkevi4(l_index).subject;
                     ELSE
                        IF p_stdkevi4.v_detail_stdkevi4(l_index).subject IS NOT NULL THEN
                           IF NVL(p_Wrk_stdkevi4.v_detail_stdkevi4(l_index1).subject,'@') <>
                              NVL(p_stdkevi4.v_detail_stdkevi4(l_index).subject,'@')  THEN
                              l_Modified_flds := l_Modified_Flds ||'~'||l_Fld;
                              l_Rec_Modified  := TRUE;
                           END IF;
                        END IF;
                     END IF;

                     l_Modified_Flds := LTRIM(l_Modified_Flds,'~');
                     IF  l_Rec_modified THEN
                        IF l_Modified_Flds IS NOT NULL THEN
                           l_key := Cspks_Req_Utils.Fn_Get_Item_Desc(p_source,g_ui_name,'DETAIL_STDKEVI4.CUSTOMER_ID')||'-'||
                           p_stdkevi4.v_detail_stdkevi4(l_index).customer_id;
                           i :=  1;
                           l_Mod_Fld := Cspkes_Misc.Fn_GetParam(l_Modified_Flds,i,'~');
                           WHILE l_mod_fld <> 'EOPL' LOOP
                              Pr_Log_Error(p_Source,'ST-AMND-003','@'||l_Mod_Fld||'~@'||l_Blk||'~'||l_Key );
                              i := i +1;
                              l_Mod_Fld := Cspkes_Misc.Fn_GetParam(l_Modified_Flds,i,'~');
                           END LOOP;
                        END IF;
                     END IF;
                  END IF;
               END LOOP;
            END IF;
            IF NOT l_Rec_Found THEN
               p_Wrk_stdkevi4.v_detail_stdkevi4(p_Wrk_stdkevi4.v_detail_stdkevi4.COUNT +1 ) :=  p_stdkevi4.v_detail_stdkevi4(l_index);
               IF l_Amendable_Nodes.EXISTS('DETAIL_STDKEVI4') THEN
                  IF l_Amendable_Nodes('DETAIL_STDKEVI4').New_Allowed = 'N' THEN
                     Dbg('New Record Cannot Be Added..');
                     l_key := Cspks_Req_Utils.Fn_Get_Item_Desc(p_source,g_ui_name,'DETAIL_STDKEVI4.CUSTOMER_ID')||'-'||
                     p_stdkevi4.v_detail_stdkevi4(l_index).customer_id;
                     Pr_Log_Error(p_source,'ST-AMND-004',l_key||'~@'||l_blk);
                  END IF;
               ELSE
                  Dbg('New Record Cannot Be Added..');
                  l_key := Cspks_Req_Utils.Fn_Get_Item_Desc(p_source,g_ui_name,'DETAIL_STDKEVI4.CUSTOMER_ID')||'-'||
                  p_stdkevi4.v_detail_stdkevi4(l_index).customer_id;
                  Pr_Log_Error(p_Source,'ST-AMND-004',l_key||'~@'||l_blk);
               END IF;
            END IF;
         END LOOP;
      END IF;

      IF l_Amendable_Nodes.EXISTS('DETAIL_STDKEVI4') THEN
         IF l_Amendable_Nodes('DETAIL_STDKEVI4').All_Records = 'Y' THEN
            Dbg('Logic For Deleting Some Records From Work Record  if Not sent..');
            l_Wrk_Count := p_Wrk_stdkevi4.v_detail_stdkevi4.COUNT;
            l_Count     := p_stdkevi4.v_detail_stdkevi4.COUNT;
            IF l_Wrk_Count > 0 THEN
               FOR l_index1 IN 1..l_Wrk_count  LOOP
                  l_Rec_Found := FALSE;
                  IF l_Count > 0 THEN
                     FOR l_index IN 1..l_Count  LOOP
                        IF (NVL(p_Wrk_stdkevi4.v_detail_stdkevi4(l_index1).customer_id,'@')=  NVL(p_stdkevi4.v_detail_stdkevi4  (l_index).customer_id,'@')) THEN
                           Dbg('Record Found..');
                           l_Rec_Found := TRUE;
                           EXIT;
                        END IF;
                     END LOOP;
                  END IF;
                  IF l_Rec_Found THEN
                     Dbg('Adding  a Record...');
                     N_v_detail_stdkevi4(N_v_detail_stdkevi4.COUNT +1 ) :=  p_Wrk_stdkevi4.v_detail_stdkevi4(l_Index1);
                  ELSE
                     l_Deleted_Recs := l_Deleted_Recs +1;
                     IF l_Amendable_Nodes.EXISTS('DETAIL_STDKEVI4') THEN
                        IF l_Amendable_Nodes('DETAIL_STDKEVI4').Delete_Allowed = 'N' THEN
                           Dbg('Record Cannot Be Deleted..');
                           l_key := Cspks_Req_Utils.Fn_Get_Item_Desc(p_source,g_ui_name,'DETAIL_STDKEVI4.CUSTOMER_ID')||'-'||
                           p_Wrk_stdkevi4.v_detail_stdkevi4(l_index1).customer_id;
                           Pr_Log_Error(p_Source,'ST-AMND-006',l_Key||'~@'||l_Blk);
                        END IF;
                     ELSE
                        Dbg('Record Cannot Be Deleted..');
                        l_key := Cspks_Req_Utils.Fn_Get_Item_Desc(p_source,g_ui_name,'DETAIL_STDKEVI4.CUSTOMER_ID')||'-'||
                        p_Wrk_stdkevi4.v_detail_stdkevi4(l_index1).customer_id;
                        Pr_Log_Error(p_Source,'ST-AMND-006',l_Key||'~@'||l_Blk);
                     END IF;
                  END IF;
               END LOOP;
            END IF;
            p_Wrk_stdkevi4.v_detail_stdkevi4:= N_v_detail_stdkevi4;
         END IF;
      END IF;

      Dbg('Returning Success From Fn_Sys_Merge_Amendables..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Sys_Merge_Amendables..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Sys_Merge_Amendables;

   FUNCTION Fn_Sys_Check_Mandatory_Nodes  (p_Source            IN VARCHAR2,
      p_Wrk_stdkevi4 IN  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN   IS

      l_Count          NUMBER:= 0;
      l_Base_Data_From_Fc  VARCHAR2(1):= 'Y';
      l_Blk            VARCHAR2(100);
      l_Fld            VARCHAR2(100);
   BEGIN

      dbg('In Fn_Gen_Sys_Node_Mand_Checks..');
      Dbg('Returning Success From Fn_Sys_Check_Mandatory_Nodes..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Sys_Check_Mandatory_Nodes..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Sys_Check_Mandatory_Nodes;

   FUNCTION Fn_Sys_Lov_Vals        (p_Source            IN VARCHAR2,
      p_Wrk_stdkevi4     IN  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN   IS

      l_Count          NUMBER:= 0;
      l_Key            VARCHAR2(5000):= NULL;
      i                NUMBER := 1;
      l_Lov_Count      NUMBER := 0;
      l_Blk            VARCHAR2(100):= 0;
      l_Fld            VARCHAR2(100):= 0;
      l_Inv_Chr        VARCHAR2(5) :=NULL;
      l_Dsn_Rec_Cnt_1 NUMBER := 0;
      l_Bnd_Cntr_1    NUMBER  := 0;
      l_Dsn_Rec_Cnt_2 NUMBER := 0;
      l_Bnd_Cntr_2    NUMBER  := 0;
   BEGIN

      Dbg('In Fn_Sys_Lov_Vals');
      l_Blk := 'MASTER_STDKEVI4';
      Dbg('Returning Success From Fn_Sys_Lov_Vals..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Sys_Lov_Vals..');
         Debug.Pr_debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Sys_Lov_Vals;

   FUNCTION Fn_Sys_Default_And_Validate        (p_Source            IN VARCHAR2,
      p_Source_Operation  IN     VARCHAR2,
      p_Function_id       IN     VARCHAR2,
      p_Action_Code       IN     VARCHAR2,
      p_stdkevi4     IN  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Prev_stdkevi4 IN OUT  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Wrk_stdkevi4 IN OUT  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN   IS
      l_Base_Data_From_Fc  VARCHAR2(1):= 'Y';
      l_Prev_Key_Tags       VARCHAR2(32767);
      l_Prev_Key_Vals       VARCHAR2(32767);
      l_Key  VARCHAR2(32767);
      l_Fld  VARCHAR2(32767);


   BEGIN

      Dbg('In Fn_Sys_Default_and_Validate..');

      IF p_Source <> 'FLEXCUBE'  THEN
         BEGIN
            SELECT Base_Data_From_Fc
            INTO   l_Base_Data_From_Fc
            FROM   Cotms_Source
            WHERE  Source_Code = p_Source;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               Dbg('Failed in Selecting Source '||p_Source);
               Dbg(SQLERRM);
               p_Err_Code    := 'ST-VALS-002';
               p_Err_Params  := p_Source;
               RETURN FALSE;
         END;
      END IF;
      l_key := Cspks_Req_Utils.Fn_Get_Item_Desc(p_source,g_ui_name,'MASTER_STDKEVI4.CUSTOMER_NO')||'-'||
      p_stdkevi4.v_master_stdkevi4.customer_no;
      l_Prev_Key_Tags := 'CUSTOMER_NO~';
      l_Prev_Key_Vals := p_prev_stdkevi4.v_master_stdkevi4.customer_no||'~';
      Dbg('Calling Cspks_Req_Utils.Fn_Maint_Basic_Validations..');
      IF NOT Cspks_Req_Utils.Fn_Maint_Basic_Validations (p_source,
         p_Source_Operation,
         p_Function_Id,
         p_Action_Code,
         p_Prev_stdkevi4.v_master_stdkevi4.Mod_No,
         p_stdkevi4.v_master_stdkevi4.Mod_No,
         p_Prev_stdkevi4.v_master_stdkevi4.Auth_Stat,
         p_Prev_stdkevi4.v_master_stdkevi4.Record_Stat,
         p_Prev_stdkevi4.v_master_stdkevi4.Once_Auth,
         l_Prev_Key_Tags,
         l_Prev_Key_Vals,
         g_Key_Id,
         l_Key,
         p_Err_Code,
         p_Err_Params) THEN
         Dbg('Failed in Cspks_Req_Utils.Fn_Maint_Basic_Validations..');
         RETURN FALSE;
      END IF;
      IF ( p_Action_Code IN (Cspks_Req_Global.p_Close,Cspks_Req_Global.p_Reopen,Cspks_Req_Global.p_Delete,Cspks_Req_Global.p_Version_Delete,Cspks_Req_Global.p_Query) OR
            ( p_Action_Code = Cspks_Req_Global.p_Modify AND NVL(p_Prev_stdkevi4.v_master_stdkevi4.Once_Auth,'N') = 'Y')) THEN
         p_Wrk_stdkevi4 := p_Prev_stdkevi4;
         p_wrk_stdkevi4.v_master_stdkevi4.Mod_No := p_stdkevi4.v_master_stdkevi4.Mod_No;
         p_Wrk_stdkevi4.Addl_Info := p_stdkevi4.Addl_Info ;
      ELSE
         p_Wrk_stdkevi4 := p_stdkevi4;
      END IF;
      IF p_Action_Code = Cspks_Req_Global.p_Auth THEN
         IF p_Wrk_stdkevi4.v_master_stdkevi4.Mod_No IS NULL THEN
            p_Wrk_stdkevi4.v_master_stdkevi4.Mod_No           := p_prev_stdkevi4.v_master_stdkevi4.Mod_No;
         END IF;
         p_Wrk_stdkevi4.v_master_stdkevi4.Checker_dt_stamp   := fn_mntstamp;
         p_Wrk_stdkevi4.v_master_stdkevi4.Checker_id         := Global.user_id;
      ELSIF p_Action_Code IN (Cspks_Req_Global.p_New,Cspks_Req_Global.p_Modify,Cspks_Req_Global.p_Close,Cspks_Req_Global.p_Reopen) THEN
         p_Wrk_stdkevi4.v_master_stdkevi4.Auth_Stat        := 'U';
         IF NOT Cspks_Req_Global.Fn_UnTanking THEN
            p_Wrk_stdkevi4.v_master_stdkevi4.Maker_Id         := Global.User_Id;
            p_Wrk_stdkevi4.v_master_stdkevi4.Maker_Dt_Stamp   := Fn_Mntstamp;
         ELSE
            p_Wrk_stdkevi4.v_master_stdkevi4.Maker_Id         := NVL(p_stdkevi4.v_master_stdkevi4.Maker_Id,Global.User_Id);
            p_Wrk_stdkevi4.v_master_stdkevi4.Maker_Dt_Stamp   := NVL(p_stdkevi4.v_master_stdkevi4.Maker_Dt_Stamp,Fn_Mntstamp);
         END IF;

         IF p_Action_Code = Cspks_Req_Global.p_New THEN
            IF NOT Cspks_Req_Global.Fn_UnTanking THEN
               p_Wrk_stdkevi4.v_master_stdkevi4.Mod_No           := 1;
            ELSE
               p_Wrk_stdkevi4.v_master_stdkevi4.Mod_No := NVL(p_Wrk_stdkevi4.v_master_stdkevi4.Mod_No,1);
            END IF;
            p_Wrk_stdkevi4.v_master_stdkevi4.Record_Stat      := 'O';
            p_Wrk_stdkevi4.v_master_stdkevi4.Once_Auth        := 'N';
         ELSE
            IF NOT Cspks_Req_Global.Fn_UnTanking THEN
               p_wrk_stdkevi4.v_master_stdkevi4.Mod_No           := NVL(p_prev_stdkevi4.v_master_stdkevi4.Mod_No,0)+1;
            ELSE
               p_Wrk_stdkevi4.v_master_stdkevi4.Mod_No           := NVL(p_stdkevi4.v_master_stdkevi4.Mod_No,1);
            END IF;
            p_Wrk_stdkevi4.v_master_stdkevi4.Once_Auth           := NVL(p_Prev_stdkevi4.v_master_stdkevi4.Once_Auth,'N');
            p_wrk_stdkevi4.v_master_stdkevi4.Record_Stat           := NVL(p_prev_stdkevi4.v_master_stdkevi4.Record_Stat,'O');
         END IF;
         IF p_Action_Code = Cspks_Req_Global.p_Close THEN
            p_Wrk_stdkevi4.v_master_stdkevi4.Record_Stat      := 'C';
         ELSIF p_Action_Code = Cspks_Req_Global.p_Reopen THEN
            p_Wrk_stdkevi4.v_master_stdkevi4.Record_Stat      := 'O';
         END IF;
         p_Wrk_stdkevi4.v_master_stdkevi4.Checker_id         := Null;
         p_Wrk_stdkevi4.v_master_stdkevi4.Checker_Dt_Stamp         := Null;
      ELSIF p_Action_Code IN ( Cspks_Req_Global.p_Delete,Cspks_Req_Global.p_Version_Delete) THEN
         IF p_Wrk_stdkevi4.v_master_stdkevi4.Mod_No IS NULL THEN
            p_Wrk_stdkevi4.v_master_stdkevi4.Mod_No           := p_Prev_stdkevi4.v_master_stdkevi4.Mod_No;
         END IF;
      END IF;
      IF p_Action_Code in  (Cspks_Req_Global.p_New,Cspks_Req_Global.p_Modify) THEN
         Dbg('Calling .Fn_Sys_Basic_Vals..');
         IF NOT Fn_Sys_Basic_Vals(p_Source,
            p_stdkevi4,
            p_Err_Code,
            p_Err_Params)  THEN
            Dbg('Failed in .Fn_Sys_Basic_Vals..');
            RETURN FALSE;
         END IF;

         IF p_Action_Code = Cspks_Req_Global.p_New OR  ( p_Action_Code = Cspks_Req_Global.p_Modify AND p_Prev_stdkevi4.v_master_stdkevi4.Once_Auth = 'N') THEN
            Dbg('Calling .Fn_Sys_Default_Vals..');
            IF NOT Fn_Sys_Default_Vals(p_Source,
               p_Wrk_stdkevi4,
               p_Err_Code,
               p_Err_Params)  THEN
               Dbg('Failed in .Fn_Sys_Default_Vals..');
               RETURN FALSE;
            END IF;

         END IF;
         IF p_Action_Code = Cspks_Req_Global.p_Modify AND p_Prev_stdkevi4.v_master_stdkevi4.Once_Auth = 'Y'THEN
            Dbg('Calling Fn_Sys_Merge_Amendables..');
            IF NOT Fn_Sys_Merge_Amendables(p_Source,
               p_Source_Operation,
               p_stdkevi4,
               p_Prev_stdkevi4,
               p_Wrk_stdkevi4,
               p_Err_Code,
               p_Err_Params)  THEN
               Dbg('Failed in .Fn_Sys_Merge_Amendables..');
               RETURN FALSE;
            END IF;
         END IF;

         Dbg('Calling .Fn_Sys_Check_Mandatory_Nodes..');
         IF NOT Fn_Sys_Check_Mandatory_Nodes(p_source,
            p_Wrk_stdkevi4,
            p_Err_Code,
            p_Err_Params)  THEN
            Dbg('Failed in .Fn_Sys_Check_Mandatory_Nodes..');
            RETURN FALSE;
         END IF;

         Dbg('Calling  .Fn_Sys_Lov_Vals..');
         IF NOT Fn_Sys_Lov_Vals(p_source,
            p_Wrk_stdkevi4,
            p_Err_Code,
            p_Err_Params)  THEN
            Dbg('Failed in .Fn_Sys_Lov_Vals..');
            RETURN FALSE;
         END IF;

      END IF;
      Dbg('Returning Success  From Fn_Sys_Default_And_Validate..');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Main.Fn_Sys_Default_And_Validate ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Sys_Default_And_Validate;
   FUNCTION Fn_Sys_Query_Desc_Fields  ( p_Source    IN  VARCHAR2,
                              p_Source_operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Wrk_stdkevi4  IN   OUT stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN IS
      l_Key            VARCHAR2(5000):= NULL;
      l_Count          NUMBER := 0;
      l_Key_Tags       VARCHAR2(32767);
      l_Key_Vals       VARCHAR2(32767);
      l_Rec_Exists     BOOLEAN := TRUE;
      l_Dsn_Rec_Cnt_2 NUMBER := 0;
      l_Bnd_Cntr_2    NUMBER := 0;
   BEGIN
      Dbg('In Fn_Sys_Query_Desc_Fields..');
      Dbg('Returning Success From Fn_Sys_Query_Desc_Fields..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Sys_Query_Desc_Fields ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Sys_Query_Desc_Fields;
   FUNCTION Fn_Sys_Query  ( p_Source    IN  VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Full_Data     IN  VARCHAR2 DEFAULT 'Y',
      p_With_Lock     IN  VARCHAR2 DEFAULT 'N',
      p_QryData_Reqd       IN  VARCHAR2,
      p_stdkevi4         IN  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Wrk_stdkevi4  IN   OUT stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN IS
      l_Key            VARCHAR2(5000):= NULL;
      l_Count          NUMBER := 0;
      l_Wrk_Count          NUMBER := 0;
      l_Key_Tags       VARCHAR2(32767);
      l_Key_Vals       VARCHAR2(32767);
      l_Rec_Exists        BOOLEAN := TRUE;
      RECORD_LOCKED    EXCEPTION;
      PRAGMA EXCEPTION_INIT( RECORD_LOCKED, -54 );
      l_Dsn_Rec_Cnt_1 NUMBER := 0;
      l_Bnd_Cntr_1    NUMBER := 0;
      l_Dsn_Rec_Cnt_2 NUMBER := 0;
      l_Bnd_Cntr_2    NUMBER := 0;
      Cursor c_v_detail_stdkevi4 IS
      SELECT *
      FROM   DETAIL_STDKEVI4
      WHERE customer_no = p_wrk_stdkevi4.v_master_stdkevi4.customer_no
      ;
   BEGIN
      Dbg('In Fn_Sys_Query..');
      IF p_QryData_Reqd = 'Q' THEN
         Dbg('Calling  Fn_Sys_Query_Desc_Fields..');
         IF NOT Fn_Sys_Query_Desc_Fields (p_Source,
            p_Source_Operation,
            p_Function_Id,
            p_Action_Code,
            p_Wrk_stdkevi4,
            p_Err_Code  ,
            p_Err_Params ) THEN
            Dbg('Failed in Fn_Sys_Query_Desc_Fields..');
            RETURN FALSE;
         END IF;
      ELSE
         l_key := Cspks_Req_Utils.Fn_Get_Item_Desc(p_source,g_ui_name,'MASTER_STDKEVI4.CUSTOMER_NO')||'-'||
         p_stdkevi4.v_master_stdkevi4.customer_no;
         Dbg('Get The Master Record...');
         IF NVL(p_With_Lock,'N') = 'Y' THEN
            BEGIN
               SELECT *
               INTO   p_wrk_stdkevi4.v_master_stdkevi4
               FROM  MASTER_STDKEVI4
               WHERE customer_no = p_stdkevi4.v_master_stdkevi4.customer_no
                FOR UPDATE NOWAIT;
            EXCEPTION
               WHEN RECORD_LOCKED THEN
                  Dbg('Failed to Obtain the Lock..');
                  Pr_Log_Error(p_Source,'ST-LOCK-001',NULL);
                  RETURN FALSE;
               WHEN No_Data_Found THEN
                  Dbg('Failed in Selecting The Master Recotrd..');
                  Dbg('Record Does not Exist..');
                  l_Rec_Exists := FALSE;
            END;

         ELSE
            BEGIN
               SELECT *
               INTO   p_Wrk_stdkevi4.v_master_stdkevi4
               FROM  MASTER_STDKEVI4
               WHERE customer_no = p_stdkevi4.v_master_stdkevi4.customer_no
               ;
            EXCEPTION
               WHEN no_data_found THEN
                  Dbg('Failed in Selecting The Master Recotrd..');
                  Dbg('Record Does not Exist..');
                  p_Err_Code    := 'ST-VALS-002';
                  p_Err_Params  := l_Key;
                  RETURN FALSE;
            END;

         END IF;
         IF p_Full_Data = 'Y' AND l_Rec_Exists THEN
            Dbg('Get the Record For :MASTER_STDKEVI4');
            BEGIN
               SELECT *
               INTO p_Wrk_stdkevi4.v_master_stdkevi4
               FROM   MASTER_STDKEVI4
               WHERE customer_no = p_wrk_stdkevi4.v_master_stdkevi4.customer_no
               ;
            EXCEPTION
               WHEN OTHERS THEN
                  Dbg(SQLERRM);
                  Dbg('Failed in Selecting The Record For :MASTER_STDKEVI4');
            END;
            Dbg('Get the Record For :DETAIL_STDKEVI4');
            OPEN c_v_detail_stdkevi4;
            LOOP
               FETCH c_v_detail_stdkevi4
               BULK COLLECT INTO p_Wrk_stdkevi4.v_detail_stdkevi4;
                EXIT WHEN c_v_detail_stdkevi4%NOTFOUND;
            END LOOP;
            CLOSE c_v_detail_stdkevi4;

         END IF;
         IF p_QryData_Reqd = 'Y' THEN
            Dbg('Calling  Fn_Sys_Query_Desc_Fields..');
            IF NOT Fn_Sys_Query_Desc_Fields (p_Source,
               p_Source_Operation,
               p_Function_Id,
               p_Action_Code,
               p_Wrk_stdkevi4,
               p_Err_Code  ,
               p_Err_Params ) THEN
               Dbg('Failed in Fn_Sys_Query_Desc_Fields..');
               RETURN FALSE;
            END IF;
         END IF;

      END IF;
      Dbg('Returning Success From Fn_Sys_Query..');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Sys_Query ..');
         Debug.Pr_Debug('**',SQLERRM);
         IF  c_v_detail_stdkevi4%ISOPEN THEN
            CLOSE c_v_detail_stdkevi4;
         END IF;
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Sys_Query;
   FUNCTION Fn_Sys_Upload_Db         (p_Source            IN VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_stdkevi4     IN  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Prev_stdkevi4     IN  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Wrk_stdkevi4      IN OUT  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN   IS
      l_Count             NUMBER:= 0;
      l_Ins_Count         NUMBER:= 0;
      l_Upd_Count         NUMBER:= 0;
      l_Del_Count         NUMBER:= 0;
      l_Wrk_Count         NUMBER:= 0;
      l_Prev_Count        NUMBER:= 0;
      l_Rec_Found         BOOLEAN:= FALSE;
      l_Row_Id            ROWID;
      l_Key               VARCHAR2(5000):= NULL;
      l_Auth_Stat         VARCHAR2(1) := 'A';
      l_Base_Data_From_Fc VARCHAR2(1):= 'Y';
      I_v_detail_stdkevi4       stpks_stdkevi4_Main.Ty_Tb_v_detail_stdkevi4;
      U_v_detail_stdkevi4       stpks_stdkevi4_Main.Ty_Tb_v_detail_stdkevi4;
      D_v_detail_stdkevi4       stpks_stdkevi4_Main.Ty_Tb_v_detail_stdkevi4;
   BEGIN
      Dbg('In Fn_Sys_Upload_Db..');
      IF p_Action_Code = Cspks_Req_Global.p_new THEN

         Dbg('Inserting Into MASTER_STDKEVI4..');
         BEGIN
            IF  p_wrk_stdkevi4.v_master_stdkevi4.customer_no IS NOT NULL THEN
               Dbg('Record Sent..');
               INSERT INTO  MASTER_STDKEVI4
               VALUES p_wrk_stdkevi4.v_master_stdkevi4;
            END IF;
         EXCEPTION
            WHEN OTHERS THEN
               Dbg('Failed In Insert intoMASTER_STDKEVI4..');
               Dbg(SQLERRM);
               p_Err_Code    := 'ST-UPLD-001';
               p_Err_Params  := '@MASTER_STDKEVI4';
               RETURN FALSE;
         END;

         Dbg('Inserting Into DETAIL_STDKEVI4..');
         BEGIN
            l_Count      := p_wrk_stdkevi4.v_detail_stdkevi4.COUNT;
            FORALL l_index IN  1..l_count
            INSERT INTO DETAIL_STDKEVI4
            VALUES p_wrk_stdkevi4.v_detail_stdkevi4(l_index);
         EXCEPTION
            WHEN OTHERS THEN
               Dbg('Failed In Insert intoDETAIL_STDKEVI4..');
               Dbg(SQLERRM);
               p_Err_Code    := 'ST-UPLD-001';
               p_Err_Params  := '@DETAIL_STDKEVI4';
               RETURN FALSE;
         END;
      ELSIF p_Action_Code = Cspks_Req_Global.p_modify THEN

         Dbg('Updating Single Record Node :  MASTER_STDKEVI4..');
         BEGIN
            UPDATE MASTER_STDKEVI4
            SET
            AMOUNT = p_Wrk_stdkevi4.v_master_stdkevi4.AMOUNT,
            CCY = p_Wrk_stdkevi4.v_master_stdkevi4.CCY,
            CUSTOMER_ACCOUNT = p_Wrk_stdkevi4.v_master_stdkevi4.CUSTOMER_ACCOUNT,
            CUSTOMER_NAME = p_Wrk_stdkevi4.v_master_stdkevi4.CUSTOMER_NAME,
            C_DATE = p_Wrk_stdkevi4.v_master_stdkevi4.C_DATE,
            EMAIL = p_Wrk_stdkevi4.v_master_stdkevi4.EMAIL,
            PHONE_NUMBER = p_Wrk_stdkevi4.v_master_stdkevi4.PHONE_NUMBER,
            PRIORITY = p_Wrk_stdkevi4.v_master_stdkevi4.PRIORITY,
            MAKER_ID = p_Wrk_stdkevi4.v_master_stdkevi4.MAKER_ID,
            MAKER_DT_STAMP = p_Wrk_stdkevi4.v_master_stdkevi4.MAKER_DT_STAMP,
            CHECKER_ID = p_Wrk_stdkevi4.v_master_stdkevi4.CHECKER_ID,
            CHECKER_DT_STAMP = p_Wrk_stdkevi4.v_master_stdkevi4.CHECKER_DT_STAMP,
            MOD_NO = p_Wrk_stdkevi4.v_master_stdkevi4.MOD_NO,
            RECORD_STAT = p_Wrk_stdkevi4.v_master_stdkevi4.RECORD_STAT,
            AUTH_STAT = p_Wrk_stdkevi4.v_master_stdkevi4.AUTH_STAT,
            ONCE_AUTH = p_Wrk_stdkevi4.v_master_stdkevi4.ONCE_AUTH
WHERE customer_no = p_Wrk_stdkevi4.v_master_stdkevi4.customer_no
;
         EXCEPTION
            WHEN OTHERS THEN
               Dbg('Failed in Insert Into MASTER_STDKEVI4..');
               Dbg(SQLERRM);
               p_Err_Code    := 'ST-UPLD-001';
               p_Err_Params  := '@MASTER_STDKEVI4';
               RETURN FALSE;
         END;


         Dbg('Preapring Insert and Update Types for  DETAIL_STDKEVI4..');
         l_Wrk_Count  := p_Wrk_stdkevi4.v_detail_stdkevi4.COUNT;
         l_Prev_Count := p_Prev_stdkevi4.v_detail_stdkevi4.COUNT;
         IF l_Wrk_Count > 0 THEN
            FOR l_index IN 1 .. l_Wrk_Count LOOP
               l_Rec_Found    := FALSE;
               IF l_Prev_Count >  0 THEN
                  FOR l_index1 IN 1..l_Prev_Count  LOOP
                     IF (NVL(p_Wrk_stdkevi4.v_detail_stdkevi4(l_index).customer_id,'@')=  NVL(p_Prev_stdkevi4.v_detail_stdkevi4  (l_index1).customer_id,'@')) THEN
                        Dbg('Record Has Been Found.Update Case..');
                        l_rec_found := TRUE;
                        EXIT;
                     END IF;
                  END LOOP;
               END IF;
               IF l_rec_found THEN
                  Dbg('Record is Modified...');
                  U_v_detail_stdkevi4(U_v_detail_stdkevi4.COUNT +1 ) :=  p_Wrk_stdkevi4.v_detail_stdkevi4(l_index);
               ELSE
                  Dbg('Record is Added...');
                  I_v_detail_stdkevi4(I_v_detail_stdkevi4.COUNT +1 ) :=  p_Wrk_stdkevi4.v_detail_stdkevi4(l_index);
               END IF;
            END LOOP;
         END IF;

         Dbg('Preapring Delete Types for  DETAIL_STDKEVI4..');
         l_Wrk_Count  := p_wrk_stdkevi4.v_detail_stdkevi4.COUNT;
         l_Prev_Count := p_prev_stdkevi4.v_detail_stdkevi4.COUNT;
         IF l_Prev_Count > 0 THEN
            FOR l_index1 IN 1 .. l_Prev_Count LOOP
               l_Rec_Found    := FALSE;
               IF l_Wrk_Count >  0 THEN
                  FOR l_index IN 1..l_Wrk_Count  LOOP
                     IF (NVL(p_Wrk_stdkevi4.v_detail_stdkevi4(l_index).customer_id,'@')=  NVL(p_Prev_stdkevi4.v_detail_stdkevi4  (l_index1).customer_id,'@')) THEN
                        Dbg('Record Has Been Found.Update Case..');
                        l_Rec_Found := TRUE;
                        EXIT;
                     END IF;
                  END LOOP;
               END IF;
               IF NOT l_Rec_Found THEN
                  Dbg('Record is Deleted...');
                  D_v_detail_stdkevi4(D_v_detail_stdkevi4.COUNT +1 ) :=  p_Prev_stdkevi4.v_detail_stdkevi4(l_index1);
               END IF;
            END LOOP;
         END IF;
         l_Del_Count  := D_v_detail_stdkevi4.COUNT;
         Dbg('Records Deleted  :'||l_Del_Count);
         IF l_Del_Count > 0 THEN
            FOR l_index IN 1 .. l_del_count LOOP
               Dbg('Deleting Record...');
               DELETE DETAIL_STDKEVI4
               WHERE customer_no = D_v_detail_stdkevi4(l_index).customer_no
                AND customer_id = D_v_detail_stdkevi4(l_index).customer_id
               ;
            END LOOP;
         END IF;
         l_Ins_Count  := I_v_detail_stdkevi4.COUNT;
         Dbg('New Records Added  :'||l_ins_count);
         BEGIN
            l_Count      := I_v_detail_stdkevi4.COUNT;
            FORALL l_Index IN  1..l_count
            INSERT INTO DETAIL_STDKEVI4
            VALUES I_v_detail_stdkevi4(l_index);
         EXCEPTION
            WHEN OTHERS THEN
               Dbg('Failed in Insert IntoDETAIL_STDKEVI4..');
               Dbg(SQLERRM);
               p_Err_Code    := 'ST-UPLD-001';
               p_Err_Params  := '@DETAIL_STDKEVI4';
               RETURN FALSE;
         END;
         l_Upd_Count  := U_v_detail_stdkevi4.COUNT;
         Dbg('Records Modified  :'||l_Upd_Count);
         IF l_Upd_Count > 0 THEN
            FOR l_index IN 1 .. l_Upd_Count LOOP
               Dbg('Updating The  Record...');
               BEGIN
                  UPDATE DETAIL_STDKEVI4
                  SET
                  DETAIL_DESCRIPTION = U_v_detail_stdkevi4(l_index).DETAIL_DESCRIPTION,
                  DETAIL_USER = U_v_detail_stdkevi4(l_index).DETAIL_USER,
                  D_DATE = U_v_detail_stdkevi4(l_index).D_DATE,
                  SUBJECT = U_v_detail_stdkevi4(l_index).SUBJECT
WHERE customer_no = U_v_detail_stdkevi4(l_index).customer_no
 AND customer_id = U_v_detail_stdkevi4(l_index).customer_id
;
               EXCEPTION
                  WHEN OTHERS THEN
                     Dbg('Failed in Updating DETAIL_STDKEVI4..');
                     Dbg(SQLERRM);
                     p_Err_Code    := 'ST-UPLD-001';
                     p_Err_Params  := '@DETAIL_STDKEVI4';
                     RETURN FALSE;
               END;
            END LOOP;
         END IF;
      ELSIF p_Action_Code = Cspks_Req_Global.p_delete THEN
         Dbg('Action Code '||p_Action_Code);
         Dbg('Deleting The Data..');

         
         DELETE DETAIL_STDKEVI4
         WHERE customer_no = p_Wrk_stdkevi4.v_master_stdkevi4.customer_no
         ;

         DELETE MASTER_STDKEVI4 WHERE customer_no = p_Wrk_stdkevi4.v_master_stdkevi4.customer_no
         ;


      ELSIF p_Action_Code IN (Cspks_Req_Global.p_Auth,Cspks_Req_Global.p_Close,Cspks_Req_Global.p_Reopen ) THEN
         l_key := Cspks_Req_Utils.Fn_Get_Item_Desc(p_source,g_ui_name,'MASTER_STDKEVI4.CUSTOMER_NO')||'-'||
         p_Wrk_stdkevi4.v_master_stdkevi4.customer_no;
         BEGIN
            SELECT ROWID
            INTO   l_row_id
            FROM  MASTER_STDKEVI4
            WHERE customer_no = p_Wrk_stdkevi4.v_master_stdkevi4.customer_no
            ;
         EXCEPTION
            WHEN No_Data_Found THEN
               Dbg('Failed in Selecting The Previous Master Recotrd..');
               p_Err_Code    := 'ST-VALS-002';
               p_Err_Params  := l_key;
               RETURN FALSE;
         END;

         IF NOT Cspks_Req_Utils.Fn_Maint_Operations(p_Source,
            p_Source_Operation,
            p_Function_Id,
            p_Action_Code,
            'MASTER_STDKEVI4',
            l_Row_Id,
            p_Wrk_stdkevi4.v_master_stdkevi4.mod_no,
            p_Wrk_stdkevi4.v_master_stdkevi4.Maker_dt_Stamp,
            p_Wrk_stdkevi4.v_master_stdkevi4.Checker_dt_Stamp,
            g_Key_Id,
            l_Key,
            p_Err_Code,
            p_Err_params) THEN
            Dbg('Failed in Cspks_Req_Utils.Fn_Maint_Basic_Validations');
            RETURN FALSE;
         END IF;

      END IF;

      Dbg('Returning Success From Fn_Sys_Upload_Db');
      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Sys_Upload_Db ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_params  := NULL;
         RETURN FALSE;
   END Fn_Sys_Upload_Db;
   FUNCTION Fn_Build_Type (p_Source    IN     VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Addl_Info       IN Cspks_Req_Global.Ty_Addl_Info,
      p_stdkevi4       IN   OUT stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN IS

      l_Main_Function Smtb_Menu.Function_Id%TYPE := p_Function_Id;
      l_Child_Function Smtb_Menu.Function_Id%TYPE := p_Function_Id;

   BEGIN

      Dbg('In Fn_Build_Ws_Type..');

      IF Cspks_Req_Utils.Fn_Is_Req_Fc_Format(p_Source,p_Function_Id) THEN
         IF NOT Fn_Sys_Build_Fc_Type(p_Source,
            p_Source_Operation,
            p_Function_Id,
            p_Action_Code,
            p_Addl_Info ,
            p_STDKEVI4,
            p_Err_Code,
            p_Err_Params)  THEN
            Dbg('Failed in Fn_Sys_Build_Fc_Type..');
            RETURN FALSE;
         END IF;
      ELSE
         IF NOT Fn_Sys_Build_Ws_Type(p_source,
            p_Source_Operation,
            p_Function_Id,
            p_Action_Code,
            p_Addl_Info ,
            p_STDKEVI4,
            p_Err_Code,
            p_Err_Params)  THEN
            Dbg('Failed in Fn_Sys_Build_Ws_Type..');
            RETURN FALSE;
         END IF;
      END IF;
      Pr_Skip_Handler('POSTTYPE');
      IF NOT stpks_stdkevi4_Main.Fn_Skip_custom  THEN
         IF NOT stpks_stdkevi4_Custom.Fn_Post_Build_Type_Structure(p_Source,
            p_Source_Operation,
            p_Function_Id,
            p_Action_Code,
            l_Child_Function,
            p_Addl_Info ,
            p_STDKEVI4,
            p_Err_Code,
            p_Err_Params)  THEN
            Dbg('Failed in stpks_stdkevi4_Custom.Fn_Post_Build_Type_Structure..');
            RETURN FALSE;
         END IF;
      END IF;
      Dbg('Returning Success From Fn_Build_Type..');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Main.Fn_Build_Type ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Build_Type;
   FUNCTION Fn_Build_Ts_List (p_source    IN     VARCHAR2,
                              p_source_operation  IN     VARCHAR2,
                              p_Function_id       IN     VARCHAR2,
                              p_action_code       IN     VARCHAR2,
      p_exchange_pattern   IN  VARCHAR2,
      p_stdkevi4          IN stpks_stdkevi4_Main.ty_stdkevi4,
      p_err_code        IN OUT VARCHAR2,
      p_err_params      IN OUT VARCHAR2)
   RETURN BOOLEAN   IS

      l_Main_Function smtb_menu.function_id%TYPE := p_Function_id;

   BEGIN

      dbg('In Fn_Build_Ts_List..');

      IF Cspks_Req_Utils.Fn_Is_Res_Fc_Format(p_source,p_Function_id) THEN
         IF NOT  Fn_Sys_Build_Fc_Ts(p_Source,
            p_source_operation,
            p_Function_id,
            p_action_code,
            p_stdkevi4,
            p_err_code,
            p_err_params)  THEN
            dbg('Failed in Fn_Sys_Build_Fc_Ts');
            RETURN FALSE;
         END IF;
      ELSE
         IF NOT  Fn_Sys_Build_Ws_Ts(p_Source,
            p_source_operation,
            p_Function_id,
            p_action_code,
            p_exchange_pattern,
            p_stdkevi4,
            p_err_code,
            p_err_params)  THEN
            dbg('Failed in Fn_Sys_Build_Ws_Ts');
            RETURN FALSE;
         END IF;
      END IF;

      dbg('Returning from Fn_Build_Ts_List');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         debug.pr_debug('**','In when others of stpks_stdkevi4_Main.Fn_Build_Ts_List ..');
         debug.pr_debug('**',SQLERRM);
         p_err_code    := 'ST-OTHR-001';
         p_err_params  := NULL;
         RETURN FALSE;
   END Fn_Build_Ts_List;
   FUNCTION Fn_Get_Key_Information (p_Source    IN  VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_stdkevi4       IN  OUT stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN   IS
      l_Key_Cols        VARCHAR2(32767);
      l_Key_Vals        VARCHAR2(32767);
      l_Func_Type       VARCHAR2(32767);
   BEGIN

      Dbg('In Fn_Get_Key_Information..');
      l_Key_Cols := 'CUSTOMER_NO~';
      l_Key_Vals := p_stdkevi4.v_master_stdkevi4.customer_no||'~';
      Dbg('Calling Cspks_Req_Utils.Fn_Get_Key_Information..');
      IF NOT Cspks_Req_Utils.Fn_Get_Key_Information(p_Source,
         p_Source_Operation,
         p_Function_Id,
         p_Action_Code ,
         'FCCMAINTENANCE',
         'MASTER_STDKEVI4',
         'BLK_MASTER',
         'Master',
         l_Key_Cols,
         l_Key_Vals,
         p_stdkevi4.Addl_Info,
         p_Err_Code,
         p_Err_Params) THEN
         Dbg('Failed in  Cspks_Req_Utils.Fn_Get_Key_Information..');
         RETURN FALSE;
      END IF;
      IF p_stdkevi4.Addl_Info.EXISTS('RECORD_KEY') THEN
         G_Req_Key :=  p_stdkevi4.Addl_Info('RECORD_KEY');
      END IF;
      IF p_stdkevi4.Addl_Info.EXISTS('KEY_ID') THEN
         G_Key_Id :=  p_stdkevi4.Addl_Info('KEY_ID');
      END IF;
      p_stdkevi4.Addl_Info('SENT_MOD_NO') :=p_stdkevi4.v_master_stdkevi4.Mod_No;
      Dbg('Returning Succsess From Fn_Get_Key_Information..');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Main.Fn_Get_Key_Information..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Get_Key_Information;
   FUNCTION Fn_Check_Mandatory (p_Source    IN     VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Pk_Or_Full     IN  VARCHAR2 DEFAULT 'FULL',
      p_stdkevi4 IN OUT  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code       IN  OUT VARCHAR2,
      p_Err_Params     IN  OUT VARCHAR2)
     RETURN BOOLEAN IS

      l_Pk_Or_Full      VARCHAR2(10) :=  'FULL';
      l_Blk      VARCHAR2(100) ;
      l_Fld      VARCHAR2(100) ;
      l_Main_Function Smtb_Menu.Function_Id%TYPE := p_Function_Id;
      l_Source_Operation      VARCHAR2(100) := p_Source_Operation;

   BEGIN

      Dbg('In Fn_Check_Mandatory..');

      IF p_Pk_Or_Full = 'FULL' OR p_Action_Code = Cspks_Req_Global.p_New THEN
         l_Pk_Or_Full := 'FULL';
      ELSE
         l_Pk_Or_Full := p_Pk_Or_Full;
      END IF;
      Pr_Skip_Handler('PREMAND');
      IF NOT stpks_stdkevi4_Main.Fn_Skip_custom  THEN
         IF NOT stpks_stdkevi4_Custom.Fn_Pre_Check_Mandatory (p_Source,
            p_Source_Operation,
            p_Function_Id,
            p_Action_Code,
            p_function_Id  ,
            p_stdkevi4,
            p_Err_Code,
            p_Err_Params)  THEN
            Dbg('Failed in  stpks_stdkevi4_Custom.Fn_Pre_Check_Mandatory..');
            RETURN FALSE;
         END IF;
      END IF;

      IF NOT stpks_stdkevi4_Main.Fn_Skip_Sys THEN
         Dbg('Calling   Fn_Sys_Check_Mandatory..');
         IF NOT Fn_Sys_Check_Mandatory(p_Source,
            l_Pk_Or_Full,
            p_stdkevi4,
            p_Err_Code,
            p_Err_Params)  THEN
            Dbg('Failed in Fn_Sys_Check_Mandatory..');
            RETURN FALSE;
         END IF;
      END IF;

      Pr_Skip_Handler('POSTMAND');
      IF NOT stpks_stdkevi4_Main.Fn_Skip_custom  THEN
         IF NOT stpks_stdkevi4_Custom.Fn_Post_Check_Mandatory (p_Source,
            p_Source_Operation,
            p_Function_Id,
            p_Action_Code,
            p_function_Id  ,
            l_Pk_Or_Full,
            p_stdkevi4,
            p_Err_Code,
            p_Err_Params)  THEN
            Dbg('Failed in  stpks_stdkevi4_Custom.Fn_Post_Check_Mandatory..');
            RETURN FALSE;
         END IF;
      END IF;
      Dbg('Returning Success From Fn_Check_Mandatory..');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Main.Fn_Check_Mandatory ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Check_Mandatory;
   FUNCTION Fn_Query  ( p_Source    IN  VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Full_Data     IN  VARCHAR2 DEFAULT 'Y',
      p_With_Lock     IN  VARCHAR2 DEFAULT 'N',
      p_QryData_Reqd       IN  VARCHAR2,
      p_stdkevi4         IN  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Wrk_stdkevi4  IN   OUT  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN IS

      l_Key_Vals VARCHAR2(32767);
      l_Tanked_data_Found             BOOLEAN := FALSE;
      l_Bld_Type_From_Tanked_Data     BOOLEAN := FALSE;
      l_Mod_No                        NUMBER;
      l_Main_Function Smtb_Menu.Function_Id%TYPE := p_Function_Id;
      l_Source_Operation       VARCHAR2(100) := p_Source_Operation;
      l_Skip_custom      BOOLEAN := FALSE;

   BEGIN

      Dbg('In Fn_Query..');

      l_Mod_No := p_stdkevi4.v_master_stdkevi4.Mod_No;
      Dbg('Calling Cspks_Req_Utils.Fn_Get_From_Tanked.');
      IF NOT Cspks_Req_Utils.Fn_Get_Tanked_Data (p_Source,
         p_Source_Operation,
         p_Function_Id,
         p_Action_Code,
         g_Key_Id,
         l_Mod_No,
         NVL(p_With_Lock,'N'),
         l_Tanked_data_Found,
         l_Bld_Type_From_Tanked_Data,
         p_Err_Code,
         p_Err_Params) THEN
         Dbg('Failed in Cspks_Req_Utils.Fn_Get_From_Tanked.');
         Pr_Log_Error(p_Source,p_Err_Code,p_Err_Params);
      END IF;

      IF l_Tanked_data_Found THEN
         IF l_Bld_Type_From_Tanked_Data THEN
            IF NOT  Fn_Sys_Build_Fc_Type(p_Source,
               p_Source_Operation,
               p_Function_Id,
               p_Action_Code,
               p_stdkevi4.Addl_Info,
               p_Wrk_stdkevi4,
               p_Err_Code,
               p_Err_Params)  THEN
               Dbg('Failed in Fn_Sys_Build_Fc_Type..');
               l_Tanked_data_Found      := FALSE;
               Pr_Log_Error(p_Source,'ST-TANK-001',NULL);
            END IF;
            g_Curr_Stage := 'POSTTANKQRY' ;
            l_Skip_custom:= g_Skip_custom;
            stpks_stdkevi4_Main.Pr_Set_Skip_custom;
            Pr_Skip_Handler('POSTTANKQRY');
            Dbg('Calling Post Query Hooks After Query Of Tanked Data');
            IF NOT stpks_stdkevi4_Main.Fn_Skip_custom  THEN
               IF NOT stpks_stdkevi4_Custom.Fn_Post_Query (p_Source,
                  p_Source_operation,
                  p_Function_id,
                  p_Action_Code,
                  p_Function_Id  ,
                  p_Full_Data,
                  p_With_Lock,
                  p_Qrydata_Reqd,
                  p_stdkevi4,
                  p_Wrk_stdkevi4,
                  p_Err_Code,
                  p_Err_Params) THEN
                  Dbg('Failed in stpks_stdkevi4_Custom.Fn_Post_Query of Tanked Data');
                  RETURN FALSE;
               END IF;
            END IF;
            g_Skip_custom:= l_Skip_custom;
            g_Curr_Stage := NULL ;
         END IF ;
      ELSE
         Dbg('Query From Base Tables..');
         Pr_Skip_Handler('PREQRY');
         IF NOT stpks_stdkevi4_Main.Fn_Skip_custom  THEN
            IF NOT stpks_stdkevi4_Custom.Fn_Pre_Query (p_Source,
               p_Source_Operation,
               p_Function_Id,
               p_Action_Code,
               p_function_Id  ,
               p_Full_Data  ,
               p_With_Lock,
               p_QryData_Reqd,
               p_stdkevi4,
               p_Wrk_stdkevi4,
               p_Err_Code  ,
               p_Err_Params ) THEN
               Dbg('Failed in stpks_stdkevi4_Custom.Fn_Pre_Query..');
               RETURN FALSE;
            END IF;
         END IF;
         IF NOT stpks_stdkevi4_Main.Fn_Skip_Sys THEN
            IF NOT Fn_Sys_Query (p_Source,
               p_Source_Operation,
               p_Function_Id,
               p_Action_Code,
               p_Full_Data  ,
               p_With_Lock,
               p_QryData_Reqd,
               p_stdkevi4,
               p_Wrk_stdkevi4,
               p_Err_Code  ,
               p_Err_Params ) THEN
               Dbg('Failed in Fn_Sys_Query..');
               RETURN FALSE;
            END IF;
         END IF;
         Pr_Skip_Handler('POSTQRY');
         IF NOT stpks_stdkevi4_Main.Fn_Skip_custom  THEN
            IF NOT stpks_stdkevi4_Custom.Fn_Post_Query (p_Source,
               p_Source_Operation,
               p_Function_Id,
               p_Action_Code,
               p_function_Id  ,
               p_Full_Data  ,
               p_With_Lock,
               p_QryData_Reqd,
               p_stdkevi4,
               p_Wrk_stdkevi4,
               p_Err_Code  ,
               p_Err_Params ) THEN
               Dbg('Failed in stpks_stdkevi4_Custom.Fn_Post_Query..');
               RETURN FALSE;
            END IF;
         END IF;
      END IF;
      Dbg('Returning Success From Fn_Query..');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Query ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Query;
   FUNCTION Fn_Default_And_Validate        (p_Source            IN VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_stdkevi4     IN  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Prev_stdkevi4 IN OUT  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Wrk_stdkevi4 IN OUT  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN   IS
      l_Main_Function Smtb_Menu.Function_Id%TYPE := p_Function_Id;
      l_Check_Amendables  VARCHAR2(1) := 'N';
      l_Source_Operation       VARCHAR2(100) := p_Source_Operation;
      l_Full_data    VARCHAR2(1) := 'N';
      l_With_Lock    VARCHAR2(1) := 'Y';
      l_Qrydata_Reqd    VARCHAR2(1) := 'N';
      l_Pk_Or_Full      VARCHAR2(10) := 'FULL';


   BEGIN

      Dbg('In Fn_Default_And_Validate..');

      l_Full_data   := 'Y';
      Dbg('Calling  Fn_Query..');
      IF NOT Fn_Query(p_Source,
         p_Source_Operation,
         p_Function_Id,
         p_Action_Code,
         l_Full_data,
         l_With_Lock,
         l_Qrydata_Reqd,
         p_stdkevi4,
         p_Prev_stdkevi4,
         p_Err_Code,
         p_Err_Params) THEN
         Dbg('Failed in Fn_Query..');
         RETURN FALSE;
      END IF;
      Pr_Skip_Handler('PREDFLT');
      IF NOT stpks_stdkevi4_Main.Fn_Skip_custom  THEN
         IF NOT stpks_stdkevi4_Custom.Fn_Pre_Default_And_Validate (p_Source,
            p_Source_Operation,
            p_Function_Id,
            p_Action_Code,
            p_function_Id  ,
            p_stdkevi4,
            p_Prev_stdkevi4,
            p_Wrk_stdkevi4,
            p_Err_Code,
            p_Err_Params) THEN
            Dbg('Failed in stpks_stdkevi4_Custom.Fn_Pre_Default_And_Validate..');
            RETURN FALSE;
         END IF;
      END IF;
      IF NOT stpks_stdkevi4_Main.Fn_Skip_Sys THEN
         Dbg('Calling in Fn_Sys_Default_and_Validate..');
         IF NOT Fn_Sys_Default_and_Validate (p_Source,
            p_Source_Operation,
            p_Function_Id,
            p_Action_Code,
            p_stdkevi4,
            p_Prev_stdkevi4,
            p_Wrk_stdkevi4,
            p_Err_Code  ,
            p_Err_Params ) THEN
            Dbg('Failed in Fn_Sys_Default_and_Validate..');
            RETURN FALSE;
         END IF;
      END IF;
      Pr_Skip_Handler('POSTDFLT');
      IF NOT stpks_stdkevi4_Main.Fn_Skip_custom  THEN
         IF NOT stpks_stdkevi4_Custom.Fn_Post_Default_And_Validate (p_Source,
            p_Source_Operation,
            p_Function_Id,
            p_Action_Code,
            p_function_Id  ,
            p_stdkevi4,
            p_Prev_stdkevi4,
            p_Wrk_stdkevi4,
            p_Err_Code,
            p_Err_Params) THEN
            Dbg('Failed in stpks_stdkevi4_Custom.Fn_Post_Default_And_Validate..');
            RETURN FALSE;
         END IF;
      END IF;
      IF p_Action_Code = Cspks_Req_Global.p_Modify THEN
         Dbg('Calling  Fn_Check_Mandatory..');
         IF NOT Fn_Check_Mandatory(p_Source,
            p_Source_Operation,
            p_Function_Id,
            p_Action_Code,
            l_Pk_Or_Full,
            p_Wrk_stdkevi4,
            p_Err_Code,
            p_Err_Params) THEN
            Dbg('Failed in Fn_Check_Mandatory..');
            RETURN FALSE;
         END IF;
      END IF;
      Dbg('Returning Success From Fn_Default_And_Validate..');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Main.Fn_Default_And_Validate ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Default_And_Validate;
   FUNCTION Fn_Upload_Db  (p_Source            IN VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
      p_Post_Upl_Stat    IN     VARCHAR2,
      p_Multi_Trip_Id    IN  VARCHAR2,
      p_stdkevi4     IN  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Prev_stdkevi4     IN  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Wrk_stdkevi4      IN OUT  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN   IS
      l_Main_Function Smtb_Menu.Function_Id%TYPE := p_Function_id;
      l_Source_Operation       VARCHAR2(100) := p_Source_Operation;
      l_Row_Id            ROWID;
      l_Key  VARCHAR2(32767);
      l_Fld  VARCHAR2(32767);


   BEGIN

      Dbg('In Fn_Upload_Db..');

      Pr_Skip_Handler('PREUPLD');
      IF NOT stpks_stdkevi4_Main.Fn_Skip_custom  THEN
         IF NOT stpks_stdkevi4_Custom.Fn_Pre_Upload_Db (p_Source,
            p_Source_operation,
            p_Function_id,
            p_Action_Code,
            p_function_Id  ,
            p_Post_Upl_Stat,
            p_Multi_Trip_Id,
            p_stdkevi4,
            p_Prev_stdkevi4,
            p_Wrk_stdkevi4,
            p_Err_Code,
            p_Err_Params) THEN
            Dbg('Failed in stpks_stdkevi4_Custom.Fn_Pre_Upload_Db..');
            RETURN FALSE;
         END IF;
      END IF;
      IF NOT stpks_stdkevi4_Main.Fn_Skip_Sys THEN
         IF NOT Fn_Sys_Upload_Db (p_Source,
            p_Source_Operation,
            p_Function_Id,
            p_Action_Code,
            p_stdkevi4,
            p_Prev_stdkevi4,
            p_Wrk_stdkevi4,
            p_Err_Code,
            p_Err_Params) THEN
            Dbg('Failed in Fn_Pre_Upload_Db..');
            RETURN FALSE;
         END IF;
      END IF;

      Pr_Skip_Handler('POSTUPLD');
      IF NOT stpks_stdkevi4_Main.Fn_Skip_custom  THEN
         IF NOT stpks_stdkevi4_Custom.Fn_Post_Upload_Db (p_Source,
            p_Source_operation,
            p_Function_id,
            p_Action_Code,
            p_function_Id  ,
            p_Post_Upl_Stat,
            p_Multi_Trip_Id,
            p_stdkevi4,
            p_Prev_stdkevi4,
            p_Wrk_stdkevi4,
            p_Err_Code,
            p_Err_Params) THEN
            Dbg('Failed in stpks_stdkevi4_Custom.Fn_Post_Upload_Db..');
            RETURN FALSE;
         END IF;
      END IF;
      Dbg('Returning Success  From Fn_Upload_Db..');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of stpks_stdkevi4_Main.Fn_Upload_Db ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Upload_Db;
   FUNCTION Fn_Populate_Record_Master (p_Source            IN     VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
                              p_stdkevi4          IN  stpks_stdkevi4_Main.Ty_stdkevi4,
                              p_Record_Master     IN OUT Sttbs_Record_Master%ROWTYPE,
                              p_Err_Code          IN OUT VARCHAR2,
                              p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN IS

      l_Summary_Rec_Found BOOLEAN := TRUE;
   BEGIN

      Dbg('In Fn_Populate_Record_Master..');


      Dbg('Returning Success From Fn_Populate_Record_Master..');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others Of Fn_Populate_Record_Master ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := Null;
         RETURN FALSE;
   END Fn_Populate_Record_Master;

   FUNCTION Fn_Tank_Modification   (p_Source            IN     VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
                              p_Tanking_Status    IN OUT VARCHAR2,
                              p_Err_Code          IN OUT VARCHAR2,
                              p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN IS

   BEGIN

      Dbg('In Fn_Tank_Modification..');
      p_Tanking_Status := 'N';
      IF Cspks_Req_Utils.Fn_Tank_Modification(p_Source,
         p_Source_Operation,
         p_Function_Id,
         p_Action_Code,
         p_Err_Code,
         p_Err_Params) THEN
         Dbg('Rolling Back The Modification..');
         p_Tanking_Status := 'T';
         g_Tanking_Status := 'T';
         ROLLBACK TO Sp_Main_Stdkevi4;
      END IF;

      Dbg('Returning Success From Fn_Tank_Modification..');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Tank_Modification ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := Null;
         RETURN FALSE;
   END Fn_Tank_Modification;

   FUNCTION Fn_Maint_Log (p_Source            IN     VARCHAR2,
                              p_Source_Operation IN     VARCHAR2,
                              p_Function_Id      IN     VARCHAR2,
                              p_Action_Code      IN     VARCHAR2,
                              p_Multi_Trip_Id       IN     VARCHAR2,
                              p_Request_No          IN     VARCHAR2,
                              p_Record_Master     IN  Sttbs_Record_Master%ROWTYPE,
                              p_stdkevi4          IN  stpks_stdkevi4_Main.Ty_stdkevi4,
                              p_Prev_stdkevi4          IN  stpks_stdkevi4_Main.Ty_stdkevi4,
                              p_wrk_stdkevi4          IN  stpks_stdkevi4_Main.Ty_stdkevi4,
      p_Tanking_Status IN VARCHAR2,
                              p_Err_Code          IN OUT VARCHAR2,
                              p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN IS

      l_Main_Function VARCHAR2(50) := p_Function_id;
      l_Auth_Stat       VARCHAR2(32767):= NULL;
      l_Source_Operation       VARCHAR2(100) := p_Source_Operation;
      l_Key_Id         VARCHAR2(32767):= g_Key_Id;
      l_Mod_No          NUMBER := 1;
      l_Blk             VARCHAR2(32767):= NULL;
      l_Fld             VARCHAR2(32767):= NULL;
      l_Dbt             VARCHAR2(32767):= NULL;
      l_Dbc             VARCHAR2(32767):= NULL;
      l_Rec_Action      VARCHAR2(32767):= 'M';
      l_Dtl_Key          VARCHAR2(32767):= NULL;
      l_Prev_Count      NUMBER := 0;
      l_Wrk_Count      NUMBER := 0;
      l_Count          NUMBER := 0;
      l_Log_Count       NUMBER := 0;
      l_Fld_Count       NUMBER := 0;
      l_Matched_Rec     NUMBER := 0;
      l_Rec_Found       BOOLEAN:= FALSE;
      l_Prev_Found       BOOLEAN:= FALSE;
      l_Wrk_Found       BOOLEAN:= FALSE;
      l_Rec_Modified    BOOLEAN:= FALSE;
      l_Record_log      Sttbs_Record_Log%ROWTYPE;
      l_Field_log       Sttbs_Field_log%ROWTYPE;
      l_wrk_stdkevi4      stpks_stdkevi4_Main.Ty_stdkevi4;
      l_Skip_custom      BOOLEAN := FALSE;
      l_Tb_Field_Log    Cspks_Req_Global.Ty_Tb_Fld_Log;

      PROCEDURE Pr_Log_Change(p_Dbc     IN VARCHAR2,
                                 p_Action  IN VARCHAR2,
                                 p_Old_Val IN VARCHAR2,
                                 p_New_Val IN VARCHAR2) IS
      BEGIN
         IF NVL(p_Old_Val,'@') <> NVL(p_New_Val,'@') THEN
             l_Fld_Count := l_Fld_Count +1;
            l_Log_Count := NVL(l_Tb_Field_Log.COUNT,0) +1;
            l_Field_log.Detail_Key := l_Dtl_Key;
            l_Field_log.Block_Name := l_Blk;
            l_Field_log.Field_Name := p_Dbc;
            l_Field_log.Table_Name := l_Dbt;
            l_Field_log.Item_no := l_Fld_Count;
            l_Field_log.Record_Stat := p_Action;
            IF length(p_Old_Val)>2000 THEN
               l_Field_log.Old_Value := Substr(p_Old_Val,1,2000);
            ELSE
               l_Field_log.Old_Value := p_Old_Val;
            END IF;
            IF length(p_New_Val)>2000 THEN
               l_Field_log.New_Value := Substr(p_New_Val,1,2000);
            ELSE
               l_Field_log.New_Value := p_New_Val;
            END IF;
            l_Tb_Field_Log(l_Log_Count) := l_Field_log;
         END IF;
      END Pr_Log_Change;

   BEGIN

      Dbg('In Fn_Maint_Log');

      IF  p_Action_Code IN (Cspks_Req_Global.p_New,Cspks_Req_Global.p_Modify,Cspks_Req_Global.p_Close,Cspks_Req_Global.p_Reopen,Cspks_Req_Global.p_Auth,Cspks_Req_Global.p_Delete,Cspks_Req_Global.p_Version_Delete) THEN
         Dbg('Maintenance Log is Required ..');
         IF l_Key_Id IS NOT NULL THEN
            IF p_Action_Code IN( Cspks_Req_Global.p_auth,Cspks_Req_Global.p_Delete,Cspks_Req_Global.p_Version_Delete) THEN
               IF p_stdkevi4.v_master_stdkevi4.Mod_no IS NOT NULL THEN
                  l_Mod_No           := p_stdkevi4.v_master_stdkevi4.Mod_No;
               ELSE
                  l_Mod_No           := p_Wrk_stdkevi4.v_master_stdkevi4.Mod_No;
               END IF;
            ELSE
               l_mod_no           := p_wrk_stdkevi4.v_master_stdkevi4.mod_no;
            END IF;
              l_Auth_Stat := NVL(p_Wrk_stdkevi4.v_master_stdkevi4.Auth_Stat,'U') ;
            IF NOT Cspks_Req_Utils.Fn_Maint_Log(p_Source,
                p_Source_Operation  ,
                p_Function_Id ,
                p_Action_Code,
                p_Multi_Trip_Id ,
                p_Request_No ,
               'MASTER_STDKEVI4',
               l_Key_Id,
               l_Mod_No,
               l_Auth_Stat,
               p_Tanking_Status ,
               p_Record_Master ,
               p_Err_Code,
               p_Err_Params) THEN
               Dbg('Failed in   Cspks_Req_Utils.Fn_Maint_Log..');
               RETURN FALSE;
            END IF;
            IF Cspks_Req_Utils.Fn_Field_Log_Reqd(p_Function_Id,p_Action_Code) THEN
               l_Field_log.Key_id := l_Key_Id;
               l_Field_log.Mod_No := l_Mod_No;
               l_Field_log.Function_id := p_Function_Id;

               l_Dbt := 'MASTER_STDKEVI4';

               l_Blk := 'MASTER_STDKEVI4';
               l_Rec_Modified := FALSE;
               l_Prev_Found := FALSE;
               l_Wrk_Found := FALSE;

               IF p_Prev_stdkevi4.v_master_stdkevi4.customer_no IS NOT NULL THEN
                  Dbg('Record Has Been Sent..');
                  l_prev_found := TRUE;
               END IF;
               IF p_Wrk_stdkevi4.v_master_stdkevi4.customer_no IS NOT NULL THEN
                  Dbg('Record Has Been Sent..');
                  l_Wrk_Found := TRUE;
               END IF;
               IF l_Prev_Found   THEN
                  l_Dtl_key := '~MASTER_STDKEVI4~'||p_Prev_stdkevi4.v_master_stdkevi4.customer_no||'~';
               ELSIF l_Wrk_Found   THEN
                  l_Dtl_key := '~MASTER_STDKEVI4~'||p_Wrk_stdkevi4.v_master_stdkevi4.customer_no||'~';
               END IF;
               IF l_Wrk_Found  OR l_Prev_Found THEN
                  IF l_Wrk_Found  AND l_Prev_Found THEN
                     l_rec_action := 'M';
                  ELSIF l_wrk_found  AND ( NOT l_Prev_Found) THEN
                     l_Rec_Action := 'N';
                  ELSIF (NOT l_wrk_Found)  AND l_Prev_Found THEN
                     l_Rec_Action := 'D';
                  END IF;
                  Pr_Log_Change('AMOUNT',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.amount,p_Wrk_stdkevi4.v_master_stdkevi4.amount);
Pr_Log_Change('CCY',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.ccy,p_Wrk_stdkevi4.v_master_stdkevi4.ccy);
Pr_Log_Change('CUSTOMER_ACCOUNT',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.customer_account,p_Wrk_stdkevi4.v_master_stdkevi4.customer_account);
Pr_Log_Change('CUSTOMER_NAME',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.customer_name,p_Wrk_stdkevi4.v_master_stdkevi4.customer_name);
Pr_Log_Change('CUSTOMER_NO',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.customer_no,p_Wrk_stdkevi4.v_master_stdkevi4.customer_no);
Pr_Log_Change('C_DATE',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.c_date,p_Wrk_stdkevi4.v_master_stdkevi4.c_date);
Pr_Log_Change('EMAIL',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.email,p_Wrk_stdkevi4.v_master_stdkevi4.email);
Pr_Log_Change('PHONE_NUMBER',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.phone_number,p_Wrk_stdkevi4.v_master_stdkevi4.phone_number);
Pr_Log_Change('PRIORITY',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.priority,p_Wrk_stdkevi4.v_master_stdkevi4.priority);
Pr_Log_Change('MAKER_ID',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.maker_id,p_Wrk_stdkevi4.v_master_stdkevi4.maker_id);
Pr_Log_Change('MAKER_DT_STAMP',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.maker_dt_stamp,p_Wrk_stdkevi4.v_master_stdkevi4.maker_dt_stamp);
Pr_Log_Change('CHECKER_ID',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.checker_id,p_Wrk_stdkevi4.v_master_stdkevi4.checker_id);
Pr_Log_Change('CHECKER_DT_STAMP',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.checker_dt_stamp,p_Wrk_stdkevi4.v_master_stdkevi4.checker_dt_stamp);
Pr_Log_Change('MOD_NO',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.mod_no,p_Wrk_stdkevi4.v_master_stdkevi4.mod_no);
Pr_Log_Change('RECORD_STAT',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.record_stat,p_Wrk_stdkevi4.v_master_stdkevi4.record_stat);
Pr_Log_Change('AUTH_STAT',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.auth_stat,p_Wrk_stdkevi4.v_master_stdkevi4.auth_stat);
Pr_Log_Change('ONCE_AUTH',l_Rec_Action,p_Prev_stdkevi4.v_master_stdkevi4.once_auth,p_Wrk_stdkevi4.v_master_stdkevi4.once_auth);


                              END IF;


               l_Dbt := 'DETAIL_STDKEVI4';
               l_Blk := 'DETAIL_STDKEVI4';
               l_Wrk_Count  := p_Wrk_stdkevi4.v_detail_stdkevi4.COUNT;
               l_Prev_Count      := p_Prev_stdkevi4.v_detail_stdkevi4.COUNT;
               IF l_Wrk_count > 0 THEN
                  FOR l_Index IN 1..l_Wrk_count  LOOP
                     l_Dtl_key := '~DETAIL_STDKEVI4~'||p_wrk_stdkevi4.v_detail_stdkevi4(l_index).customer_no||'~'||p_wrk_stdkevi4.v_detail_stdkevi4(l_index).customer_id||'~';
                     l_Rec_Found := FALSE;
                     l_Rec_Modified := FALSE;
                     IF l_Prev_count > 0 THEN
                        FOR l_Index1 IN 1..l_Prev_count  LOOP
                           IF (NVL(p_Wrk_stdkevi4.v_detail_stdkevi4(l_Index).customer_id,'@')=  NVL(p_Prev_stdkevi4.v_detail_stdkevi4(l_Index1).customer_id,'@')) THEN
                              Dbg('Record Found..');
                              l_Rec_Found := TRUE;
                              l_Matched_Rec := l_Index1;
                              Pr_Log_Change('CUSTOMER_ID','M',p_Prev_stdkevi4.v_detail_stdkevi4(l_Index1).customer_id,p_Wrk_stdkevi4.v_detail_stdkevi4(l_Index).customer_id);
Pr_Log_Change('DETAIL_DESCRIPTION','M',p_Prev_stdkevi4.v_detail_stdkevi4(l_Index1).detail_description,p_Wrk_stdkevi4.v_detail_stdkevi4(l_Index).detail_description);
Pr_Log_Change('DETAIL_USER','M',p_Prev_stdkevi4.v_detail_stdkevi4(l_Index1).detail_user,p_Wrk_stdkevi4.v_detail_stdkevi4(l_Index).detail_user);
Pr_Log_Change('D_DATE','M',p_Prev_stdkevi4.v_detail_stdkevi4(l_Index1).d_date,p_Wrk_stdkevi4.v_detail_stdkevi4(l_Index).d_date);
Pr_Log_Change('SUBJECT','M',p_Prev_stdkevi4.v_detail_stdkevi4(l_Index1).subject,p_Wrk_stdkevi4.v_detail_stdkevi4(l_Index).subject);



                                                      END IF;
                        END LOOP;
                     END IF;
                     IF NOT l_rec_found THEN
                        Dbg('New Record Found..');
                        Pr_Log_Change('CUSTOMER_ID','N',NULL,p_wrk_stdkevi4.v_detail_stdkevi4(l_Index).customer_id);
Pr_Log_Change('DETAIL_DESCRIPTION','N',NULL,p_wrk_stdkevi4.v_detail_stdkevi4(l_Index).detail_description);
Pr_Log_Change('DETAIL_USER','N',NULL,p_wrk_stdkevi4.v_detail_stdkevi4(l_Index).detail_user);
Pr_Log_Change('D_DATE','N',NULL,p_wrk_stdkevi4.v_detail_stdkevi4(l_Index).d_date);
Pr_Log_Change('SUBJECT','N',NULL,p_wrk_stdkevi4.v_detail_stdkevi4(l_Index).subject);


                                          END IF;
                  END LOOP;
               END IF;
               l_Prev_count      := p_Prev_stdkevi4.v_detail_stdkevi4.COUNT;
               l_Wrk_Count  := p_Wrk_stdkevi4.v_detail_stdkevi4.COUNT;
               IF l_Prev_Count > 0 THEN
                  FOR l_Index IN 1..l_Prev_count  LOOP
                     l_Rec_Found := FALSE;
                     l_Rec_Modified := FALSE;
                     IF l_Wrk_Count > 0 THEN
                        FOR l_Index1 IN 1..l_Wrk_Count  LOOP
                           IF (NVL(p_Prev_stdkevi4.v_detail_stdkevi4(l_Index).customer_id,'@')=  NVL(p_Wrk_stdkevi4.v_detail_stdkevi4(l_Index1).customer_id,'@')) THEN
                              Dbg('Record Found..');
                              l_Rec_Found := TRUE;
                              EXIT;

                           END IF;
                        END LOOP;
                     END IF;
                     IF NOT l_Rec_Found THEN
                        Dbg('Record Deleted..');
                        l_Dtl_key := '~DETAIL_STDKEVI4~'||p_Prev_stdkevi4.v_detail_stdkevi4(l_Index).customer_no||'~'||p_Prev_stdkevi4.v_detail_stdkevi4(l_Index).customer_id||'~';
                        Pr_Log_Change('CUSTOMER_ID','D',p_Prev_stdkevi4.v_detail_stdkevi4(l_Index).customer_id,NULL);
Pr_Log_Change('DETAIL_DESCRIPTION','D',p_Prev_stdkevi4.v_detail_stdkevi4(l_Index).detail_description,NULL);
Pr_Log_Change('DETAIL_USER','D',p_Prev_stdkevi4.v_detail_stdkevi4(l_Index).detail_user,NULL);
Pr_Log_Change('D_DATE','D',p_Prev_stdkevi4.v_detail_stdkevi4(l_Index).d_date,NULL);
Pr_Log_Change('SUBJECT','D',p_Prev_stdkevi4.v_detail_stdkevi4(l_Index).subject,NULL);


                                          END IF;
                  END LOOP;
               END IF;

               l_Count      := l_Tb_Field_Log.COUNT;
               IF l_Count   > 0 THEN
                  Dbg('Inserting Into Field Log..');
                  BEGIN
                     FORALL l_Index IN  1..l_count
                     INSERT INTO STTBS_FIELD_LOG
                     VALUES l_Tb_Field_Log(l_index);
                  EXCEPTION
                     WHEN OTHERS THEN
                        Dbg('Failed in Insert into Field Log..');
                        Dbg(SQLERRM);
                        p_Err_Code    := 'ST-UPLD-001';
                        p_Err_Params  := '@STTBS_FIELD_LOG';
                  END;
               END IF;

            END IF;
            g_curr_stage := 'POSTMAINTLOG';
            l_Skip_custom:= g_Skip_custom;
            stpks_stdkevi4_Main.Pr_Set_Skip_CUSTOM;
            l_Wrk_stdkevi4:=p_Wrk_stdkevi4;
            Pr_Skip_Handler('POSTMAINTLOG');
            Dbg('Calling Post Upload Hooks For any Additional Logging');
            IF NOT stpks_stdkevi4_Main.Fn_Skip_custom  THEN
               IF NOT stpks_stdkevi4_Custom.Fn_Post_Upload_Db (p_Source,
                  p_Source_operation,
                  p_Function_id,
                  p_Action_Code,
                  p_function_Id  ,
                  g_Post_Upl_Stat,
                  p_Multi_Trip_Id,
                  p_stdkevi4,
                  p_Prev_stdkevi4,
                  l_Wrk_stdkevi4,
                  p_Err_Code,
                  p_Err_Params) THEN
                  Dbg('Failed in stpks_stdkevi4_Custom.Fn_Post_Upload_Db After Logging');
                  RETURN FALSE;
               END IF;
            END IF;
            g_Skip_custom:= l_Skip_custom;
            g_curr_stage := NULL;
         END IF;
      END IF;

      Dbg('Returning Success From Fn_Maint_Log..');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Maint_Log ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := Null;
         RETURN FALSE;
   END Fn_Maint_Log;

   FUNCTION Fn_Extract_Custom_Data (p_Source   IN     VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
                              p_Addl_Info         IN OUT Cspks_Req_Global.Ty_Addl_Info,
                              p_Status            IN OUT VARCHAR2 ,
                              p_Err_Code          IN OUT VARCHAR2,
                              p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN IS

      E_Failure_Exception     EXCEPTION;
      l_stdkevi4     stpks_stdkevi4_Main.Ty_stdkevi4;

   BEGIN

      Dbg('In Fn_Extract_Custom_Data.. ');
      IF NOT  Fn_Build_Type(p_source,
         p_Source_Operation,
         p_Function_Id,
         p_Action_Code,
         p_Addl_Info,
         l_stdkevi4,
         p_Err_Code,
         p_Err_Params)  THEN
         Dbg('Failed in Fn_Build_Type..');
         p_Status      := 'F';
         RAISE e_Failure_Exception;
      END IF;
      Dbg('Calling  Fn_Get_Key_Information..');
      IF NOT  Fn_Get_Key_Information(p_Source,
         p_Source_Operation,
         p_Function_Id,
         p_Action_Code,
         l_stdkevi4,
         p_Err_Code,
         p_Err_Params)  THEN
         Dbg('Failed in Fn_Get_Key_Information..');
         RAISE e_Failure_Exception;
      END IF;
      p_Addl_Info := l_stdkevi4.Addl_Info;
      Dbg('Returning from Fn_Extract_Custom_Data..');
      RETURN TRUE;

   EXCEPTION
      WHEN E_Failure_Exception THEN
         Dbg('From E_Failure_Exception of Fn_Extract_Custom_Data..');
         p_Status        := 'F';
         Dbg('Errors     :'||p_Err_Code);
         Dbg('Parameters :'||p_Err_Params);
         RETURN TRUE;
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Extract_Custom_Data..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Status      := 'F';
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := Null;
         RETURN FALSE;
   END Fn_Extract_Custom_Data;

   FUNCTION Fn_Rebuild_Ts_List (p_Source    IN     VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
                              p_Exchange_Pattern  IN     VARCHAR2,
                              p_Status            IN OUT VARCHAR2 ,
                              p_Err_Code          IN OUT VARCHAR2,
                              p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN IS

      E_Failure_Exception     EXCEPTION;

   BEGIN

      Dbg('In Fn_Rebuild_Ts_List ');
      IF NOT  Fn_Build_Ts_List(p_Source,
         p_Source_Operation,
         p_Function_Id,
         p_Action_Code,
         p_Exchange_Pattern,
         g_stdkevi4,
         p_Err_Code,
         p_Err_Params)  THEN
         Dbg('Failed in Fn_Build_Ts_List');
         p_Status      := 'F';
         RETURN FALSE;
      END IF;
      Dbg('Returning Success From Fn_Rebuild_Ts_List..');
      RETURN TRUE;

   EXCEPTION
      WHEN E_Failure_Exception THEN
         Dbg('From E_Failure_Exception of Fn_Rebuild_Ts_List');
         p_Status        := 'F';
         Dbg('Errors     :'||p_Err_Code);
         Dbg('Parameters :'||p_Err_Params);
         RETURN TRUE;
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Rebuild_Ts_List..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Status      := 'F';
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := Null;
         RETURN FALSE;
   END Fn_Rebuild_Ts_List;

   FUNCTION Fn_Get_Node_Data (
      p_Node_Data         IN OUT Cspks_Req_Global.Ty_Tb_Chr_Node_Data,
      p_Err_Code          IN OUT VARCHAR2,
      p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN   IS
      l_Cntr NUMBER := 0;
   BEGIN

      Dbg('In Fn_Get_Node_Data..');
      l_Cntr  := Nvl(p_Node_Data.Count,0) + 1;
      p_Node_Data(l_Cntr).Node_Name := 'BLK_MASTER';
      p_Node_Data(l_Cntr).Xsd_Node := 'Master';
      p_Node_Data(l_Cntr).Node_Parent := '';
      p_Node_Data(l_Cntr).Node_Relation_Type := '1';
      p_Node_Data(l_Cntr).Query_Node := '0';
      p_Node_Data(l_Cntr).Node_Fields := 'AMOUNT~CCY~CUSTOMER_ACCOUNT~CUSTOMER_NAME~CUSTOMER_NO~C_DATE~EMAIL~PHONE_NUMBER~PRIORITY~MAKER~MAKERSTAMP~CHECKER~CHECKERSTAMP~MODNO~TXNSTAT~AUTHSTAT~ONCEAUTH~';
      p_Node_Data(l_Cntr).Node_Tags := 'AMOUNT~CCY~ACCOPT~CUSTOMER_NAME~CUSTOMER_NO~INCORPDT~EMAIL~PHONE_NUMBER~PRIORITY~MAKER~MAKERSTAMP~CHECKER~CHECKERSTAMP~MODNO~TXNSTAT~AUTHSTAT~ONCEAUTH~';

      l_Cntr  := Nvl(p_Node_Data.Count,0) + 1;
      p_Node_Data(l_Cntr).Node_Name := 'BLK_DETAIL';
      p_Node_Data(l_Cntr).Xsd_Node := 'Detail';
      p_Node_Data(l_Cntr).Node_Parent := 'BLK_MASTER';
      p_Node_Data(l_Cntr).Node_Relation_Type := 'N';
      p_Node_Data(l_Cntr).Query_Node := '0';
      p_Node_Data(l_Cntr).Node_Fields := 'CUSTOMER_ID~CUSTOMER_NO~DETAIL_DESCRIPTION~DETAIL_USER~D_DATE~SUBJECT~';
      p_Node_Data(l_Cntr).Node_Tags := 'CUSTOMER_ID~CUSTOMER_NO~FILE_CON_CDE_DESC~USER~INCORPDT~SUBJECT~';

      l_Cntr  := Nvl(p_Node_Data.Count,0) + 1;
      p_Node_Data(l_Cntr).Node_Name := 'BLK_HEADER';
      p_Node_Data(l_Cntr).Xsd_Node := 'Header';
      p_Node_Data(l_Cntr).Node_Parent := '';
      p_Node_Data(l_Cntr).Node_Relation_Type := '1';
      p_Node_Data(l_Cntr).Query_Node := '0';
      p_Node_Data(l_Cntr).Node_Fields := '';
      p_Node_Data(l_Cntr).Node_Tags := '';

      Dbg('Returning From Fn_Get_Node_Data.. ');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others Of stpks_stdkevi4_Main.Fn_Get_Node_Data..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := NULL;
         RETURN FALSE;
   END Fn_Get_Node_Data;
   FUNCTION Fn_Int_Main   (p_Source            IN     VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_action_Code       IN     VARCHAR2,
                              p_Multi_Trip_Id     IN     VARCHAR2,
                              p_Request_No        IN     VARCHAR2,
                              p_stdkevi4          IN OUT stpks_stdkevi4_Main.ty_stdkevi4,
                              p_Status            IN OUT VARCHAR2 ,
                              p_Err_Code          IN OUT VARCHAR2,
                              p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN IS

      E_Failure_Exception     EXCEPTION;
      E_Override_Exception    EXCEPTION;
      l_Resultant_Error_Type  VARCHAR2(32767):= 'I';
      l_Post_Upl_Stat         VARCHAR2(1) :='A';
      l_Prev_Auth_Stat        VARCHAR2(1) :='U';
      l_Wrk_stdkevi4    stpks_stdkevi4_Main.Ty_stdkevi4;
      l_Prev_stdkevi4    stpks_stdkevi4_Main.Ty_stdkevi4;
      l_Dmy_stdkevi4    stpks_stdkevi4_Main.Ty_stdkevi4;
      l_Pk_Or_Full    VARCHAR2(5) :='PK';
      l_Full_Data    VARCHAR2(1) := 'Y';
      l_With_Lock    VARCHAR2(1) := 'N';
      l_Qrydata_Reqd    VARCHAR2(1) := 'Y';
      l_Count         NUMBER;
      l_Action_Code       VARCHAR2(100):= p_Action_Code;
      l_Record_Master     Sttbs_Record_Master%ROWTYPE;
      l_Sent_Mod_No                NUMBER;
      l_Tanking_Status                VARCHAR2(1) := 'N';

   BEGIN

      Dbg('In Fn_Int_Main..');

      SAVEPOINT Sp_Int_Main_Stdkevi4;
      p_Status := 'S';
      g_Tanking_Status := l_Tanking_Status;
      g_stdkevi4 := p_stdkevi4;
      l_Wrk_stdkevi4 := p_stdkevi4;

      Dbg('Calling  Fn_Check_Mandatory..');
      IF NOT Fn_Check_Mandatory(p_Source,
         p_Source_Operation,
         p_Function_Id,
         p_Action_Code,
         l_Pk_Or_Full,
         p_stdkevi4,
         p_Err_Code,
         p_Err_Params)  THEN
         Dbg('Failed in Fn_Check_Mandatory..');
         Pr_Log_Error(p_Source,p_Err_Code, p_Err_Params);
         RAISE E_Failure_Exception;
      END IF;

      IF NOT  Fn_Get_Key_Information(p_Source,
         p_Source_Operation,
         p_Function_id,
         p_Action_Code,
         p_stdkevi4,
         p_Err_Code,
         p_Err_Params)  THEN
         Dbg('Failed in Fn_Get_Key_Information..');
         RAISE e_Failure_Exception;
      END IF;
      l_Sent_Mod_No := p_stdkevi4.v_master_stdkevi4.Mod_No;
      Dbg('Calling Cspks_Req_Utils.Fn_Process_Tanked_Entries..');
      IF NOT Cspks_Req_Utils.Fn_Process_Tanked_Entries(p_Source,
         p_Source_Operation,
         p_Function_Id,
         p_Action_Code,
         g_Key_Id,
         l_Sent_Mod_No,
         l_Action_Code,
         p_Err_Code,
         p_Err_Params) THEN
         Dbg('Failed in  Cspks_Req_Utils.Fn_Process_Tanked_Entries..');
         RAISE E_Failure_Exception;
      END IF;

      IF p_Action_Code = Cspks_Req_Global.p_query THEN
         Dbg('Calling in Fn_Query..');
         IF NOT Fn_Query(p_Source,
            p_Source_Operation,
            p_Function_Id,
            l_Action_Code,
            l_Full_data,
            l_with_lock,
            l_Qrydata_Reqd,
            p_stdkevi4,
            l_Wrk_stdkevi4,
            p_Err_Code,
            p_Err_Params) THEN
            Dbg('Failed in Fn_Query..');
            Pr_Log_Error(p_Source,p_Err_Code, p_Err_Params);
            RAISE E_Failure_Exception;
         END IF;
      ELSE
         Dbg('Calling  Fn_Default_And_Validate..');
         IF NOT Fn_Default_And_Validate (p_Source,
            p_Source_Operation,
            p_Function_Id,
            l_Action_Code,
            p_stdkevi4,
            l_Prev_stdkevi4,
            l_Wrk_stdkevi4,
            p_Err_Code,
            p_Err_Params) THEN
            Dbg('Failed in Fn_Default_And_Validate..');
            pr_log_error(p_Source,p_Err_Code, p_Err_Params);
            RAISE E_Failure_Exception;
         END IF;

         -- Get Resultant Error Type
         l_Resultant_Error_Type := Cspks_Req_Utils.Fn_Get_Resultant_Error_Type;
         IF l_Resultant_Error_Type <> 'E' THEN
            Dbg('Calling  Fn_Upload_Db..');
            IF NOT Fn_Upload_Db (p_Source,
               p_Source_Operation,
               p_Function_Id,
               l_Action_Code,
               l_Post_Upl_Stat,
               p_Multi_Trip_Id,
               p_stdkevi4,
               l_Prev_stdkevi4,
               l_Wrk_stdkevi4,
               p_Err_Code,
               p_Err_Params) THEN
               Dbg('Failed in Fn_Upload_Db..');
               pr_log_error(p_Source,p_Err_Code, p_Err_Params);
               RAISE E_Failure_Exception;
            END IF;
            IF  l_Action_Code IN (Cspks_Req_Global.p_New,Cspks_Req_Global.p_Modify,Cspks_Req_Global.p_Close,Cspks_Req_Global.p_Reopen) THEN
               l_Prev_Auth_Stat := NVL(l_Prev_stdkevi4.v_master_stdkevi4.Auth_Stat,'A') ;
               --Get Upload Status
               Dbg('Calling Cspks_Req_Utils.Fn_Get_Auto_Auth_Status..');
               IF NOT Cspks_Req_Utils.Fn_Get_Auto_Auth_Status (p_Source,
                  p_Source_Operation,
                  p_Function_Id,
                  l_Action_Code,
                  l_Prev_Auth_Stat,
                  p_Multi_Trip_Id,
                  P_Request_No,
                  l_Post_Upl_Stat,
                  p_Err_Code,
                  p_Err_Params) THEN
                  Dbg('Failed in Cspks_Req_Utils.Fn_Get_Auto_Auth_Status..');
                  Pr_Log_Error(p_Source,p_Err_Code,p_Err_Params);
                  RAISE E_Failure_Exception;
               END IF;

               IF l_Post_Upl_Stat NOT IN ('A','U','O') THEN
                  Dbg('Cannot Proceed Further..');
                  RAISE E_Failure_Exception;
               ELSE
                  IF l_post_upl_stat = 'A'THEN
                     Dbg('Calling  Fn_Upload_Db..');
                     IF NOT Fn_Upload_Db (p_Source,
                        p_Source_Operation,
                        p_Function_Id,
                        Cspks_Req_Global.p_auth,
                        l_Post_Upl_Stat,
                        p_Multi_Trip_Id,
                        p_stdkevi4,
                        l_Prev_stdkevi4,
                        l_Wrk_stdkevi4,
                        p_Err_Code,
                        p_Err_Params) THEN
                        Dbg('Failed in Fn_Upload_Db..');
                        Pr_Log_Error(p_Source,p_Err_Code, p_Err_Params);
                        RAISE E_Failure_Exception;
                     END IF;
                  END IF;
               END IF;
            END IF;
            --Get Upload Status
            Dbg('Calling  Cspks_Req_Utils.Fn_Get_Upload_Status..');
            IF NOT Cspks_Req_Utils.Fn_Get_Upload_Status (p_Source,
               p_source_operation,
               p_Function_Id,
               l_Action_Code,
               p_Multi_Trip_Id,
               P_Request_No,
               l_Post_Upl_Stat,
               p_Err_Code,
               p_Err_Params) THEN
               Dbg('Failed in Cspks_Req_Utils.Fn_Get_Upload_Status..');
               Pr_Log_Error(p_Source,p_Err_Code,p_Err_Params);
               RAISE E_Failure_Exception;
            END IF;

            IF l_Post_Upl_Stat IN ('A','U') THEN
               Dbg('Success Case...');
               IF l_Action_Code IN (Cspks_Req_Global.p_New,Cspks_Req_Global.p_Modify,Cspks_Req_Global.p_Auth,Cspks_Req_Global.p_Close,Cspks_Req_Global.p_Reopen,Cspks_Req_Global.p_Query,Cspks_Req_Global.p_Version_Delete ) THEN
                  IF NOT Fn_Query(p_Source,
                     p_Source_Operation,
                     p_Function_Id,
                     l_Action_Code,
                     l_Full_Data,
                     l_With_Lock,
                     l_Qrydata_Reqd,
                     l_Wrk_stdkevi4,
                     l_Wrk_stdkevi4,
                     p_Err_Code,
                     p_Err_Params) THEN
                     Dbg('Failed in Fn_Query..');
                     Pr_Log_Error(p_Source,p_Err_Code, p_Err_Params);
                     RAISE E_Failure_Exception;
                  END IF;
               END IF;
            ELSIF l_Post_Upl_Stat ='O' THEN
               Dbg('Raising Override Exception..');
               RAISE E_Override_Exception;
            ELSE
               Dbg('Not Feasible to Proceed..');
               RAISE E_Failure_Exception;
            END IF;
         ELSE
            Dbg('Encountered Errros..');
            RAISE E_Failure_Exception;
         END IF;
         Dbg('Calling Fn_Populate_Record_Master..');
         IF NOT Fn_Populate_Record_Master(p_Source,
            p_Source_Operation,
            p_Function_Id,
            l_Action_Code,
            l_Wrk_stdkevi4,
            l_Record_Master,
            p_Err_Code,
            p_Err_Params) THEN
            Dbg('Failed in Fn_Populate_Record_Master..');
            Pr_Log_Error(p_Source,p_Err_Code, p_Err_Params);
            RAISE E_Failure_Exception;
         END IF;
         IF NOT Fn_Tank_Modification(p_Source,
            p_Source_Operation,
            p_Function_Id,
            l_Action_Code,
            l_Tanking_Status,
            p_Err_Code,
            p_Err_Params) THEN
            Dbg('Rolling Back the Modification..');
            Pr_Log_Error(p_Source,p_Err_Code, p_Err_Params);
            RAISE E_Failure_Exception;
         END IF;

      END IF; -- Action Code

      Cspks_Req_Utils.Pr_Get_Final_Err_Code(p_Function_Id,l_Action_Code,l_Post_Upl_Stat,p_Err_Code,p_Err_Params);
      Pr_Log_Error(p_Source,p_Err_Code,p_Err_Params);
      g_stdkevi4 := l_wrk_stdkevi4;
      g_post_upl_stat := l_Post_Upl_Stat;
      Dbg('Calling  Cspks_Req_Utils.Fn_Maint_Log..');
      IF NOT Fn_Maint_Log(p_Source,
         p_Source_Operation,
         p_Function_Id,
         l_Action_Code,
         p_Multi_Trip_Id,
         p_Request_No,
         l_Record_Master,
         p_stdkevi4,
         l_Prev_stdkevi4,
         l_Wrk_stdkevi4,
         l_Tanking_Status,
         p_Err_Code,
         p_Err_Params) THEN
         Dbg('Failed in   Cspks_Req_Utils.Fn_Maint_Log..');
         Pr_Log_Error(p_Source,p_Err_Code, p_Err_Params);
         RAISE E_Failure_Exception;
      END IF;
      IF l_Action_Code = Cspks_Req_Global.p_Delete AND p_Source = 'FLEXCUBE'  THEN
         l_Wrk_stdkevi4 := l_Dmy_stdkevi4;
      END IF;
      p_stdkevi4 := l_wrk_stdkevi4;
      Dbg('Errors     :'||p_Err_Code);
      Dbg('Parameters :'||p_Err_Params);

      Dbg('Returning Success From Fn_Int_Main..');
      RETURN TRUE;

   EXCEPTION
      WHEN E_Failure_Exception THEN
         Dbg('From E_Failure_Exception of Fn_Int_Main..');
         ROLLBACK TO Sp_Int_Main_Stdkevi4;
         p_Status        := 'F';
         l_Post_Upl_Stat := 'F';
         Cspks_Req_Utils.Pr_Get_Final_Err_Code(p_Function_Id,l_Action_Code,l_Post_Upl_Stat,p_Err_Code,p_Err_Params);
         Pr_Log_Error(p_Source,p_Err_Code,p_Err_Params);
         Dbg('Errors     :'||p_Err_Code);
         Dbg('Parameters :'||p_Err_Params);
         RETURN TRUE;

      WHEN E_Override_Exception THEN
         Dbg('From E_Override_Exception of Fn_Int_Main');
         p_Status        := 'O';
         l_post_upl_stat := 'O';
         IF NOT Cspks_Req_Utils.Fn_Log_Overrides(p_Multi_Trip_Id, p_Request_No, p_Err_Code, p_Err_Params) THEN
            Dbg('Failed inCspks_Req_Utils.Fn_Log_Overrides..');
            p_Err_Code    := 'ST-OTHR-001';
            p_Err_Params  := Null;
            RETURN FALSE;
         END IF;
         Cspks_Req_Utils.Pr_Get_Final_Err_Code(p_Function_Id,l_Action_Code,l_Post_Upl_Stat,p_Err_Code,p_Err_Params);
         Pr_Log_Error(p_Source,p_Err_Code,p_Err_Params);
         Dbg('Errors     :'||p_Err_Code);
         Dbg('Parameters :'||p_Err_Params);
         RETURN TRUE;

      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Int_Main ..');
         Debug.Pr_Debug('**',SQLERRM);
         ROLLBACK TO Sp_Int_Main_Stdkevi4;
         p_Status      := 'F';
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := Null;
         RETURN FALSE;
   END Fn_Int_Main;

   FUNCTION Fn_Main   (p_Source            IN     VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
                              p_Multi_Trip_Id     IN     VARCHAR2,
                              p_Request_No        IN     VARCHAR2,
                              p_stdkevi4          IN OUT stpks_stdkevi4_Main.ty_stdkevi4,
                              p_Status            IN OUT VARCHAR2 ,
                              p_Err_Code          IN OUT VARCHAR2,
                              p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN IS

      E_Failure_Exception     EXCEPTION;
      E_Override_Exception    EXCEPTION;

   BEGIN

      Dbg('In Fn_Main..');
      SAVEPOINT Sp_Main_Stdkevi4;
      Dbg('Calling  Fn_Int_Main..');
      IF NOT  Fn_Int_Main(p_Source,
         p_Source_Operation,
         p_Function_id,
         p_Action_Code,
         p_Multi_Trip_Id,
         p_Request_No,
         p_stdkevi4,
         p_Status,
         p_Err_Code,
         p_Err_Params)  THEN
         Dbg('Failed in Fn_Int_Main..');
         RAISE E_Failure_Exception;
      END IF;
      IF p_Status = 'F' THEN
         RAISE E_Failure_Exception;
      ELSIF p_Status = 'O' THEN
         RAISE E_Override_Exception;
      END IF;
      Dbg('Returning Success From Fn_Main..');
      RETURN TRUE;

   EXCEPTION
      WHEN E_Failure_Exception THEN
         Dbg('From E_Failure_Exception of Fn_Main');
         ROLLBACK TO Sp_Main_Stdkevi4;
         p_Status      := 'F';
         RETURN TRUE;

      WHEN E_Override_Exception THEN
         Dbg('From E_Override_Exception of Fn_Main..');
         p_Status      := 'O';
         RETURN TRUE;

      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Main ..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Status      := 'F';
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := Null;
         ROLLBACK TO Sp_Main_Stdkevi4;
         RETURN FALSE;
   END Fn_Main;

   FUNCTION Fn_Process_Request (p_Source    IN     VARCHAR2,
                              p_Source_Operation  IN     VARCHAR2,
                              p_Function_Id       IN     VARCHAR2,
                              p_Action_Code       IN     VARCHAR2,
                              p_Exchange_Pattern  IN     VARCHAR2,
                              p_Multi_Trip_Id     IN     VARCHAR2,
                              p_Request_No        IN     VARCHAR2,
                              p_Addl_Info         IN OUT Cspks_Req_Global.Ty_Addl_Info,
                              p_Status            IN OUT VARCHAR2 ,
                              p_Err_Code          IN OUT VARCHAR2,
                              p_Err_Params        IN OUT VARCHAR2)
   RETURN BOOLEAN IS

      l_stdkevi4     stpks_stdkevi4_Main.ty_stdkevi4;

   BEGIN

      Dbg('In Fn_Process_Request ');
      IF NOT  Fn_Build_Type(p_Source,
         p_Source_Operation,
         p_Function_id,
         p_Action_Code,
         p_Addl_Info,
         l_stdkevi4,
         p_Err_Code,
         p_Err_Params)  THEN
         Dbg('Failed in Fn_Build_Type..');
         p_status      := 'F';
         RETURN FALSE;
      END IF;
      IF Cspks_Req_Global.Fn_UnTanking THEN
         IF NOT  Fn_Int_Main(p_Source,
            p_Source_Operation,
            p_Function_Id,
            p_Action_Code,
            p_Multi_Trip_Id,
            p_Request_No,
            l_stdkevi4,
            p_Status,
            p_Err_Code,
            p_Err_Params)  THEN
            Dbg('Failed in Fn_main..');
            RETURN FALSE;
         END IF;
      ELSE
         IF NOT  Fn_Main(p_source,
            p_Source_Operation,
            p_Function_id,
            p_Action_Code,
            p_Multi_Trip_Id,
            p_Request_No,
            l_stdkevi4,
            p_Status,
            p_Err_Code,
            p_Err_Params)  THEN
            Dbg('Failed in Fn_main..');
            RETURN FALSE;
         END IF;
      END IF;

      p_addl_info := l_stdkevi4.Addl_Info;
      IF Cspks_Req_Global.Fn_Build_Resp THEN
         Cspks_Req_Global.Pr_Reset;
         IF NOT  Fn_Build_Ts_List(p_Source,
            p_Source_Operation,
            p_Function_id,
            p_Action_Code,
            p_Exchange_Pattern,
            l_stdkevi4,
            p_Err_Code,
            p_Err_Params)  THEN
            Dbg('Failed in Fn_Build_Ts_List..');
            p_Status      := 'F';
            RETURN FALSE;
         END IF;
         Cspks_Req_Global.Pr_Close_Ts;
      END IF;
      Dbg('Returning Success From Fn_Process_Request..');
      RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
         Debug.Pr_Debug('**','In When Others of Fn_Process_Request..');
         Debug.Pr_Debug('**',SQLERRM);
         p_Status      := 'F';
         p_Err_Code    := 'ST-OTHR-001';
         p_Err_Params  := Null;
         RETURN FALSE;
   END Fn_Process_Request;

END stpks_stdkevi4_main;
/