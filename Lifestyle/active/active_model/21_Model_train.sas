



%let Model_variables = 
	
Dpt_FashAcc_trnxns
/*Dpt_HomeFrag_trnxns*/
Dpt_Spa_trnxns
Dpt_TeenGifts_Rev
FEMALE_REV_AED
KIDS_REV_AED
Lstg_sgmnt_5
Lstg_sgmnt_7
/*Nationality_ExpatArab*/
Nationality_Local
/*Num_Visits_6_HC*/
/*REVENUEAED_NONSALE_3*/
RFM_2
RFM_3
RFM_4
RFM_5
RFM_6
Rev_Grp_WB_perc
Rev_LS_perc
/*Rev_d_TeenG_perc*/
Sex_F_dummy
/*Total_points_LMG3*/
/*Units_SH_perc*/
active_time_LMG3
;

ODS graphics on;
proc logistic data = SPDTMP7.VB_CUS_TN_ITM_REV_AE_Training plots=ROC  
     outest = SPDTMP7.VB_CUS_TN_ITM_REV_AE_sigvar_new   /* this has list of Significant Vars*/
     outmodel = SPDTMP7.VB_CUS_TN_ITM_REV_AE_scoring_new  /* this is used for scoring, also has significant variables */
     descending  ;
model  Bought_flag = &Model_variables. /  lackfit rsquare ctable outroc=ROC_sd;
output out = SPDTMP7.VB_CUS_TN_ITM_REV_AE_results_new    p = pred_RESPONSE ;
 roc; 
run;
ods graphics off;

proc npar1way data=SPDTMP7.VB_CUS_TN_ITM_REV_AE_results_new edf;
        class Bought_flag;
        var pred_RESPONSE;
 run;
   

data SPDTMP7.VB_CUS_TN_ITM_REV_AE_Conf_new;
set SPDTMP7.VB_CUS_TN_ITM_REV_AE_results_new;

if pred_response >= 0.138 then prediction = 1;
else prediction = 0;
run;

proc freq data= SPDTMP7.VB_CUS_TN_ITM_REV_AE_Conf_new;
        table Bought_flag * prediction ;
run;

 proc rank data=SPDTMP7.VB_CUS_TN_ITM_REV_AE_results_new out=deciles ties=low
 descending groups=10;
 var pred_RESPONSE;
 ranks decile;
 run;

proc sql;
 select sum(Bought_flag) into: total_hits
 from SPDTMP7.VB_CUS_TN_ITM_REV_AE_results_new
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
