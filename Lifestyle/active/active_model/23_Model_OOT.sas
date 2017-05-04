
  ods graphics on;
proc logistic data = SPDTMP30.VB_CUS_TN_ITM_REV_AE_6 plots=ROC  
     outest = SPDTMP7.VB_CUS_TN_ITM_REV_AE_sigvar_fv   /* this has list of Significant Vars*/
     outmodel = SPDTMP7.VB_CUS_TN_ITM_REV_AE_scoring_fv  /* this is used for scoring, also has significant variables */
     descending  ;
model  Bought_flag =  &Model_variables. /  lackfit rsquare ctable outroc=ROC_sd;
output out = SPDTMP7.VB_CUS_TN_ITM_REV_AE_results_fv    p = pred_RESPONSE ;
 roc; 
run;
ods graphics off;




/* Scoring the Validation Data */

proc logistic  
     inmodel = SPDTMP7.VB_CUS_TN_ITM_REV_AE_scoring_new;
     score data = SPDTMP30.VB_CUS_TN_ITM_REV_AE_6
	 Out  = SPDTMP7.VB_CUS_TN_ITM_REV_AE_Test_oos;
run;    


data SPDTMP7.VB_CUS_TN_ITM_REV_AE_oos_conf;
set SPDTMP7.VB_CUS_TN_ITM_REV_AE_Test_oos;

if P_1 >= 0.054 then prediction = 1;
else prediction = 0;
run;

proc freq data= SPDTMP7.VB_CUS_TN_ITM_REV_AE_oos_conf;
        table Bought_flag * prediction ;
run;

