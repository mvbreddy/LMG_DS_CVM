


/*Getting Shoemart Transactions of Lifestyle winback customer base (Model)*/

data spdtmp7.VB_AQ_LS_SM_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_LS_TXN;
where txn_dt_wid<=20170131 and txn_dt_wid >= 20160201 and LMG_concept_name="Shoemart" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/

/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_AQ_LS_SM_TXN (compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_SM, 
           count(distinct date) as no_of_visits_SM, 
           count(distinct invoice_number) as no_of_txn_SM, 
           max(date) as end_date_SM, 
           min(date) as start_date_SM,
           count(distinct item_code) as distinct_prod_SM, 
           sum(units) as total_unit_SM, 
           sum(base_points_accrued) as total_points_SM ,
           sum(retail_cost_1_aed) as sum_cost_1_SM,
           sum(retail_cost_2_aed) as sum_cost_2_SM
		   
from spdtmp7.VB_AQ_LS_SM_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_AQ_LS_SM_TXN(compress=yes);
set spdtmp7.VB_AQ_LS_SM_TXN;
format start_date_SM ddmmyys10.;
format end_date_SM ddmmyys10.;
recency_SM=intck('day',end_date_SM,'31Jan2017'd);
active_time_SM=intck('day',start_date_SM,end_date_SM);
avg_units_per_txn_SM = total_unit_SM/no_of_txn_SM;
avg_units_per_visit_SM =  total_unit_SM/no_of_visits_SM;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle winback customer base*/

data spdtmp7.VB_AQ_LS_SM3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_LS_TXN;
where txn_Dt_wid>=20161101 and txn_dt_wid<=20170131 and LMG_concept_name="Shoemart" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_LS_SM3_TXN(compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_SM3, 
           count(distinct date) as no_of_visits_SM3, 
           count(distinct invoice_number) as no_of_txn_SM3, 
           max(date) as end_date_SM3, 
           min(date) as start_date_SM3,
           count(distinct item_code) as distinct_prod_SM3, 
           sum(units) as total_unit_SM3, 
           sum(base_points_accrued) as total_points_SM3 ,
           sum(retail_cost_1_aed) as sum_cost_1_SM3,
           sum(retail_cost_2_aed) as sum_cost_2_SM3

from spdtmp7.VB_AQ_LS_SM3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_AQ_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_AQ_LS_SM3_TXN(compress=yes);
set spdtmp7.VB_AQ_LS_SM3_TXN;
format start_date_SM3 ddmmyys10.;
format end_date_SM3 ddmmyys10.;
recency_SM3=intck('day',end_date_SM3,'31Jan2017'd);
active_time_SM3=intck('day',start_date_SM3,end_date_SM3);
avg_units_per_txn_SM3 = total_unit_SM3/no_of_txn_SM3;
avg_units_per_visit_SM3 =  total_unit_SM3/no_of_visits_SM3;
run;

/*6months*/


data spdtmp7.VB_AQ_LS_SM6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_LS_TXN;
where txn_Dt_wid>=20160801 and txn_dt_wid<=20170131 and LMG_concept_name="Shoemart" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_LS_SM6_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_SM6, 
           count(distinct date) as no_of_visits_SM6, 
           count(distinct invoice_number) as no_of_txn_SM6, 
           max(date) as end_date_SM6, 
           min(date) as start_date_SM6,
           count(distinct item_code) as distinct_prod_SM6, 
           sum(units) as total_unit_SM6, 
           sum(base_points_accrued) as total_points_SM6,
		   sum(retail_cost_1_aed) as sum_cost_1_SM6,
		   sum(retail_cost_2_aed) as sum_cost_2_SM6 
from spdtmp7.VB_AQ_LS_SM6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_AQ_LS_SM6_TXN(compress=yes);
set spdtmp7.VB_AQ_LS_SM6_TXN;
format start_date_SM6 ddmmyys10.;
format end_date_SM6 ddmmyys10.;
recency_SM6=intck('day',end_date_SM6,'31Jan2017'd);
active_time_SM6=intck('day',start_date_SM6,end_date_SM6);
avg_units_per_txn_SM6 = total_unit_SM6/no_of_txn_SM6;
avg_units_per_visit_SM6 =  total_unit_SM6/no_of_visits_SM6;
run;

/*9months*/

data spdtmp7.VB_AQ_LS_SM9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_LS_TXN;
where txn_Dt_wid>=20160501 and txn_dt_wid<=20170131 and LMG_concept_name="Shoemart" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_AQ_LS_SM9_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_SM9, 
           count(distinct date) as no_of_visits_SM9, 
           count(distinct invoice_number) as no_of_txn_SM9, 
           max(date) as end_date_SM9, 
           min(date) as start_date_SM9,
           count(distinct item_code) as distinct_prod_SM9, 
           sum(units) as total_unit_SM9, 
           sum(base_points_accrued) as total_points_SM9 ,
           sum(retail_cost_1_aed) as sum_cost_1_SM9,
           sum(retail_cost_2_aed) as sum_cost_2_SM9

from spdtmp7.VB_AQ_LS_SM9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_AQ_LS_SM9_TXN(compress=yes);
set spdtmp7.VB_AQ_LS_SM9_TXN;
format start_date_SM9 ddmmyys10.;
format end_date_SM9 ddmmyys10.;
recency_SM9=intck('day',end_date_SM9,'31Jan2017'd);
active_time_SM9=intck('day',start_date_SM9,end_date_SM9);
avg_units_per_txn_SM9 = total_unit_SM9/no_of_txn_SM9;
avg_units_per_visit_SM9 =  total_unit_SM9/no_of_visits_SM9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_AQ_LS_SM_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_AQ_LS_SM_TXN a 
left join  spdtmp7.VB_AQ_LS_SM3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_AQ_LS_SM6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_AQ_LS_SM9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_AQ_LS_SM3_TXN;
proc delete data=spdtmp7.VB_AQ_LS_SM6_TXN;
proc delete data=spdtmp7.VB_AQ_LS_SM9_TXN;
