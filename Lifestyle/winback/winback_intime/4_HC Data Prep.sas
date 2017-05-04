





/*Getting Home center Transactions of Lifestyle winback customer base (Model)*/

data spdtmp7.VB_WB_LS_HC_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_LS_TXN;
where txn_dt_wid<=20160131 and LMG_concept_name="Home center" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/


/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_WB_LS_HC_TXN (compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_HC, 
           count(distinct date) as no_of_visits_HC, 
           count(distinct invoice_number) as no_of_txn_HC, 
           max(date) as end_date_HC, 
           min(date) as start_date_HC,
           count(distinct item_code) as distinct_prod_HC, 
           sum(units) as total_unit_HC, 
           sum(base_points_accrued) as total_points_HC ,
           sum(retail_cost_1_aed) as sum_cost_1_HC,
           sum(retail_cost_2_aed) as sum_cost_2_HC
		   
from spdtmp7.VB_WB_LS_HC_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_WB_LS_HC_TXN(compress=yes);
set spdtmp7.VB_WB_LS_HC_TXN;
format start_date_HC ddmmyys10.;
format end_date_HC ddmmyys10.;
recency_HC=intck('day',end_date_HC,'31Jan2016'd);
active_time_HC=intck('day',start_date_HC,end_date_HC);
avg_units_per_txn_HC = total_unit_HC/no_of_txn_HC;
avg_units_per_visit_HC =  total_unit_HC/no_of_visits_HC;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle winback customer base*/

data spdtmp7.VB_WB_LS_HC3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_LS_TXN;
where txn_Dt_wid>=20151101 and txn_dt_wid<=20160131 and LMG_concept_name="Home center" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_LS_HC3_TXN(compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_HC3, 
           count(distinct date) as no_of_visits_HC3, 
           count(distinct invoice_number) as no_of_txn_HC3, 
           max(date) as end_date_HC3, 
           min(date) as start_date_HC3,
           count(distinct item_code) as distinct_prod_HC3, 
           sum(units) as total_unit_HC3, 
           sum(base_points_accrued) as total_points_HC3 ,
           sum(retail_cost_1_aed) as sum_cost_1_HC3,
           sum(retail_cost_2_aed) as sum_cost_2_HC3

from spdtmp7.VB_WB_LS_HC3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_WB_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_WB_LS_HC3_TXN(compress=yes);
set spdtmp7.VB_WB_LS_HC3_TXN;
format start_date_HC3 ddmmyys10.;
format end_date_HC3 ddmmyys10.;
recency_HC3=intck('day',end_date_HC3,'31Jan2016'd);
active_time_HC3=intck('day',start_date_HC3,end_date_HC3);
avg_units_per_txn_HC3 = total_unit_HC3/no_of_txn_HC3;
avg_units_per_visit_HC3 =  total_unit_HC3/no_of_visits_HC3;
run;

/*6months*/


data spdtmp7.VB_WB_LS_HC6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_LS_TXN;
where txn_Dt_wid>=20150801 and txn_dt_wid<=20160131 and LMG_concept_name="Home center" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_LS_HC6_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_HC6, 
           count(distinct date) as no_of_visits_HC6, 
           count(distinct invoice_number) as no_of_txn_HC6, 
           max(date) as end_date_HC6, 
           min(date) as start_date_HC6,
           count(distinct item_code) as distinct_prod_HC6, 
           sum(units) as total_unit_HC6, 
           sum(base_points_accrued) as total_points_HC6,
		   sum(retail_cost_1_aed) as sum_cost_1_HC6,
		   sum(retail_cost_2_aed) as sum_cost_2_HC6 
from spdtmp7.VB_WB_LS_HC6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_WB_LS_HC6_TXN(compress=yes);
set spdtmp7.VB_WB_LS_HC6_TXN;
format start_date_HC6 ddmmyys10.;
format end_date_HC6 ddmmyys10.;
recency_HC6=intck('day',end_date_HC6,'31Jan2016'd);
active_time_HC6=intck('day',start_date_HC6,end_date_HC6);
avg_units_per_txn_HC6 = total_unit_HC6/no_of_txn_HC6;
avg_units_per_visit_HC6 =  total_unit_HC6/no_of_visits_HC6;
run;

/*9months*/

data spdtmp7.VB_WB_LS_HC9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_LS_TXN;
where txn_Dt_wid>=20150501 and txn_dt_wid<=20160131 and LMG_concept_name="Home center" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_WB_LS_HC9_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_HC9, 
           count(distinct date) as no_of_visits_HC9, 
           count(distinct invoice_number) as no_of_txn_HC9, 
           max(date) as end_date_HC9, 
           min(date) as start_date_HC9,
           count(distinct item_code) as distinct_prod_HC9, 
           sum(units) as total_unit_HC9, 
           sum(base_points_accrued) as total_points_HC9 ,
           sum(retail_cost_1_aed) as sum_cost_1_HC9,
           sum(retail_cost_2_aed) as sum_cost_2_HC9

from spdtmp7.VB_WB_LS_HC9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_WB_LS_HC9_TXN(compress=yes);
set spdtmp7.VB_WB_LS_HC9_TXN;
format start_date_HC9 ddmmyys10.;
format end_date_HC9 ddmmyys10.;
recency_HC9=intck('day',end_date_HC9,'31Jan2016'd);
active_time_HC9=intck('day',start_date_HC9,end_date_HC9);
avg_units_per_txn_HC9 = total_unit_HC9/no_of_txn_HC9;
avg_units_per_visit_HC9 =  total_unit_HC9/no_of_visits_HC9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_WB_LS_HC_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_WB_LS_HC_TXN a 
left join  spdtmp7.VB_WB_LS_HC3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_WB_LS_HC6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_WB_LS_HC9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_WB_LS_HC3_TXN;
proc delete data=spdtmp7.VB_WB_LS_HC6_TXN;
proc delete data=spdtmp7.VB_WB_LS_HC9_TXN;
