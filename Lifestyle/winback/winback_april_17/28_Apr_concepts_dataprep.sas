





/*Getting Splash Transactions of Lifestyle winback customer base (Model)*/

data spdtmp7.VB_WB_Apr_LS_SH_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where 20150401 <= txn_dt_wid<=20160331 and LMG_concept_name="Splash" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/


/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_WB_Apr_LS_SH_TXN (compress=yes) as
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
		   
from spdtmp7.VB_WB_Apr_LS_SH_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_WB_Apr_LS_SH_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_SH_TXN;
format start_date_SH ddmmyys10.;
format end_date_SH ddmmyys10.;
recency_SH=intck('day',end_date_SH,'31Mar2016'd);
active_time_SH=intck('day',start_date_SH,end_date_SH);
avg_units_per_txn_SH = total_unit_SH/no_of_txn_SH;
avg_units_per_visit_SH =  total_unit_SH/no_of_visits_SH;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle winback customer base*/

data spdtmp7.VB_WB_Apr_LS_SH3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20160101 and txn_dt_wid<=20160331 and LMG_concept_name="Splash" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_Apr_LS_SH3_TXN(compress=yes) as
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

from spdtmp7.VB_WB_Apr_LS_SH3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_WB_Apr_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_WB_Apr_LS_SH3_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_SH3_TXN;
format start_date_SH3 ddmmyys10.;
format end_date_SH3 ddmmyys10.;
recency_SH3=intck('day',end_date_SH3,'31Mar2016'd);
active_time_SH3=intck('day',start_date_SH3,end_date_SH3);
avg_units_per_txn_SH3 = total_unit_SH3/no_of_txn_SH3;
avg_units_per_visit_SH3 =  total_unit_SH3/no_of_visits_SH3;
run;

/*6months*/


data spdtmp7.VB_WB_Apr_LS_SH6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20151001 and txn_dt_wid<=20160331 and LMG_concept_name="Splash" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_Apr_LS_SH6_TXN(compress=yes) as
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
from spdtmp7.VB_WB_Apr_LS_SH6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_WB_Apr_LS_SH6_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_SH6_TXN;
format start_date_SH6 ddmmyys10.;
format end_date_SH6 ddmmyys10.;
recency_SH6=intck('day',end_date_SH6,'31Mar2016'd);
active_time_SH6=intck('day',start_date_SH6,end_date_SH6);
avg_units_per_txn_SH6 = total_unit_SH6/no_of_txn_SH6;
avg_units_per_visit_SH6 =  total_unit_SH6/no_of_visits_SH6;
run;

/*9months*/

data spdtmp7.VB_WB_Apr_LS_SH9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20150701 and txn_dt_wid<=20160331 and LMG_concept_name="Splash" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_WB_Apr_LS_SH9_TXN(compress=yes) as
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

from spdtmp7.VB_WB_Apr_LS_SH9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_WB_Apr_LS_SH9_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_SH9_TXN;
format start_date_SH9 ddmmyys10.;
format end_date_SH9 ddmmyys10.;
recency_SH9=intck('day',end_date_SH9,'31Mar2016'd);
active_time_SH9=intck('day',start_date_SH9,end_date_SH9);
avg_units_per_txn_SH9 = total_unit_SH9/no_of_txn_Sh9;
avg_units_per_visit_SH9 =  total_unit_SH9/no_of_visits_SH9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_WB_Apr_LS_SH_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_WB_Apr_LS_SH_TXN a 
left join  spdtmp7.VB_WB_Apr_LS_SH3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_SH6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_SH9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_WB_Apr_LS_SH3_TXN;
proc delete data=spdtmp7.VB_WB_Apr_LS_SH6_TXN;
proc delete data=spdtmp7.VB_WB_Apr_LS_SH9_TXN;











/*Getting Home center Transactions of Lifestyle winback customer base (Model)*/

data spdtmp7.VB_WB_Apr_LS_HC_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where 20150401 <= txn_dt_wid<=20160331 and LMG_concept_name="Home center" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/


/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_WB_Apr_LS_HC_TXN (compress=yes) as
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
		   
from spdtmp7.VB_WB_Apr_LS_HC_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_WB_Apr_LS_HC_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_HC_TXN;
format start_date_HC ddmmyys10.;
format end_date_HC ddmmyys10.;
recency_HC=intck('day',end_date_HC,'31Mar2016'd);
active_time_HC=intck('day',start_date_HC,end_date_HC);
avg_units_per_txn_HC = total_unit_HC/no_of_txn_HC;
avg_units_per_visit_HC =  total_unit_HC/no_of_visits_HC;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle winback customer base*/

data spdtmp7.VB_WB_Apr_LS_HC3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20160101 and txn_dt_wid<=20160331 and LMG_concept_name="Home center" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_Apr_LS_HC3_TXN(compress=yes) as
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

from spdtmp7.VB_WB_Apr_LS_HC3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_WB_Apr_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_WB_Apr_LS_HC3_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_HC3_TXN;
format start_date_HC3 ddmmyys10.;
format end_date_HC3 ddmmyys10.;
recency_HC3=intck('day',end_date_HC3,'31Mar2016'd);
active_time_HC3=intck('day',start_date_HC3,end_date_HC3);
avg_units_per_txn_HC3 = total_unit_HC3/no_of_txn_HC3;
avg_units_per_visit_HC3 =  total_unit_HC3/no_of_visits_HC3;
run;

/*6months*/


data spdtmp7.VB_WB_Apr_LS_HC6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20151001 and txn_dt_wid<=20160331 and LMG_concept_name="Home center" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_Apr_LS_HC6_TXN(compress=yes) as
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
from spdtmp7.VB_WB_Apr_LS_HC6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_WB_Apr_LS_HC6_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_HC6_TXN;
format start_date_HC6 ddmmyys10.;
format end_date_HC6 ddmmyys10.;
recency_HC6=intck('day',end_date_HC6,'31Mar2016'd);
active_time_HC6=intck('day',start_date_HC6,end_date_HC6);
avg_units_per_txn_HC6 = total_unit_HC6/no_of_txn_HC6;
avg_units_per_visit_HC6 =  total_unit_HC6/no_of_visits_HC6;
run;

/*9months*/

data spdtmp7.VB_WB_Apr_LS_HC9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20150701 and txn_dt_wid<=20160331 and LMG_concept_name="Home center" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_WB_Apr_LS_HC9_TXN(compress=yes) as
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

from spdtmp7.VB_WB_Apr_LS_HC9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_WB_Apr_LS_HC9_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_HC9_TXN;
format start_date_HC9 ddmmyys10.;
format end_date_HC9 ddmmyys10.;
recency_HC9=intck('day',end_date_HC9,'31Mar2016'd);
active_time_HC9=intck('day',start_date_HC9,end_date_HC9);
avg_units_per_txn_HC9 = total_unit_HC9/no_of_txn_HC9;
avg_units_per_visit_HC9 =  total_unit_HC9/no_of_visits_HC9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_WB_Apr_LS_HC_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_WB_Apr_LS_HC_TXN a 
left join  spdtmp7.VB_WB_Apr_LS_HC3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_HC6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_HC9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_WB_Apr_LS_HC3_TXN;
proc delete data=spdtmp7.VB_WB_Apr_LS_HC6_TXN;
proc delete data=spdtmp7.VB_WB_Apr_LS_HC9_TXN;


/*Getting Home Box Transactions of Lifestyle winback customer base (Model)*/

data spdtmp7.VB_WB_Apr_LS_HB_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where 20150401 <= txn_dt_wid<=20160331 and LMG_concept_name="Home Box" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/


/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_WB_Apr_LS_HB_TXN (compress=yes) as
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
		   
from spdtmp7.VB_WB_Apr_LS_HB_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_WB_Apr_LS_HB_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_HB_TXN;
format start_date_HB ddmmyys10.;
format end_date_HB ddmmyys10.;
recency_HB=intck('day',end_date_HB,'31Mar2016'd);
active_time_HB=intck('day',start_date_HB,end_date_HB);
avg_units_per_txn_HB = total_unit_HB/no_of_txn_HB;
avg_units_per_visit_HB =  total_unit_HB/no_of_visits_HB;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle winback customer base*/

data spdtmp7.VB_WB_Apr_LS_HB3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20160101 and txn_dt_wid<=20160331 and LMG_concept_name="Home Box" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_Apr_LS_HB3_TXN(compress=yes) as
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

from spdtmp7.VB_WB_Apr_LS_HB3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_WB_Apr_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_WB_Apr_LS_HB3_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_HB3_TXN;
format start_date_HB3 ddmmyys10.;
format end_date_HB3 ddmmyys10.;
recency_HB3=intck('day',end_date_HB3,'31Mar2016'd);
active_time_HB3=intck('day',start_date_HB3,end_date_HB3);
avg_units_per_txn_HB3 = total_unit_HB3/no_of_txn_HB3;
avg_units_per_visit_HB3 =  total_unit_HB3/no_of_visits_HB3;
run;

/*6months*/


data spdtmp7.VB_WB_Apr_LS_HB6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20151001 and txn_dt_wid<=20160331 and LMG_concept_name="Home Box" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_Apr_LS_HB6_TXN(compress=yes) as
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
from spdtmp7.VB_WB_Apr_LS_HB6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_WB_Apr_LS_HB6_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_HB6_TXN;
format start_date_HB6 ddmmyys10.;
format end_date_HB6 ddmmyys10.;
recency_HB6=intck('day',end_date_HB6,'31Mar2016'd);
active_time_HB6=intck('day',start_date_HB6,end_date_HB6);
avg_units_per_txn_HB6 = total_unit_HB6/no_of_txn_HB6;
avg_units_per_visit_HB6 =  total_unit_HB6/no_of_visits_HB6;
run;

/*9months*/

data spdtmp7.VB_WB_Apr_LS_HB9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20150701 and txn_dt_wid<=20160331 and LMG_concept_name="Home Box" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_WB_Apr_LS_HB9_TXN(compress=yes) as
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

from spdtmp7.VB_WB_Apr_LS_HB9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_HB_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_WB_Apr_LS_HB9_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_HB9_TXN;
format start_date_HB9 ddmmyys10.;
format end_date_HB9 ddmmyys10.;
recency_HB9=intck('day',end_date_HB9,'31Mar2016'd);
active_time_HB9=intck('day',start_date_HB9,end_date_HB9);
avg_units_per_txn_HB9 = total_unit_HB9/no_of_txn_HB9;
avg_units_per_visit_HB9 =  total_unit_HB9/no_of_visits_HB9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_WB_Apr_LS_HB_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_WB_Apr_LS_HB_TXN a 
left join  spdtmp7.VB_WB_Apr_LS_HB3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_HB6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_HB9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_WB_Apr_LS_HB3_TXN;
proc delete data=spdtmp7.VB_WB_Apr_LS_HB6_TXN;
proc delete data=spdtmp7.VB_WB_Apr_LS_HB9_TXN;






/*Getting Babyshop Transactions of Lifestyle winback customer base (Model)*/

data spdtmp7.VB_WB_Apr_LS_BS_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where 20150401 <= txn_dt_wid<=20160331 and LMG_concept_name="Babyshop" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/


/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_WB_Apr_LS_BS_TXN (compress=yes) as
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
		   
from spdtmp7.VB_WB_Apr_LS_BS_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_WB_Apr_LS_BS_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_BS_TXN;
format start_date_BS ddmmyys10.;
format end_date_BS ddmmyys10.;
recency_BS=intck('day',end_date_BS,'31Mar2016'd);
active_time_BS=intck('day',start_date_BS,end_date_BS);
avg_units_per_txn_BS = total_unit_BS/no_of_txn_BS;
avg_units_per_visit_BS =  total_unit_BS/no_of_visits_BS;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle winback customer base*/

data spdtmp7.VB_WB_Apr_LS_BS3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20160101 and txn_dt_wid<=20160331 and LMG_concept_name="Babyshop" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_Apr_LS_BS3_TXN(compress=yes) as
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

from spdtmp7.VB_WB_Apr_LS_BS3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_WB_Apr_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_WB_Apr_LS_BS3_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_BS3_TXN;
format start_date_BS3 ddmmyys10.;
format end_date_BS3 ddmmyys10.;
recency_BS3=intck('day',end_date_BS3,'31Mar2016'd);
active_time_BS3=intck('day',start_date_BS3,end_date_BS3);
avg_units_per_txn_BS3 = total_unit_BS3/no_of_txn_BS3;
avg_units_per_visit_BS3 =  total_unit_BS3/no_of_visits_BS3;
run;

/*6months*/


data spdtmp7.VB_WB_Apr_LS_BS6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20151001 and txn_dt_wid<=20160331 and LMG_concept_name="Babyshop" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_Apr_LS_BS6_TXN(compress=yes) as
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
from spdtmp7.VB_WB_Apr_LS_BS6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_WB_Apr_LS_BS6_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_BS6_TXN;
format start_date_BS6 ddmmyys10.;
format end_date_BS6 ddmmyys10.;
recency_BS6=intck('day',end_date_BS6,'31Mar2016'd);
active_time_BS6=intck('day',start_date_BS6,end_date_BS6);
avg_units_per_txn_BS6 = total_unit_BS6/no_of_txn_BS6;
avg_units_per_visit_BS6 =  total_unit_BS6/no_of_visits_BS6;
run;

/*9months*/

data spdtmp7.VB_WB_Apr_LS_BS9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20150701 and txn_dt_wid<=20160331 and LMG_concept_name="Babyshop" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_WB_Apr_LS_BS9_TXN(compress=yes) as
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

from spdtmp7.VB_WB_Apr_LS_BS9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_BS_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_WB_Apr_LS_BS9_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_BS9_TXN;
format start_date_BS9 ddmmyys10.;
format end_date_BS9 ddmmyys10.;
recency_BS9=intck('day',end_date_BS9,'31Mar2016'd);
active_time_BS9=intck('day',start_date_BS9,end_date_BS9);
avg_units_per_txn_BS9 = total_unit_BS9/no_of_txn_BS9;
avg_units_per_visit_BS9 =  total_unit_BS9/no_of_visits_BS9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_WB_Apr_LS_BS_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_WB_Apr_LS_BS_TXN a 
left join  spdtmp7.VB_WB_Apr_LS_BS3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_BS6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_BS9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_WB_Apr_LS_BS3_TXN;
proc delete data=spdtmp7.VB_WB_Apr_LS_BS6_TXN;
proc delete data=spdtmp7.VB_WB_Apr_LS_BS9_TXN;










/*Getting Shoemart Transactions of Lifestyle winback customer base (Model)*/

data spdtmp7.VB_WB_Apr_LS_SM_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where 20150401 <= txn_dt_wid<=20160331 and LMG_concept_name="Shoemart" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/


/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_WB_Apr_LS_SM_TXN (compress=yes) as
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
		   
from spdtmp7.VB_WB_Apr_LS_SM_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_WB_Apr_LS_SM_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_SM_TXN;
format start_date_SM ddmmyys10.;
format end_date_SM ddmmyys10.;
recency_SM=intck('day',end_date_SM,'31Mar2016'd);
active_time_SM=intck('day',start_date_SM,end_date_SM);
avg_units_per_txn_SM = total_unit_SM/no_of_txn_SM;
avg_units_per_visit_SM =  total_unit_SM/no_of_visits_SM;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle winback customer base*/

data spdtmp7.VB_WB_Apr_LS_SM3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20160101 and txn_dt_wid<=20160331 and LMG_concept_name="Shoemart" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_Apr_LS_SM3_TXN(compress=yes) as
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

from spdtmp7.VB_WB_Apr_LS_SM3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_WB_Apr_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_WB_Apr_LS_SM3_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_SM3_TXN;
format start_date_SM3 ddmmyys10.;
format end_date_SM3 ddmmyys10.;
recency_SM3=intck('day',end_date_SM3,'31Mar2016'd);
active_time_SM3=intck('day',start_date_SM3,end_date_SM3);
avg_units_per_txn_SM3 = total_unit_SM3/no_of_txn_SM3;
avg_units_per_visit_SM3 =  total_unit_SM3/no_of_visits_SM3;
run;

/*6months*/


data spdtmp7.VB_WB_Apr_LS_SM6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20151001 and txn_dt_wid<=20160331 and LMG_concept_name="Shoemart" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_Apr_LS_SM6_TXN(compress=yes) as
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
from spdtmp7.VB_WB_Apr_LS_SM6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_WB_Apr_LS_SM6_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_SM6_TXN;
format start_date_SM6 ddmmyys10.;
format end_date_SM6 ddmmyys10.;
recency_SM6=intck('day',end_date_SM6,'31Mar2016'd);
active_time_SM6=intck('day',start_date_SM6,end_date_SM6);
avg_units_per_txn_SM6 = total_unit_SM6/no_of_txn_SM6;
avg_units_per_visit_SM6 =  total_unit_SM6/no_of_visits_SM6;
run;

/*9months*/

data spdtmp7.VB_WB_Apr_LS_SM9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20150701 and txn_dt_wid<=20160331 and LMG_concept_name="Shoemart" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_WB_Apr_LS_SM9_TXN(compress=yes) as
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

from spdtmp7.VB_WB_Apr_LS_SM9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_SM_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_WB_Apr_LS_SM9_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_SM9_TXN;
format start_date_SM9 ddmmyys10.;
format end_date_SM9 ddmmyys10.;
recency_SM9=intck('day',end_date_SM9,'31Mar2016'd);
active_time_SM9=intck('day',start_date_SM9,end_date_SM9);
avg_units_per_txn_SM9 = total_unit_SM9/no_of_txn_SM9;
avg_units_per_visit_SM9 =  total_unit_SM9/no_of_visits_SM9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_WB_Apr_LS_SM_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_WB_Apr_LS_SM_TXN a 
left join  spdtmp7.VB_WB_Apr_LS_SM3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_SM6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_SM9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_WB_Apr_LS_SM3_TXN;
proc delete data=spdtmp7.VB_WB_Apr_LS_SM6_TXN;
proc delete data=spdtmp7.VB_WB_Apr_LS_SM9_TXN;




/*Getting Max Transactions of Lifestyle winback customer base (Model)*/

data spdtmp7.VB_WB_Apr_LS_MX_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where 20150401 <= txn_dt_wid<=20160331 and LMG_concept_name="Max" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/


/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_WB_Apr_LS_MX_TXN (compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_MX, 
           count(distinct date) as no_of_visits_MX, 
           count(distinct invoice_number) as no_of_txn_MX, 
           max(date) as end_date_MX, 
           min(date) as start_date_MX,
           count(distinct item_code) as distinct_prod_MX, 
           sum(units) as total_unit_MX, 
           sum(base_points_accrued) as total_points_MX ,
           sum(retail_cost_1_aed) as sum_cost_1_MX,
           sum(retail_cost_2_aed) as sum_cost_2_MX
		   
from spdtmp7.VB_WB_Apr_LS_MX_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_WB_Apr_LS_MX_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_MX_TXN;
format start_date_MX ddmmyys10.;
format end_date_MX ddmmyys10.;
recency_MX=intck('day',end_date_MX,'31Mar2016'd);
active_time_MX=intck('day',start_date_MX,end_date_MX);
avg_units_per_txn_MX = total_unit_MX/no_of_txn_MX;
avg_units_per_visit_MX =  total_unit_MX/no_of_visits_MX;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle winback customer base*/

data spdtmp7.VB_WB_Apr_LS_MX3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20160101 and txn_dt_wid<=20160331 and LMG_concept_name="Max" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_Apr_LS_MX3_TXN(compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_MX3, 
           count(distinct date) as no_of_visits_MX3, 
           count(distinct invoice_number) as no_of_txn_MX3, 
           max(date) as end_date_MX3, 
           min(date) as start_date_MX3,
           count(distinct item_code) as distinct_prod_MX3, 
           sum(units) as total_unit_MX3, 
           sum(base_points_accrued) as total_points_MX3 ,
           sum(retail_cost_1_aed) as sum_cost_1_MX3,
           sum(retail_cost_2_aed) as sum_cost_2_MX3

from spdtmp7.VB_WB_Apr_LS_MX3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_WB_Apr_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_WB_Apr_LS_MX3_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_MX3_TXN;
format start_date_MX3 ddmmyys10.;
format end_date_MX3 ddmmyys10.;
recency_MX3=intck('day',end_date_MX3,'31Mar2016'd);
active_time_MX3=intck('day',start_date_MX3,end_date_MX3);
avg_units_per_txn_MX3 = total_unit_MX3/no_of_txn_MX3;
avg_units_per_visit_MX3 =  total_unit_MX3/no_of_visits_MX3;
run;

/*6months*/


data spdtmp7.VB_WB_Apr_LS_MX6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20151001 and txn_dt_wid<=20160331 and LMG_concept_name="Max" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_Apr_LS_MX6_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_MX6, 
           count(distinct date) as no_of_visits_MX6, 
           count(distinct invoice_number) as no_of_txn_MX6, 
           max(date) as end_date_MX6, 
           min(date) as start_date_MX6,
           count(distinct item_code) as distinct_prod_MX6, 
           sum(units) as total_unit_MX6, 
           sum(base_points_accrued) as total_points_MX6,
		   sum(retail_cost_1_aed) as sum_cost_1_MX6,
		   sum(retail_cost_2_aed) as sum_cost_2_MX6 
from spdtmp7.VB_WB_Apr_LS_MX6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_WB_Apr_LS_MX6_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_MX6_TXN;
format start_date_MX6 ddmmyys10.;
format end_date_MX6 ddmmyys10.;
recency_MX6=intck('day',end_date_MX6,'31Mar2016'd);
active_time_MX6=intck('day',start_date_MX6,end_date_MX6);
avg_units_per_txn_MX6 = total_unit_MX6/no_of_txn_MX6;
avg_units_per_visit_MX6 =  total_unit_MX6/no_of_visits_MX6;
run;

/*9months*/

data spdtmp7.VB_WB_Apr_LS_MX9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_Apr_LS_TXN;
where txn_Dt_wid>=20150701 and txn_dt_wid<=20160331 and LMG_concept_name="Max" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_WB_Apr_LS_MX9_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_MX9, 
           count(distinct date) as no_of_visits_MX9, 
           count(distinct invoice_number) as no_of_txn_MX9, 
           max(date) as end_date_MX9, 
           min(date) as start_date_MX9,
           count(distinct item_code) as distinct_prod_MX9, 
           sum(units) as total_unit_MX9, 
           sum(base_points_accrued) as total_points_MX9 ,
           sum(retail_cost_1_aed) as sum_cost_1_MX9,
           sum(retail_cost_2_aed) as sum_cost_2_MX9

from spdtmp7.VB_WB_Apr_LS_MX9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_MX_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_WB_Apr_LS_MX9_TXN(compress=yes);
set spdtmp7.VB_WB_Apr_LS_MX9_TXN;
format start_date_MX9 ddmmyys10.;
format end_date_MX9 ddmmyys10.;
recency_MX9=intck('day',end_date_MX9,'31Mar2016'd);
active_time_MX9=intck('day',start_date_MX9,end_date_MX9);
avg_units_per_txn_MX9 = total_unit_MX9/no_of_txn_MX9;
avg_units_per_visit_MX9 =  total_unit_MX9/no_of_visits_MX9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_WB_Apr_LS_MX_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_WB_Apr_LS_MX_TXN a 
left join  spdtmp7.VB_WB_Apr_LS_MX3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_MX6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_MX9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_WB_Apr_LS_MX3_TXN;
proc delete data=spdtmp7.VB_WB_Apr_LS_MX6_TXN;
proc delete data=spdtmp7.VB_WB_Apr_LS_MX9_TXN;










