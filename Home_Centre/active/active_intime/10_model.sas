

%let Indep_var_1 =

active_time_9

avg_units_per_txn
no_of_txn_307
no_of_visits_furniture
perc_revenue_ls
recency_3
recency_9
recency_lmg
LMG_EFFECTIVE_POINTS
active_time_hb
avg_days_dif
avg_points
avg_units_per_txn_bs
recency_6
Expat_Arab_nat_dummy
ISC_nat_dummy
Local_nat_dummy

RFM_2
RFM_4
RFM_5
RFM_6
MC_L3m_return_revenue_Aed
revenue_AED_Beauty

;

proc reg data=spdtmp7.sd_hc_training;
model purchase_flag= &Indep_var_1. /vif;
run;


ODS graphics on;
proc logistic data = spdtmp7.sd_hc_training plots=ROC  
     outest = spdtmp7.sd_hc_sigvar    /* this has list of Significant Vars*/
     outmodel = spdtmp7.sd_hc_scoring  /* this is used for scoring, also has significant variables */
     descending  ;
model  purchase_flag =  &Indep_var_1. /    lackfit rsquare 
     ctable outroc=ROC_sd;
output out = spdtmp7.sd_hc_model    p = pred_RESPONSE ;
roc; 
run;
ods graphics off;



proc npar1way data=spdtmp7.sd_hc_model edf;
        class purchase_flag;
        var pred_RESPONSE;
run;
   
proc sql;
select count(*) , sum(purchase_flag)
from spdtmp7.sd_hc_model;
quit;


data spdtmp7.sd_hc_model_confusion;
set spdtmp7.sd_hc_model;

if pred_response >= 0.13 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.sd_hc_model_confusion;
        table purchase_flag * prediction ;
run;

proc logistic  
     inmodel = spdtmp7.sd_hc_scoring;
     score data = spdtmp7.sd_hc_testing
     Out  = spdtmp7.sd_hc_test_score;
run;    

data spdtmp7.sd_hc_model_confusion;
set spdtmp7.sd_hc_test_score;

if P_1 >= 0.14 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.sd_hc_model_confusion;
        table purchase_flag * prediction ;
run;



/* Creating Lift chart */


proc rank data=spdtmp7.sd_hc_model out=deciles ties=low
descending groups=10;
var pred_RESPONSE;
ranks decile;
run;

proc sql;
select sum(purchase_flag) into: total_hits
from spdtmp7.sd_hc_model
;
create table lift as
select sum(purchase_flag)/&total_hits as true_positive_rate,decile + 1 as decile
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

proc gplot data=cum_lift;
title ‘Cumulative Lift Chart’;
symbol i=spline;
plot cum_lift*decile /grid;
run;
quit;

