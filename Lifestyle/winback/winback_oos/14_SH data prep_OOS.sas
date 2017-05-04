


/*Getting Splash Transactions of Lifestyle winback customer base (Model)*/

data spdtmp7.VB_WB_OOS_LS_SH_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_OOS_LS_TXN;
where txn_dt_wid<=20150131 and LMG_concept_name="Splash" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/


/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_WB_OOS_LS_SH_TXN (compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_SH, 
           count(distinct date) as no_of_visits_SH, 
           count(distinct invoice_number) as no_of_txn_SH, 
           max(date) as end_date_SH, 
           min(date) as start_date_SH,
           count(distinct item_code) as distinct_prod_SH, 
           sum(units) as total_unit_SH, 
           sum(base_points_accrued) as total_points_SH ,
           sum(retail_cost_1_aed) as sum_cost_1_SH,
           sum(retail_cost_2_aed) as sum_cost_2_SH
		   
from spdtmp7.VB_WB_OOS_LS_SH_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_WB_OOS_LS_SH_TXN(compress=yes);
set spdtmp7.VB_WB_OOS_LS_SH_TXN;
format start_date_SH ddmmyys10.;
format end_date_SH ddmmyys10.;
recency_SH=intck('day',end_date_SH,'31Jan2015'd);
active_time_SH=intck('day',start_date_SH,end_date_SH);
avg_units_per_txn_SH = total_unit_SH/no_of_txn_SH;
avg_units_per_visit_SH =  total_unit_SH/no_of_visits_SH;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle winback customer base*/

data spdtmp7.VB_WB_OOS_LS_SH3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_OOS_LS_TXN;
where txn_Dt_wid>=20141101 and txn_dt_wid<=20150131 and LMG_concept_name="Splash" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_OOS_LS_SH3_TXN(compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_SH3, 
           count(distinct date) as no_of_visits_SH3, 
           count(distinct invoice_number) as no_of_txn_SH3, 
           max(date) as end_date_SH3, 
           min(date) as start_date_SH3,
           count(distinct item_code) as distinct_prod_SH3, 
           sum(units) as total_unit_SH3, 
           sum(base_points_accrued) as total_points_SH3 ,
           sum(retail_cost_1_aed) as sum_cost_1_SH3,
           sum(retail_cost_2_aed) as sum_cost_2_SH3

from spdtmp7.VB_WB_OOS_LS_SH3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_WB_OOS_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_WB_OOS_LS_SH3_TXN(compress=yes);
set spdtmp7.VB_WB_OOS_LS_SH3_TXN;
format start_date_SH3 ddmmyys10.;
format end_date_SH3 ddmmyys10.;
recency_SH3=intck('day',end_date_SH3,'31Jan2015'd);
active_time_SH3=intck('day',start_date_SH3,end_date_SH3);
avg_units_per_txn_SH3 = total_unit_SH3/no_of_txn_SH3;
avg_units_per_visit_SH3 =  total_unit_SH3/no_of_visits_SH3;
run;

/*6months*/


data spdtmp7.VB_WB_OOS_LS_SH6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_OOS_LS_TXN;
where txn_Dt_wid>=20140801 and txn_dt_wid<=20150131 and LMG_concept_name="Splash" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_OOS_LS_SH6_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_SH6, 
           count(distinct date) as no_of_visits_SH6, 
           count(distinct invoice_number) as no_of_txn_SH6, 
           max(date) as end_date_SH6, 
           min(date) as start_date_SH6,
           count(distinct item_code) as distinct_prod_SH6, 
           sum(units) as total_unit_SH6, 
           sum(base_points_accrued) as total_points_SH6,
		   sum(retail_cost_1_aed) as sum_cost_1_SH6,
		   sum(retail_cost_2_aed) as sum_cost_2_SH6 
from spdtmp7.VB_WB_OOS_LS_SH6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_WB_OOS_LS_SH6_TXN(compress=yes);
set spdtmp7.VB_WB_OOS_LS_SH6_TXN;
format start_date_SH6 ddmmyys10.;
format end_date_SH6 ddmmyys10.;
recency_SH6=intck('day',end_date_SH6,'31Jan2015'd);
active_time_SH6=intck('day',start_date_SH6,end_date_SH6);
avg_units_per_txn_SH6 = total_unit_SH6/no_of_txn_SH6;
avg_units_per_visit_SH6 =  total_unit_SH6/no_of_visits_SH6;
run;

/*9months*/

data spdtmp7.VB_WB_OOS_LS_SH9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_OOS_LS_TXN;
where txn_Dt_wid>=20140501 and txn_dt_wid<=20150131 and LMG_concept_name="Splash" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_WB_OOS_LS_SH9_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_SH9, 
           count(distinct date) as no_of_visits_SH9, 
           count(distinct invoice_number) as no_of_txn_SH9, 
           max(date) as end_date_SH9, 
           min(date) as start_date_SH9,
           count(distinct item_code) as distinct_prod_SH9, 
           sum(units) as total_unit_SH9, 
           sum(base_points_accrued) as total_points_SH9 ,
           sum(retail_cost_1_aed) as sum_cost_1_SH9,
           sum(retail_cost_2_aed) as sum_cost_2_SH9

from spdtmp7.VB_WB_OOS_LS_SH9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_WB_OOS_LS_SH9_TXN(compress=yes);
set spdtmp7.VB_WB_OOS_LS_SH9_TXN;
format start_date_SH9 ddmmyys10.;
format end_date_SH9 ddmmyys10.;
recency_SH9=intck('day',end_date_SH9,'31Jan2015'd);
active_time_SH9=intck('day',start_date_SH9,end_date_SH9);
avg_units_per_txn_SH9 = total_unit_SH9/no_of_txn_Sh9;
avg_units_per_visit_SH9 =  total_unit_SH9/no_of_visits_SH9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_WB_OOS_LS_SH_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_WB_OOS_LS_SH_TXN a 
left join  spdtmp7.VB_WB_OOS_LS_SH3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_WB_OOS_LS_SH6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_WB_OOS_LS_SH9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_WB_OOS_LS_SH3_TXN;
proc delete data=spdtmp7.VB_WB_OOS_LS_SH6_TXN;
proc delete data=spdtmp7.VB_WB_OOS_LS_SH9_TXN;
