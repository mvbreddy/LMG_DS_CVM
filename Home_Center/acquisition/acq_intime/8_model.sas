
data spdtmp7.sd_hc_tempac1(compress=yes);
set spdtmp7.sd_hc_txn_ac;
n=ranuni(8);
proc sort data=spdtmp7.sd_hc_tempac1(compress=yes);
  by n;
  data spdtmp7.sd_hc_trainingac1(compress=yes) spdtmp7.sd_hc_testingac1(compress=yes);
   set spdtmp7.sd_hc_tempac1 nobs=nobs;
   if _n_<=.70*nobs then output spdtmp7.sd_hc_trainingac1;
    else output spdtmp7.sd_hc_testingac1;
   run;



   data spdtmp7.sd_hc_tempac2(compress=yes);
set spdtmp7.sd_hc_txn_ac;
n=ranuni(8);
proc sort data=spdtmp7.sd_hc_tempac2(compress=yes);
  by n;
  data spdtmp7.sd_hc_trainingac2(compress=yes) spdtmp7.sd_hc_testingac2(compress=yes);
   set spdtmp7.sd_hc_tempac2 nobs=nobs;
   if _n_<=.25*nobs then output spdtmp7.sd_hc_trainingac2;
    else output spdtmp7.sd_hc_testingac2;
   run;

   proc means data=spdtmp7.sd_hc_trainingac1 ;
   run;

%let Indep_var =



Expat_Arab_nat_dummy
Gender_M_dummy
ISC_nat_dummy
LMG_EFFECTIVE_POINTS

Local_nat_dummy
Lstg_sgmnt_1
Lstg_sgmnt_2
Lstg_sgmnt_3
Lstg_sgmnt_4
Lstg_sgmnt_5
Lstg_sgmnt_6
Lstg_sgmnt_7

active_time
active_time_bs
active_time_em
active_time_hb
active_time_lmg3
active_time_lmg6
active_time_lmg9
active_time_ls
age_grp_1_dummy
age_grp_2_dummy
age_grp_3_dummy
age_grp_4_dummy
age_grp_5_dummy
age_grp_6_dummy
atv
atv_bs
atv_em
atv_hb
atv_lmg3
atv_lmg6
atv_lmg9
atv_ls
avg_days_dif
avg_units_per_txn
avg_units_per_txn_bs
avg_units_per_txn_em
avg_units_per_txn_hb
avg_units_per_txn_lmg3
avg_units_per_txn_lmg6
avg_units_per_txn_lmg9
avg_units_per_txn_ls
avg_units_per_visit
avg_units_per_visit_bs
avg_units_per_visit_em
avg_units_per_visit_hb
avg_units_per_visit_lmg3
avg_units_per_visit_lmg6
avg_units_per_visit_lmg9
avg_units_per_visit_ls
distinct_concept_lmg3
distinct_concept_lmg6
distinct_concept_lmg9
distinct_prod
distinct_prod_bs
distinct_prod_em
distinct_prod_hb
distinct_prod_lmg3
distinct_prod_lmg6
distinct_prod_lmg9
distinct_prod_ls

no_of_txn
no_of_txn_bs
no_of_txn_em
no_of_txn_hb
no_of_txn_lmg3
no_of_txn_lmg6
no_of_txn_lmg9
no_of_txn_ls
no_of_visits
no_of_visits_bs
no_of_visits_em
no_of_visits_hb
no_of_visits_lmg3
no_of_visits_lmg6
no_of_visits_lmg9
no_of_visits_ls
perc_revenue_bs
perc_revenue_em
perc_revenue_hb
perc_revenue_ls
perc_unit_bs
perc_unit_em
perc_unit_hb
perc_unit_ls

recency
recency_bs
recency_em
recency_hb
recency_lmg3
recency_lmg6
recency_lmg9
recency_ls
sum_cost_1
sum_cost_2
sum_cost_1_bs
sum_cost_1_em
sum_cost_1_hb
sum_cost_1_lmg3
sum_cost_1_lmg6
sum_cost_1_lmg9
sum_cost_1_ls
sum_cost_2_bs
sum_cost_2_em
sum_cost_2_hb
sum_cost_2_lmg3
sum_cost_2_lmg6
sum_cost_2_lmg9
sum_cost_2_ls
sum_revenue_aed
sum_revenue_aed_bs
sum_revenue_aed_em
sum_revenue_aed_hb
sum_revenue_aed_lmg3
sum_revenue_aed_lmg6
sum_revenue_aed_lmg9
sum_revenue_aed_ls
total_points
total_points_bs
total_points_em
total_points_hb
total_points_lmg3
total_points_lmg6
total_points_lmg9
total_points_ls
total_unit
total_unit_bs
total_unit_em
total_unit_hb
total_unit_lmg3
total_unit_lmg6
total_unit_lmg9
total_unit_ls
BABY_REV_AED 
FEMALE_REV_AED 
KIDS_REV_AED 
MALE_REV_AED 
UNCLASSIFIED_REV_AED 
FAMILY_REV_AED 
TEEN_REV_AED 
sum_revenue_aed_sp 
no_of_visits_sp 
no_of_txn_sp 
end_date_sp 
start_date_sp 
distinct_prod_sp 
total_unit_sp 
total_points_sp 
sum_cost_1_sp 
sum_cost_2_sp 
recency_sp 
active_time_sp 
avg_units_per_txn_sp 
avg_units_per_visit_sp 
sum_revenue_aed_sm 
no_of_visits_sm 
no_of_txn_sm 
end_date_sm 
start_date_sm 
distinct_prod_sm 
total_unit_sm 
total_points_sm 
sum_cost_1_sm 
sum_cost_2_sm 
recency_sm 
active_time_sm 
avg_units_per_txn_sm 
avg_units_per_visit_sm 
sum_revenue_aed_mx 
no_of_visits_mx 
no_of_txn_mx 
end_date_mx 
start_date_mx 
distinct_prod_mx 
total_unit_mx 
total_points_mx 
sum_cost_1_mx 
sum_cost_2_mx 
recency_mx 
active_time_mx 
avg_units_per_txn_mx 
avg_units_per_visit_mx 
revenue_AED_furhb 
revenue_Aed_hwhb 
revenue_Aed_kidshb 
revenue_Aed_mhnthb 
total_units_furhb 
total_units_hwhb 
total_units_kidshb 
total_units_mhnthb 
no_of_txn_furhb 
no_of_txn_hwhb 
no_of_txn_kidshb 
no_of_txn_mhnthb 
no_of_visits_furhb 
no_of_visits_hwhb 
no_of_visits_kidshb 
no_of_visits_mhnthb 
revenue_AED_Beauty 
revenue_Aed_TG 
revenue_Aed_Fas 
revenue_Aed_HF 
revenue_Aed_HFrag 
total_units_Beauty 
total_units_TG 
total_units_Fas 
total_units_HF 
total_units_HFrag 
no_of_txn_Beauty 
no_of_txn_TG 
no_of_txn_Fas 
no_of_txn_HF 
no_of_txn_HFrag 
no_of_visits_Beauty 
no_of_visits_TG 
no_of_visits_Fas 
no_of_visits_HF 
no_of_visits_HFrag 
revenue_AED_ba 
revenue_Aed_bna 
revenue_Aed_cb 
revenue_Aed_cg 
revenue_Aed_ce 
revenue_Aed_others 
total_units_ba 
total_units_bna 
total_units_cb 
total_units_cg 
total_units_ce 
total_units_others 
no_of_txn_ba 
no_of_txn_bna 
no_of_txn_cb 
no_of_txn_cg 
no_of_txn_ce 
no_of_txn_others 
no_of_visits_ba 
no_of_visits_bna 
no_of_visits_cb 
no_of_visits_cg 
no_of_visits_ce 


;



%let Indep_var_1 =

Expat_Arab_nat_dummy
Gender_M_dummy
ISC_nat_dummy
LMG_EFFECTIVE_POINTS
Local_nat_dummy
Lstg_sgmnt_1
Lstg_sgmnt_2
Lstg_sgmnt_3
Lstg_sgmnt_4
Lstg_sgmnt_5
/*active_time_lmg3*/
age_grp_5_dummy
age_grp_6_dummy
avg_units_per_visit_lmg6
/*distinct_concept_lmg3*/
/*distinct_prod_lmg6*/
/*no_of_visits_ls*/
perc_unit_hb
perc_unit_ls
recency
recency_hb
/*sum_cost_2_lmg3*/
sum_revenue_aed_hb
sum_revenue_aed_ls
/*KIDS_REV_AED*/
/*UNCLASSIFIED_REV_AED*/
FAMILY_REV_AED
/*sum_revenue_aed_sp*/
/*no_of_visits_sp*/


/*revenue_Aed_kidshb*/
/*total_units_TG*/
no_of_txn_HF
/*no_of_txn_cg*/
no_of_txn_others


;

proc reg data=spdtmp7.sd_hc_testingac1;
model purchase_flag= &Indep_var_1. /vif;
run;




ODS graphics on;
proc logistic data = spdtmp7.sd_hc_trainingac1 plots=ROC  
     outest = spdtmp7.sd_hc_sigvarac    /* this has list of Significant Vars*/
     outmodel = spdtmp7.sd_hc_scoringac  /* this is used for scoring, also has significant variables */
     descending  ;
model  purchase_flag =  &Indep_var_1. /   lackfit rsquare 
     ctable outroc=ROC_sd;
output out = spdtmp7.sd_hc_modelac    p = pred_RESPONSE ;
roc; 
run;
ods graphics off;



data spdtmp7.sd_hc_model_confusionac(compress=yes);
set spdtmp7.sd_hc_modelac;

if pred_response >= 0.0106 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.sd_hc_model_confusionac;
        table purchase_flag * prediction ;
run;





proc logistic  
     inmodel = spdtmp7.sd_hc_scoringac;
     score data = spdtmp7.sd_hc_testingac1
     Out  = spdtmp7.sd_hc_test_scoreac;
run;    

data spdtmp7.sd_hc_model_confusionac;
set spdtmp7.sd_hc_test_scoreac;

if P_1 >= 0.0106 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.sd_hc_model_confusionac;
        table purchase_flag * prediction ;
run;



proc rank data=spdtmp7.sd_hc_modelac out=deciles ties=low
descending groups=10;
var pred_RESPONSE;
ranks decile;
run;

proc sql;
select sum(purchase_flag) into: total_hits
from spdtmp7.sd_hc_modelac
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


proc contents data=spdtmp7.sd_hc_txn_acoos_cust;
run;

