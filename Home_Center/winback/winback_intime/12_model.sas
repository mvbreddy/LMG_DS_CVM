
data spdtmp7.sd_hc_tempwb1(compress=yes);
set spdtmp7.sd_hc_txn_wb;
n=ranuni(8);
proc sort data=spdtmp7.sd_hc_tempwb1(compress=yes);
  by n;
  data spdtmp7.sd_hc_trainingwb1(compress=yes) spdtmp7.sd_hc_testingwb1(compress=yes);
   set spdtmp7.sd_hc_tempwb1 nobs=nobs;
   if _n_<=.25*nobs then output spdtmp7.sd_hc_trainingwb1;
    else output spdtmp7.sd_hc_testingwb1;
   run;
proc means data=spdtmp7.sd_hc_trainingwb;
run;

%let Indep_var =
sum_revenue_aed_lmgcy 
no_of_visits_lmgcy 
no_of_txn_lmgcy 
 
distinct_prod_lmgcy 
total_unit_lmgcy 
total_points_lmgcy 
sum_cost_1_lmgcy 
sum_cost_2_lmgcy 
recency_lmgcy 
active_time_lmgcy 
avg_units_per_txn_lmgcy 
avg_units_per_visit_lmgcy 
sum_revenue_aed_lmgcy3 
no_of_visits_lmgcy3 
no_of_txn_lmgcy3 
 
distinct_prod_lmgcy3 
total_unit_lmgcy3 
total_points_lmgcy3 
sum_cost_1_lmgcy3 
sum_cost_2_lmgcy3 
distinct_concept_lmgcy3 
recency_lmgcy3 
active_time_lmgcy3 
avg_units_per_txn_lmgcy3 
avg_units_per_visit_lmgcy3 
sum_revenue_aed_lmgcy6 
no_of_visits_lmgcy6 
no_of_txn_lmgcy6 
 
distinct_prod_lmgcy6 
total_unit_lmgcy6 
total_points_lmgcy6 
sum_cost_1_lmgcy6 
sum_cost_2_lmgcy6 
distinct_concept_lmgcy6 
recency_lmgcy6 
active_time_lmgcy6 
avg_units_per_txn_lmgcy6 
avg_units_per_visit_lmgcy6 
sum_revenue_aed_lmgcy9 
no_of_visits_lmgcy9 
no_of_txn_lmgcy9 
distinct_prod_lmgcy9 
total_unit_lmgcy9 
total_points_lmgcy9 
sum_cost_1_lmgcy9 
sum_cost_2_lmgcy9 
distinct_concept_lmgcy9 
recency_lmgcy9 
active_time_lmgcy9 
avg_units_per_txn_lmgcy9 
avg_units_per_visit_lmgcy9 
sum_revenue_aed_lscy 
no_of_visits_lscy 
no_of_txn_lscy 

distinct_prod_lscy 
total_unit_lscy 
total_points_lscy 
sum_cost_1_lscy 
sum_cost_2_lscy 
recency_lscy 
active_time_lscy 
avg_units_per_txn_lscy 
avg_units_per_visit_lscy 
sum_revenue_aed_hbcy 
no_of_visits_hbcy 
no_of_txn_hbcy 

distinct_prod_hbcy 
total_unit_hbcy 
sum_cost_1_hbcy 
sum_cost_2_hbcy 
total_points_hbcy 
recency_hbcy 
active_time_hbcy 
avg_units_per_txn_hbcy 
avg_units_per_visit_hbcy 
sum_revenue_aed_emcy 
no_of_visits_emcy 
no_of_txn_emcy 

distinct_prod_emcy 
total_unit_emcy 
sum_cost_1_emcy 
sum_cost_2_emcy 
total_points_emcy 
recency_emcy 
active_time_emcy 
avg_units_per_txn_emcy 
avg_units_per_visit_emcy 
sum_revenue_aed_bscy 
no_of_visits_bscy 
no_of_txn_bscy 

distinct_prod_bscy 
total_unit_bscy 
sum_cost_1_bscy 
sum_cost_2_bscy 
total_points_bscy 
recency_bscy 
active_time_bscy 
avg_units_per_txn_bscy 
avg_units_per_visit_bscy 
perc_revenue_lscy 
perc_revenue_bscy 
perc_revenue_emcy 
perc_revenue_hbcy 
perc_unit_lscy 
perc_unit_bscy 
perc_unit_emcy 
perc_unit_hbcy 






 
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
RFM_1
RFM_2
RFM_3
RFM_4
RFM_5
RFM_6

active_time
active_time_3
active_time_6
active_time_9
active_time_bs
active_time_em
active_time_hb
active_time_lmg
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
atv_3
atv_6
atv_9
atv_bs
atv_em
atv_hb
atv_lmg
atv_lmg3
atv_lmg6
atv_lmg9
atv_ls
avg_days_dif
total_points
total_points_3
total_points_6
total_points_9
total_points_bs
total_points_em
total_points_hb
total_points_lmg
total_points_lmg3
total_points_lmg6
total_points_lmg9
total_points_ls
avg_units_per_txn
avg_units_per_txn_3
avg_units_per_txn_6
avg_units_per_txn_9
avg_units_per_txn_bs
avg_units_per_txn_em
avg_units_per_txn_hb
avg_units_per_txn_lmg
avg_units_per_txn_lmg3
avg_units_per_txn_lmg6
avg_units_per_txn_lmg9
avg_units_per_txn_ls
avg_units_per_visit
avg_units_per_visit_3
avg_units_per_visit_6
avg_units_per_visit_9
avg_units_per_visit_bs
avg_units_per_visit_em
avg_units_per_visit_hb
avg_units_per_visit_lmg
avg_units_per_visit_lmg3
avg_units_per_visit_lmg6
avg_units_per_visit_lmg9
avg_units_per_visit_ls
distinct_concept
distinct_concept_lmg3
distinct_concept_lmg6
distinct_concept_lmg9
distinct_prod
distinct_prod_3
distinct_prod_6
distinct_prod_9
distinct_prod_bs
distinct_prod_em
distinct_prod_hb
distinct_prod_lmg
distinct_prod_lmg3
distinct_prod_lmg6
distinct_prod_lmg9
distinct_prod_ls


no_of_txn
no_of_txn_3
no_of_txn_6
no_of_txn_9
no_of_txn_300
no_of_txn_301
no_of_txn_302
no_of_txn_303
no_of_txn_304
no_of_txn_305
no_of_txn_306
no_of_txn_307
no_of_txn_308
no_of_txn_309
no_of_txn_310
no_of_txn_311
no_of_txn_312
no_of_txn_bs
no_of_txn_em
no_of_txn_furniture
no_of_txn_hb
no_of_txn_household
no_of_txn_kids
no_of_txn_lmg
no_of_txn_lmg3
no_of_txn_lmg6
no_of_txn_lmg9
no_of_txn_ls
no_of_visits
no_of_visits_3
no_of_visits_6
no_of_visits_9
no_of_visits_bs
no_of_visits_em
no_of_visits_furniture
no_of_visits_hb
no_of_visits_household
no_of_visits_kids
no_of_visits_lmg
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
recency_3
recency_6
recency_9
recency_bs
recency_em
recency_hb
recency_lmg
recency_lmg3
recency_lmg6
recency_lmg9
recency_ls
revenue_AED_300
revenue_AED_301
revenue_AED_302
revenue_AED_303
revenue_AED_304
revenue_AED_305
revenue_AED_306
revenue_AED_307
revenue_AED_308
revenue_AED_309
revenue_AED_310
revenue_AED_311
revenue_AED_312
revenue_AED_furniture
revenue_Aed_Household
revenue_Aed_kids
sum_cost_1
sum_cost_2
sum_cost_1_3
sum_cost_1_6
sum_cost_1_9
sum_cost_1_LMG
sum_cost_1_bs
sum_cost_1_em
sum_cost_1_hb
sum_cost_1_lmg3
sum_cost_1_lmg6
sum_cost_1_lmg9
sum_cost_1_ls
sum_cost_2_3
sum_cost_2_6
sum_cost_2_9
sum_cost_2_LMG
sum_cost_2_bs
sum_cost_2_em
sum_cost_2_hb
sum_cost_2_lmg3
sum_cost_2_lmg6
sum_cost_2_lmg9
sum_cost_2_ls
sum_revenue_aed
sum_revenue_aed_3
sum_revenue_aed_6
sum_revenue_aed_9
sum_revenue_aed_bs
sum_revenue_aed_em
sum_revenue_aed_hb
sum_revenue_aed_lmg
sum_revenue_aed_lmg3
sum_revenue_aed_lmg6
sum_revenue_aed_lmg9
sum_revenue_aed_ls
total_unit
total_unit_3
total_unit_6
total_unit_9
total_unit_bs
total_unit_em
total_unit_hb
total_unit_lmg
total_unit_lmg3
total_unit_lmg6
total_unit_lmg9
total_unit_ls
total_units_furniture
total_units_household
total_units_kids
units_300
units_301
units_302
units_303
units_304
units_305
units_306
units_307
units_308
units_309
units_310
units_311
units_312;



proc reg data=spdtmp7.sd_hc_trainingwb;
model purchase_flag= &Indep_var2. /vif;
run;


%let indep_var2=

MC_return_revenue_aed
MC_L9m_return_units
recency_lmgcy
Expat_Arab_nat_dummy
ISC_nat_dummy
LMG_EFFECTIVE_POINTS
Local_nat_dummy
Lstg_sgmnt_4
Lstg_sgmnt_7
RFM_2
RFM_4
RFM_5
age_grp_5_dummy
age_grp_6_dummy
no_of_txn_3
no_of_txn_310
active_time_3_sq
no_of_visits_lmgcy6_sq
perc_unit_lscy_log
no_of_txn_306_log
no_of_visits_furniture
perc_unit_hbcy_srt
active_time_srt
FAMILY_REV_AED


no_of_txn_Fas 

revenue_AED_furhb 

;


ODS graphics on;
proc logistic data = spdtmp7.sd_hc_trainingwb plots=ROC  
     outest = spdtmp7.sd_hc_sigvarwb    /* this has list of Significant Vars*/
     outmodel = spdtmp7.sd_hc_scoringwb  /* this is used for scoring, also has significant variables */
     descending  ;
model  purchase_flag =  &Indep_var2. /  lackfit rsquare 
     ctable outroc=ROC_sd;
output out = spdtmp7.sd_hc_modelwb    p = pred_RESPONSE ;
roc; 
run;
ods graphics off;



data spdtmp7.sd_hc_model_confusionwb(compress=yes);
set spdtmp7.sd_hc_modelwb;

if pred_response >= 0.0395 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.sd_hc_model_confusionwb;
        table purchase_flag * prediction ;
run;





proc logistic  
     inmodel = spdtmp7.sd_hc_scoringwb;
     score data = spdtmp7.sd_hc_testingwb
     Out  = spdtmp7.sd_hc_test_scorewb;
run;    

data spdtmp7.sd_hc_model_confusionwb;
set spdtmp7.sd_hc_test_scorewb;

if P_1 >= 0.0395 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.sd_hc_model_confusionwb;
        table purchase_flag * prediction ;
run;



proc rank data=spdtmp7.sd_hc_modelwb out=deciles ties=low
descending groups=10;
var pred_RESPONSE;
ranks decile;
run;

proc sql;
select sum(purchase_flag) into: total_hits
from spdtmp7.sd_hc_modelwb
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


