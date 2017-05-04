



  ods graphics on;
proc logistic data = SPDTMP7.VB_CUS_TN_ITM_REV_AE_Test plots=ROC  
     outest = SPDTMP7.VB_CUS_TN_ITM_REV_AE_sigvar_f  /* this has list of Significant Vars*/
     outmodel = SPDTMP7.VB_CUS_TN_ITM_REV_AE_scoring_f  /* this is used for scoring, also has significant variables */
     descending  ;
model  Bought_flag =  &Model_variables. /  lackfit rsquare ctable outroc=ROC_sd;
output out = SPDTMP7.VB_CUS_TN_ITM_REV_AE_results_f    p = pred_RESPONSE ;
 roc; 
run;
ods graphics off;

proc npar1way data=SPDTMP7.VB_CUS_TN_ITM_REV_AE_results_new edf;
        class Bought_flag;
        var pred_RESPONSE;
 run;
   

data SPDTMP7.VB_CUS_TN_ITM_REV_AE_Conf_new;
set SPDTMP7.VB_CUS_TN_ITM_REV_AE_results_new;

if pred_response >= 0.13 then prediction = 1;
else prediction = 0;
run;

proc freq data= SPDTMP7.VB_CUS_TN_ITM_REV_AE_Conf_new;
        table Bought_flag * prediction ;
run;

/* Scoring the Test Data */

proc logistic  
     inmodel = SPDTMP7.VB_CUS_TN_ITM_REV_AE_scoring_new;
     score data = SPDTMP7.VB_CUS_TN_ITM_REV_AE_Test
	 Out  = SPDTMP7.VB_CUS_TN_ITM_REV_AE_Test_res;
run;    


data SPDTMP7.VB_CUS_TN_ITM_REV_AE_Test_Conf;
set SPDTMP7.VB_CUS_TN_ITM_REV_AE_Test_res;

if P_1 >= 0.138 then prediction = 1;
else prediction = 0;
run;

proc freq data= SPDTMP7.VB_CUS_TN_ITM_REV_AE_Test_Conf;
        table Bought_flag * prediction ;
run;



 proc rank data=SPDTMP7.VB_CUS_TN_ITM_REV_AE_Test_res out=deciles ties=low
 descending groups=10;
 var P_1;
 ranks decile;
 run;

proc sql;
 select sum(Bought_flag) into: total_hits
 from SPDTMP7.VB_CUS_TN_ITM_REV_AE_Test_res
 ;
 create table lift as
 select sum(Bought_flag)/&total_hits as true_positive_rate,decile + 1 as decile
 from deciles
 group by decile
 order by decile
 ;
 quit;



 data cum_lift;
 set lift;
 cum_positive_rate + true_positive_rate;
 cum_lift=cum_positive_rate/(decile/10);
 run;