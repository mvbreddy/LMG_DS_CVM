


/*Getting Home Box Transactions of Lifestyle winback customer base (Model)*/

data spdtmp7.VB_AQ_LS_HB_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_LS_TXN;
where txn_dt_wid<=20170131 and txn_dt_wid >= 20160201 and LMG_concept_name="Home Box" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/

/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_AQ_LS_HB_TXN (compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_HB, 
           count(distinct date) as no_of_visits_HB, 
           count(distinct invoice_number) as no_of_txn_HB, 
           max(date) as end_date_HB, 
           min(date) as start_date_HB,
           count(distinct item_code) as distinct_prod_HB, 
           sum(units) as total_unit_HB, 
           sum(base_points_accrued) as total_points_HB ,
           sum(retail_cost_1_aed) as sum_cost_1_HB,
           sum(retail_cost_2_aed) as sum_cost_2_HB
		   
from spdtmp7.VB_AQ_LS_HB_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_AQ_LS_HB_TXN(compress=yes);
set spdtmp7.VB_AQ_LS_HB_TXN;
format start_date_HB ddmmyys10.;
format end_date_HB ddmmyys10.;
recency_HB=intck('day',end_date_HB,'31Jan2017'd);
active_time_HB=intck('day',start_date_HB,end_date_HB);
avg_units_per_txn_HB = total_unit_HB/no_of_txn_HB;
avg_units_per_visit_HB =  total_unit_HB/no_of_visits_HB;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle winback customer base*/

data spdtmp7.VB_AQ_LS_HB3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_LS_TXN;
where txn_Dt_wid>=20161101 and txn_dt_wid<=20170131 and LMG_concept_name="Home Box" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_LS_HB3_TXN(compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_HB3, 
           count(distinct date) as no_of_visits_HB3, 
           count(distinct invoice_number) as no_of_txn_HB3, 
           max(date) as end_date_HB3, 
           min(date) as start_date_HB3,
           count(distinct item_code) as distinct_prod_HB3, 
           sum(units) as total_unit_HB3, 
           sum(base_points_accrued) as total_points_HB3 ,
           sum(retail_cost_1_aed) as sum_cost_1_HB3,
           sum(retail_cost_2_aed) as sum_cost_2_HB3

from spdtmp7.VB_AQ_LS_HB3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_AQ_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_AQ_LS_HB3_TXN(compress=yes);
set spdtmp7.VB_AQ_LS_HB3_TXN;
format start_date_HB3 ddmmyys10.;
format end_date_HB3 ddmmyys10.;
recency_HB3=intck('day',end_date_HB3,'31Jan2017'd);
active_time_HB3=intck('day',start_date_HB3,end_date_HB3);
avg_units_per_txn_HB3 = total_unit_HB3/no_of_txn_HB3;
avg_units_per_visit_HB3 =  total_unit_HB3/no_of_visits_HB3;
run;

/*6months*/


data spdtmp7.VB_AQ_LS_HB6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_LS_TXN;
where txn_Dt_wid>=20160801 and txn_dt_wid<=20170131 and LMG_concept_name="Home Box" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_LS_HB6_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_HB6, 
           count(distinct date) as no_of_visits_HB6, 
           count(distinct invoice_number) as no_of_txn_HB6, 
           max(date) as end_date_HB6, 
           min(date) as start_date_HB6,
           count(distinct item_code) as distinct_prod_HB6, 
           sum(units) as total_unit_HB6, 
           sum(base_points_accrued) as total_points_HB6,
		   sum(retail_cost_1_aed) as sum_cost_1_HB6,
		   sum(retail_cost_2_aed) as sum_cost_2_HB6 
from spdtmp7.VB_AQ_LS_HB6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_AQ_LS_HB6_TXN(compress=yes);
set spdtmp7.VB_AQ_LS_HB6_TXN;
format start_date_HB6 ddmmyys10.;
format end_date_HB6 ddmmyys10.;
recency_HB6=intck('day',end_date_HB6,'31Jan2017'd);
active_time_HB6=intck('day',start_date_HB6,end_date_HB6);
avg_units_per_txn_HB6 = total_unit_HB6/no_of_txn_HB6;
avg_units_per_visit_HB6 =  total_unit_HB6/no_of_visits_HB6;
run;

/*9months*/

data spdtmp7.VB_AQ_LS_HB9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_LS_TXN;
where txn_Dt_wid>=20160501 and txn_dt_wid<=20170131 and LMG_concept_name="Home Box" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_AQ_LS_HB9_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_HB9, 
           count(distinct date) as no_of_visits_HB9, 
           count(distinct invoice_number) as no_of_txn_HB9, 
           max(date) as end_date_HB9, 
           min(date) as start_date_HB9,
           count(distinct item_code) as distinct_prod_HB9, 
           sum(units) as total_unit_HB9, 
           sum(base_points_accrued) as total_points_HB9 ,
           sum(retail_cost_1_aed) as sum_cost_1_HB9,
           sum(retail_cost_2_aed) as sum_cost_2_HB9

from spdtmp7.VB_AQ_LS_HB9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_AQ_LS_HB9_TXN(compress=yes);
set spdtmp7.VB_AQ_LS_HB9_TXN;
format start_date_HB9 ddmmyys10.;
format end_date_HB9 ddmmyys10.;
recency_HB9=intck('day',end_date_HB9,'31Jan2017'd);
active_time_HB9=intck('day',start_date_HB9,end_date_HB9);
avg_units_per_txn_HB9 = total_unit_HB9/no_of_txn_HB9;
avg_units_per_visit_HB9 =  total_unit_HB9/no_of_visits_HB9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_AQ_LS_HB_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_AQ_LS_HB_TXN a 
left join  spdtmp7.VB_AQ_LS_HB3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_AQ_LS_HB6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_AQ_LS_HB9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_AQ_LS_HB3_TXN;
proc delete data=spdtmp7.VB_AQ_LS_HB6_TXN;
proc delete data=spdtmp7.VB_AQ_LS_HB9_TXN;
