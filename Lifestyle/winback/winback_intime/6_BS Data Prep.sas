



/*Getting Babyshop Transactions of Lifestyle winback customer base (Model)*/

data spdtmp7.VB_WB_LS_BS_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_LS_TXN;
where txn_dt_wid<=20160131 and LMG_concept_name="Babyshop" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/


/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_WB_LS_BS_TXN (compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_BS, 
           count(distinct date) as no_of_visits_BS, 
           count(distinct invoice_number) as no_of_txn_BS, 
           max(date) as end_date_BS, 
           min(date) as start_date_BS,
           count(distinct item_code) as distinct_prod_BS, 
           sum(units) as total_unit_BS, 
           sum(base_points_accrued) as total_points_BS ,
           sum(retail_cost_1_aed) as sum_cost_1_BS,
           sum(retail_cost_2_aed) as sum_cost_2_BS
		   
from spdtmp7.VB_WB_LS_BS_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_WB_LS_BS_TXN(compress=yes);
set spdtmp7.VB_WB_LS_BS_TXN;
format start_date_BS ddmmyys10.;
format end_date_BS ddmmyys10.;
recency_BS=intck('day',end_date_BS,'31Jan2016'd);
active_time_BS=intck('day',start_date_BS,end_date_BS);
avg_units_per_txn_BS = total_unit_BS/no_of_txn_BS;
avg_units_per_visit_BS =  total_unit_BS/no_of_visits_BS;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle winback customer base*/

data spdtmp7.VB_WB_LS_BS3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_LS_TXN;
where txn_Dt_wid>=20151101 and txn_dt_wid<=20160131 and LMG_concept_name="Babyshop" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_LS_BS3_TXN(compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_BS3, 
           count(distinct date) as no_of_visits_BS3, 
           count(distinct invoice_number) as no_of_txn_BS3, 
           max(date) as end_date_BS3, 
           min(date) as start_date_BS3,
           count(distinct item_code) as distinct_prod_BS3, 
           sum(units) as total_unit_BS3, 
           sum(base_points_accrued) as total_points_BS3 ,
           sum(retail_cost_1_aed) as sum_cost_1_BS3,
           sum(retail_cost_2_aed) as sum_cost_2_BS3

from spdtmp7.VB_WB_LS_BS3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_WB_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_WB_LS_BS3_TXN(compress=yes);
set spdtmp7.VB_WB_LS_BS3_TXN;
format start_date_BS3 ddmmyys10.;
format end_date_BS3 ddmmyys10.;
recency_BS3=intck('day',end_date_BS3,'31Jan2016'd);
active_time_BS3=intck('day',start_date_BS3,end_date_BS3);
avg_units_per_txn_BS3 = total_unit_BS3/no_of_txn_BS3;
avg_units_per_visit_BS3 =  total_unit_BS3/no_of_visits_BS3;
run;

/*6months*/


data spdtmp7.VB_WB_LS_BS6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_LS_TXN;
where txn_Dt_wid>=20150801 and txn_dt_wid<=20160131 and LMG_concept_name="Babyshop" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_LS_BS6_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_BS6, 
           count(distinct date) as no_of_visits_BS6, 
           count(distinct invoice_number) as no_of_txn_BS6, 
           max(date) as end_date_BS6, 
           min(date) as start_date_BS6,
           count(distinct item_code) as distinct_prod_BS6, 
           sum(units) as total_unit_BS6, 
           sum(base_points_accrued) as total_points_BS6,
		   sum(retail_cost_1_aed) as sum_cost_1_BS6,
		   sum(retail_cost_2_aed) as sum_cost_2_BS6 
from spdtmp7.VB_WB_LS_BS6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_WB_LS_BS6_TXN(compress=yes);
set spdtmp7.VB_WB_LS_BS6_TXN;
format start_date_BS6 ddmmyys10.;
format end_date_BS6 ddmmyys10.;
recency_BS6=intck('day',end_date_BS6,'31Jan2016'd);
active_time_BS6=intck('day',start_date_BS6,end_date_BS6);
avg_units_per_txn_BS6 = total_unit_BS6/no_of_txn_BS6;
avg_units_per_visit_BS6 =  total_unit_BS6/no_of_visits_BS6;
run;

/*9months*/

data spdtmp7.VB_WB_LS_BS9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_LS_TXN;
where txn_Dt_wid>=20150501 and txn_dt_wid<=20160131 and LMG_concept_name="Babyshop" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_WB_LS_BS9_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_BS9, 
           count(distinct date) as no_of_visits_BS9, 
           count(distinct invoice_number) as no_of_txn_BS9, 
           max(date) as end_date_BS9, 
           min(date) as start_date_BS9,
           count(distinct item_code) as distinct_prod_BS9, 
           sum(units) as total_unit_BS9, 
           sum(base_points_accrued) as total_points_BS9 ,
           sum(retail_cost_1_aed) as sum_cost_1_BS9,
           sum(retail_cost_2_aed) as sum_cost_2_BS9

from spdtmp7.VB_WB_LS_BS9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_BS_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_WB_LS_BS9_TXN(compress=yes);
set spdtmp7.VB_WB_LS_BS9_TXN;
format start_date_BS9 ddmmyys10.;
format end_date_BS9 ddmmyys10.;
recency_BS9=intck('day',end_date_BS9,'31Jan2016'd);
active_time_BS9=intck('day',start_date_BS9,end_date_BS9);
avg_units_per_txn_BS9 = total_unit_BS9/no_of_txn_BS9;
avg_units_per_visit_BS9 =  total_unit_BS9/no_of_visits_BS9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_WB_LS_BS_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_WB_LS_BS_TXN a 
left join  spdtmp7.VB_WB_LS_BS3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_WB_LS_BS6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_WB_LS_BS9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_WB_LS_BS3_TXN;
proc delete data=spdtmp7.VB_WB_LS_BS6_TXN;
proc delete data=spdtmp7.VB_WB_LS_BS9_TXN;
