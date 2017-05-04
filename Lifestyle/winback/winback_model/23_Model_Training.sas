%let variables = 
MC_return_revenue_aed
active_time_9
/*active_time_lmg3*/
active_time_MX3
active_time_SM
avg_units_per_txn_6
avg_units_per_txn_SH
/*distinct_prod_3*/
/*distinct_prod_9*/
distinct_prod_BS3
Expat_Arab_nat_dummy
FEMALE_REV_AED
ISC_nat_dummy
KIDS_REV_AED
LMG_EFFECTIVE_POINTS
Local_nat_dummy
Lstg_sgmnt_2
MC_L9m_return_units
/*no_of_txn_404*/
no_of_txn_407
no_of_txn_408
no_of_txn_418
no_of_txn_d_400_perc
no_of_txn_d_402_perc
recency_3
recency_6
recency_9
recency_BS
/*recency_HC*/
/*recency_HC3*/
recency_lmg
recency_lmg3
recency_lmg6
/*recency_MX3*/
recency_SH
recency_SM
RFM_1
RFM_2
RFM_3
RFM_4
total_points_3
total_points_6
total_points_MX
total_points_SH6
total_unit_SM6
Units_d_412_perc
;



%let variables1 = 
/*active_time_9*/
/*active_time_MX3*/
avg_units_per_txn_6
Expat_Arab_nat_dummy
FEMALE_REV_AED
KIDS_REV_AED
Local_nat_dummy
/*Lstg_sgmnt_2*/
MC_L9m_return_units
/*no_of_txn_408*/
no_of_txn_418
/*no_of_txn_d_400_perc*/
recency_3
recency_6
recency_9
/*recency_BS*/
/*recency_lmg*/
/*recency_lmg3*/
/*recency_SM*/
/*recency_lmg6*/
RFM_1
RFM_2
RFM_3
/*RFM_4*/
/*total_points_3*/
/*total_points_6*/
total_points_MX
total_points_SH6
;

/*proc reg data= spdtmp7.VB_WB_LS_Alldata16_Train ;*/
/*    model Bought_flag =  &variables./ VIF;*/
/*run; */


ODS graphics on;
proc logistic data = spdtmp7.VB_WB_LS_Alldata16_Train plots=ROC  
     outest = spdtmp7.VB_WB_LS_Train_sv   /* this has list of Significant Vars*/
     outmodel = spdtmp7.VB_WB_LS_Train_scores  /* this is used for scoring, also has significant variables */
     descending  ;
model  Bought_flag = &variables1. /  lackfit rsquare ctable outroc=ROC_sd;
output out = spdtmp7.VB_WB_LS_Alldata16_Train_res    p = pred_RESPONSE ;
 roc; 
run;
ods graphics off;

/* KS computation */

proc npar1way data=spdtmp7.VB_WB_LS_Alldata16_Train_res edf;
        class Bought_flag;
        var pred_RESPONSE;
 run;

/* Confusion Matrix for Precision and Recall*/ 
 
  
data spdtmp7.VB_WB_LS_Alldata16_Train_Conf;
set spdtmp7.VB_WB_LS_Alldata16_Train_res;

if pred_response >= 0.023 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.VB_WB_LS_Alldata16_Train_Conf;
        table Bought_flag * prediction ;
run;


/* Lift calculation */

 proc rank data=spdtmp7.VB_WB_LS_Alldata16_Train_res out= spdtmp7.VB_WB_LS_Alldata16_Train_dec ties=low
 descending groups=10;
 var pred_RESPONSE;
 ranks decile;
 run;

proc sql;
 select sum(Bought_flag) into: total_hits
 from spdtmp7.VB_WB_LS_Alldata16_Train_res
 ;
 create table spdtmp7.VB_WB_LS_Alldata16_Train_lift as
 select sum(Bought_flag)/&total_hits as true_positive_rate,decile + 1 as decile
 from spdtmp7.VB_WB_LS_Alldata16_Train_dec
 group by decile
 order by decile
 ;
 quit;


 data cum_lift;
 set spdtmp7.VB_WB_LS_Alldata16_Train_lift;
 cum_positive_rate + true_positive_rate;
 cum_lift=cum_positive_rate/(decile/10);
 run;

 
















 