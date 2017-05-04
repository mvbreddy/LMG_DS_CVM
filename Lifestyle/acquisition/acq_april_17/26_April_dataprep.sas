



%include'/home/unxsrv/code/Automated_Solutions/Libnames/LIBNAMES.sas';

 
 
proc sql;
create table spdtmp7.VB_AQ_Apr_Cus2016 (compress=yes) as 
select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where txn_dt_wid>=20160401 and txn_dt_wid<=20170331 and 
Lmg_mem_card_number not in (select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where Lmg_concept_name="Lifestyle" and txn_dt_wid>=20160401  and txn_dt_wid<=20170331 );
quit;


/*2years*/
proc sql;
create table spdtmp7.VB_AQ_Apr_Cus201516 (compress=yes) as 
select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where txn_dt_wid>=20150401 and txn_dt_wid<=20170331 and 
Lmg_mem_card_number not in (select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where Lmg_concept_name="Lifestyle" and txn_dt_wid>=20150401  and txn_dt_wid<=20170331 );
quit; 


data spdtmp7.VB_AQ_Apr_LS_Cust;
merge spdtmp7.VB_AQ_Apr_Cus201516(in=a) spdtmp7.VB_AQ_Apr_Cus2016(in=b);
if a=1 and b=1 ;
by lmg_mem_card_number;
run;


/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number) from spdtmp7.sd_txn_wb*/
/*where LMG_concept_name="Lifestyle" and txn_dt_wid<=20151231;*/
/*quit;*/


/*proc delete data=spdtmp7.VB_AQ_Apr_LS_TXN_Cust2015;run;*/
/**/
/*proc delete data=spdtmp7.VB_AQ_Apr_LS_TXN_Cust2015;run;*/

/*Table for wb cust base all obs*/

proc sql;
create table spdtmp7.VB_AQ_Apr_LS_TXN(compress=yes) as
select a.*, b.* from  spdtmp7.VB_AQ_Apr_LS_Cust a
left join spdtmp7.sd_txn_wb b
on a.LMG_mem_card_number = b.LMG_mem_card_number;
run;



/* LMG_DATAPREP */









/*Getting LMG level transactions for Lifestyle Acquisiton customers*/

data spdtmp7.VB_AQ_Apr_LMG_ALL_TXN(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_dt_wid<=20170331 and txn_dt_wid >= 20160401  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/


/*all metrices LMG all customers*/


proc sql;
create table spdtmp7.VB_AQ_Apr_LMG_ALL_TXN (compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmg, 
           count(distinct date) as no_of_visits_lmg, 
           count(distinct invoice_number) as no_of_txn_lmg, 
           max(date) as end_date_lmg, 
           min(date) as start_date_lmg,
           count(distinct item_code) as distinct_prod_lmg,
		   count(distinct lmg_concept_name) as concept_count,		 
           sum(units) as total_unit_lmg, 
           sum(base_points_accrued) as total_points_lmg ,
           sum(retail_cost_1_aed) as sum_cost_1_lmg,
           sum(retail_cost_2_aed) as sum_cost_2_lmg
		   
from spdtmp7.VB_AQ_Apr_LMG_ALL_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_AQ_Apr_LMG_ALL_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LMG_ALL_TXN;
format start_date_lmg ddmmyys10.;
format end_date_lmg ddmmyys10.;
recency_lmg=intck('day',end_date_lmg,'31Mar2017'd);
active_time_lmg=intck('day',start_date_lmg,end_date_lmg);
avg_units_per_txn_lmg = total_unit_lmg/no_of_txn_lmg;
avg_units_per_visit_lmg =  total_unit_lmg/no_of_visits_lmg;
run;


/* Making 3,6,9 month aggregates for potential  Acquisiton customer base*/

data spdtmp7.VB_AQ_Apr_LMG_3_TXN(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_dt_wid>=20170101 and txn_dt_wid<=20170331 and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.VB_AQ_Apr_LMG_3_TXN(compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmg3, 
           count(distinct date) as no_of_visits_lmg3, 
           count(distinct invoice_number) as no_of_txn_lmg3, 
           max(date) as end_date_lmg3, 
           min(date) as start_date_lmg3,
           count(distinct item_code) as distinct_prod_lmg3,
		   count(distinct lmg_concept_name) as concept_count_lmg3, 
           sum(units) as total_unit_lmg3, 
           sum(base_points_accrued) as total_points_lmg3 ,
           sum(retail_cost_1_aed) as sum_cost_1_lmg3,
           sum(retail_cost_2_aed) as sum_cost_2_lmg3

from spdtmp7.VB_AQ_Apr_LMG_3_TXN

group by LMG_MEM_CARD_Number;

quit;


data spdtmp7.VB_AQ_Apr_LMG_3_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LMG_3_TXN;
format start_date_lmg3 ddmmyys10.;
format end_date_lmg3 ddmmyys10.;
recency_lmg3=intck('day',end_date_lmg3,'31Mar2017'd);
active_time_lmg3=intck('day',start_date_lmg3,end_date_lmg3);
avg_units_per_txn_lmg3 = total_unit_lmg3/no_of_txn_lmg3;
avg_units_per_visit_lmg3 =  total_unit_lmg3/no_of_visits_lmg3;
run;

/*6months*/


data spdtmp7.VB_AQ_Apr_LMG_6_TXN(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20161001 and txn_dt_wid<=20170331 and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_Apr_LMG_6_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmg6, 
           count(distinct date) as no_of_visits_lmg6, 
           count(distinct invoice_number) as no_of_txn_lmg6, 
           max(date) as end_date_lmg6, 
           min(date) as start_date_lmg6,
           count(distinct item_code) as distinct_prod_lmg6,
		   count(distinct lmg_concept_name) as concept_count_lmg6, 
           sum(units) as total_unit_lmg6, 
           sum(base_points_accrued) as total_points_lmg6,
		   sum(retail_cost_1_aed) as sum_cost_1_lmg6,
		   sum(retail_cost_2_aed) as sum_cost_2_lmg6 
from spdtmp7.VB_AQ_Apr_LMG_6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_AQ_Apr_LMG_6_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LMG_6_TXN;
format start_date_lmg6 ddmmyys10.;
format end_date_lmg6 ddmmyys10.;
recency_lmg6=intck('day',end_date_lmg6,'31Mar2017'd);
active_time_lmg6=intck('day',start_date_lmg6,end_date_lmg6);
avg_units_per_txn_lmg6 = total_unit_lmg6/no_of_txn_lmg6;
avg_units_per_visit_lmg6 =  total_unit_lmg6/no_of_visits_lmg6;
run;

/*9months*/

data spdtmp7.VB_AQ_Apr_LMG_9_TXN(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20160701 and txn_dt_wid<=20170331 and  revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_AQ_Apr_LMG_9_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmg9, 
           count(distinct date) as no_of_visits_lmg9, 
           count(distinct invoice_number) as no_of_txn_lmg9, 
           max(date) as end_date_lmg9, 
           min(date) as start_date_lmg9,
           count(distinct item_code) as distinct_prod_lmg9,
		   count(distinct lmg_concept_name) as concept_count_lmg9, 
           sum(units) as total_unit_lmg9, 
           sum(base_points_accrued) as total_points_lmg9 ,
           sum(retail_cost_1_aed) as sum_cost_1_lmg9,
           sum(retail_cost_2_aed) as sum_cost_2_lmg9

from spdtmp7.VB_AQ_Apr_LMG_9_TXN

group by LMG_MEM_CARD_Number;

quit;


data spdtmp7.VB_AQ_Apr_LMG_9_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LMG_9_TXN;
format start_date_lmg9 ddmmyys10.;
format end_date_lmg9 ddmmyys10.;
recency_lmg9=intck('day',end_date_lmg9,'31Mar2017'd);
active_time_lmg9=intck('day',start_date_lmg9,end_date_lmg9);
avg_units_per_txn_lmg9 = total_unit_lmg9/no_of_txn_lmg9;
avg_units_per_visit_lmg9 =  total_unit_lmg9/no_of_visits_lmg9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_AQ_Apr_LMG_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_AQ_Apr_LMG_ALL_TXN a 
left join  spdtmp7.VB_AQ_Apr_LMG_3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LMG_6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LMG_9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_AQ_Apr_LMG_3_TXN;
proc delete data=spdtmp7.VB_AQ_Apr_LMG_6_TXN;
proc delete data=spdtmp7.VB_AQ_Apr_LMG_9_TXN;


/* SH_Dataprep */







/*Getting Splash Transactions of Lifestyle Acquisiton customer base (Model)*/

data spdtmp7.VB_AQ_Apr_LS_SH_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_dt_wid<=20170331 and txn_dt_wid >= 20160401 and LMG_concept_name="Splash" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/

/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_AQ_Apr_LS_SH_TXN (compress=yes) as
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
		   
from spdtmp7.VB_AQ_Apr_LS_SH_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_AQ_Apr_LS_SH_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_SH_TXN;
format start_date_SH ddmmyys10.;
format end_date_SH ddmmyys10.;
recency_SH=intck('day',end_date_SH,'31Mar2017'd);
active_time_SH=intck('day',start_date_SH,end_date_SH);
avg_units_per_txn_SH = total_unit_SH/no_of_txn_SH;
avg_units_per_visit_SH =  total_unit_SH/no_of_visits_SH;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle Acquisiton customer base*/

data spdtmp7.VB_AQ_Apr_LS_SH3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20170101 and txn_dt_wid<=20170331 and LMG_concept_name="Splash" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_Apr_LS_SH3_TXN(compress=yes) as
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

from spdtmp7.VB_AQ_Apr_LS_SH3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_AQ_Apr_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_AQ_Apr_LS_SH3_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_SH3_TXN;
format start_date_SH3 ddmmyys10.;
format end_date_SH3 ddmmyys10.;
recency_SH3=intck('day',end_date_SH3,'31Mar2017'd);
active_time_SH3=intck('day',start_date_SH3,end_date_SH3);
avg_units_per_txn_SH3 = total_unit_SH3/no_of_txn_SH3;
avg_units_per_visit_SH3 =  total_unit_SH3/no_of_visits_SH3;
run;

/*6months*/


data spdtmp7.VB_AQ_Apr_LS_SH6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20161001 and txn_dt_wid<=20170331 and LMG_concept_name="Splash" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_Apr_LS_SH6_TXN(compress=yes) as
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
from spdtmp7.VB_AQ_Apr_LS_SH6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_AQ_Apr_LS_SH6_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_SH6_TXN;
format start_date_SH6 ddmmyys10.;
format end_date_SH6 ddmmyys10.;
recency_SH6=intck('day',end_date_SH6,'31Mar2017'd);
active_time_SH6=intck('day',start_date_SH6,end_date_SH6);
avg_units_per_txn_SH6 = total_unit_SH6/no_of_txn_SH6;
avg_units_per_visit_SH6 =  total_unit_SH6/no_of_visits_SH6;
run;

/*9months*/

data spdtmp7.VB_AQ_Apr_LS_SH9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20160701 and txn_dt_wid<=20170331 and LMG_concept_name="Splash" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_AQ_Apr_LS_SH9_TXN(compress=yes) as
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

from spdtmp7.VB_AQ_Apr_LS_SH9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_AQ_Apr_LS_SH9_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_SH9_TXN;
format start_date_SH9 ddmmyys10.;
format end_date_SH9 ddmmyys10.;
recency_SH9=intck('day',end_date_SH9,'31Mar2017'd);
active_time_SH9=intck('day',start_date_SH9,end_date_SH9);
avg_units_per_txn_SH9 = total_unit_SH9/no_of_txn_Sh9;
avg_units_per_visit_SH9 =  total_unit_SH9/no_of_visits_SH9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_AQ_Apr_LS_SH_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_AQ_Apr_LS_SH_TXN a 
left join  spdtmp7.VB_AQ_Apr_LS_SH3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_SH6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_SH9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_AQ_Apr_LS_SH3_TXN;
proc delete data=spdtmp7.VB_AQ_Apr_LS_SH6_TXN;
proc delete data=spdtmp7.VB_AQ_Apr_LS_SH9_TXN;


/* HC _ Dataprep */




/*Getting Home center Transactions of Lifestyle Acquisiton customer base (Model)*/

data spdtmp7.VB_AQ_Apr_LS_HC_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_dt_wid<=20170331 and txn_dt_wid >= 20160401 and LMG_concept_name="Home center" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/

/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_AQ_Apr_LS_HC_TXN (compress=yes) as
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
		   
from spdtmp7.VB_AQ_Apr_LS_HC_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_AQ_Apr_LS_HC_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_HC_TXN;
format start_date_HC ddmmyys10.;
format end_date_HC ddmmyys10.;
recency_HC=intck('day',end_date_HC,'31Mar2017'd);
active_time_HC=intck('day',start_date_HC,end_date_HC);
avg_units_per_txn_HC = total_unit_HC/no_of_txn_HC;
avg_units_per_visit_HC =  total_unit_HC/no_of_visits_HC;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle Acquisiton customer base*/

data spdtmp7.VB_AQ_Apr_LS_HC3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20170101 and txn_dt_wid<=20170331 and LMG_concept_name="Home center" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_Apr_LS_HC3_TXN(compress=yes) as
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

from spdtmp7.VB_AQ_Apr_LS_HC3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_AQ_Apr_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_AQ_Apr_LS_HC3_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_HC3_TXN;
format start_date_HC3 ddmmyys10.;
format end_date_HC3 ddmmyys10.;
recency_HC3=intck('day',end_date_HC3,'31Mar2017'd);
active_time_HC3=intck('day',start_date_HC3,end_date_HC3);
avg_units_per_txn_HC3 = total_unit_HC3/no_of_txn_HC3;
avg_units_per_visit_HC3 =  total_unit_HC3/no_of_visits_HC3;
run;

/*6months*/


data spdtmp7.VB_AQ_Apr_LS_HC6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20161001 and txn_dt_wid<=20170331 and LMG_concept_name="Home center" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_Apr_LS_HC6_TXN(compress=yes) as
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
from spdtmp7.VB_AQ_Apr_LS_HC6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_AQ_Apr_LS_HC6_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_HC6_TXN;
format start_date_HC6 ddmmyys10.;
format end_date_HC6 ddmmyys10.;
recency_HC6=intck('day',end_date_HC6,'31Mar2017'd);
active_time_HC6=intck('day',start_date_HC6,end_date_HC6);
avg_units_per_txn_HC6 = total_unit_HC6/no_of_txn_HC6;
avg_units_per_visit_HC6 =  total_unit_HC6/no_of_visits_HC6;
run;

/*9months*/

data spdtmp7.VB_AQ_Apr_LS_HC9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20160701 and txn_dt_wid<=20170331 and LMG_concept_name="Home center" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_AQ_Apr_LS_HC9_TXN(compress=yes) as
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

from spdtmp7.VB_AQ_Apr_LS_HC9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_AQ_Apr_LS_HC9_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_HC9_TXN;
format start_date_HC9 ddmmyys10.;
format end_date_HC9 ddmmyys10.;
recency_HC9=intck('day',end_date_HC9,'31Mar2017'd);
active_time_HC9=intck('day',start_date_HC9,end_date_HC9);
avg_units_per_txn_HC9 = total_unit_HC9/no_of_txn_HC9;
avg_units_per_visit_HC9 =  total_unit_HC9/no_of_visits_HC9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_AQ_Apr_LS_HC_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_AQ_Apr_LS_HC_TXN a 
left join  spdtmp7.VB_AQ_Apr_LS_HC3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_HC6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_HC9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_AQ_Apr_LS_HC3_TXN;
proc delete data=spdtmp7.VB_AQ_Apr_LS_HC6_TXN;
proc delete data=spdtmp7.VB_AQ_Apr_LS_HC9_TXN;


/* HB_Dataprep */




/*Getting Home Box Transactions of Lifestyle acquisition customer base (Model)*/

data spdtmp7.VB_AQ_Apr_LS_HB_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_dt_wid<=20170331 and txn_dt_wid >= 20160401 and LMG_concept_name="Home Box" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/

/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_AQ_Apr_LS_HB_TXN (compress=yes) as
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
		   
from spdtmp7.VB_AQ_Apr_LS_HB_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_AQ_Apr_LS_HB_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_HB_TXN;
format start_date_HB ddmmyys10.;
format end_date_HB ddmmyys10.;
recency_HB=intck('day',end_date_HB,'31Mar2017'd);
active_time_HB=intck('day',start_date_HB,end_date_HB);
avg_units_per_txn_HB = total_unit_HB/no_of_txn_HB;
avg_units_per_visit_HB =  total_unit_HB/no_of_visits_HB;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle acquisition customer base*/

data spdtmp7.VB_AQ_Apr_LS_HB3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20170101 and txn_dt_wid<=20170331 and LMG_concept_name="Home Box" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_Apr_LS_HB3_TXN(compress=yes) as
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

from spdtmp7.VB_AQ_Apr_LS_HB3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_AQ_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_AQ_Apr_LS_HB3_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_HB3_TXN;
format start_date_HB3 ddmmyys10.;
format end_date_HB3 ddmmyys10.;
recency_HB3=intck('day',end_date_HB3,'31Mar2017'd);
active_time_HB3=intck('day',start_date_HB3,end_date_HB3);
avg_units_per_txn_HB3 = total_unit_HB3/no_of_txn_HB3;
avg_units_per_visit_HB3 =  total_unit_HB3/no_of_visits_HB3;
run;

/*6months*/


data spdtmp7.VB_AQ_Apr_LS_HB6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20161001 and txn_dt_wid<=20170331 and LMG_concept_name="Home Box" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_Apr_LS_HB6_TXN(compress=yes) as
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
from spdtmp7.VB_AQ_Apr_LS_HB6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_AQ_Apr_LS_HB6_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_HB6_TXN;
format start_date_HB6 ddmmyys10.;
format end_date_HB6 ddmmyys10.;
recency_HB6=intck('day',end_date_HB6,'31Mar2017'd);
active_time_HB6=intck('day',start_date_HB6,end_date_HB6);
avg_units_per_txn_HB6 = total_unit_HB6/no_of_txn_HB6;
avg_units_per_visit_HB6 =  total_unit_HB6/no_of_visits_HB6;
run;

/*9months*/

data spdtmp7.VB_AQ_Apr_LS_HB9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20160701 and txn_dt_wid<=20170331 and LMG_concept_name="Home Box" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_AQ_Apr_LS_HB9_TXN(compress=yes) as
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

from spdtmp7.VB_AQ_Apr_LS_HB9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_AQ_Apr_LS_HB9_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_HB9_TXN;
format start_date_HB9 ddmmyys10.;
format end_date_HB9 ddmmyys10.;
recency_HB9=intck('day',end_date_HB9,'31Mar2017'd);
active_time_HB9=intck('day',start_date_HB9,end_date_HB9);
avg_units_per_txn_HB9 = total_unit_HB9/no_of_txn_HB9;
avg_units_per_visit_HB9 =  total_unit_HB9/no_of_visits_HB9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_AQ_Apr_LS_HB_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_AQ_Apr_LS_HB_TXN a 
left join  spdtmp7.VB_AQ_Apr_LS_HB3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_HB6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_HB9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_AQ_Apr_LS_HB3_TXN;
proc delete data=spdtmp7.VB_AQ_Apr_LS_HB6_TXN;
proc delete data=spdtmp7.VB_AQ_Apr_LS_HB9_TXN;



/*Getting Babyshop Transactions of Lifestyle Acquisiton customer base (Model)*/

data spdtmp7.VB_AQ_Apr_LS_BS_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_dt_wid<=20170331 and txn_dt_wid >= 20160401 and LMG_concept_name="Babyshop" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/

/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_AQ_Apr_LS_BS_TXN (compress=yes) as
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
		   
from spdtmp7.VB_AQ_Apr_LS_BS_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_AQ_Apr_LS_BS_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_BS_TXN;
format start_date_BS ddmmyys10.;
format end_date_BS ddmmyys10.;
recency_BS=intck('day',end_date_BS,'31Mar2017'd);
active_time_BS=intck('day',start_date_BS,end_date_BS);
avg_units_per_txn_BS = total_unit_BS/no_of_txn_BS;
avg_units_per_visit_BS =  total_unit_BS/no_of_visits_BS;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle Acquisiton customer base*/

data spdtmp7.VB_AQ_Apr_LS_BS3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20170101 and txn_dt_wid<=20170331 and LMG_concept_name="Babyshop" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_Apr_LS_BS3_TXN(compress=yes) as
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

from spdtmp7.VB_AQ_Apr_LS_BS3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_AQ_Apr_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_AQ_Apr_LS_BS3_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_BS3_TXN;
format start_date_BS3 ddmmyys10.;
format end_date_BS3 ddmmyys10.;
recency_BS3=intck('day',end_date_BS3,'31Mar2017'd);
active_time_BS3=intck('day',start_date_BS3,end_date_BS3);
avg_units_per_txn_BS3 = total_unit_BS3/no_of_txn_BS3;
avg_units_per_visit_BS3 =  total_unit_BS3/no_of_visits_BS3;
run;

/*6months*/


data spdtmp7.VB_AQ_Apr_LS_BS6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20161001 and txn_dt_wid<=20170331 and LMG_concept_name="Babyshop" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_Apr_LS_BS6_TXN(compress=yes) as
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
from spdtmp7.VB_AQ_Apr_LS_BS6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_AQ_Apr_LS_BS6_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_BS6_TXN;
format start_date_BS6 ddmmyys10.;
format end_date_BS6 ddmmyys10.;
recency_BS6=intck('day',end_date_BS6,'31Mar2017'd);
active_time_BS6=intck('day',start_date_BS6,end_date_BS6);
avg_units_per_txn_BS6 = total_unit_BS6/no_of_txn_BS6;
avg_units_per_visit_BS6 =  total_unit_BS6/no_of_visits_BS6;
run;

/*9months*/

data spdtmp7.VB_AQ_Apr_LS_BS9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20160701 and txn_dt_wid<=20170331 and LMG_concept_name="Babyshop" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_AQ_Apr_LS_BS9_TXN(compress=yes) as
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

from spdtmp7.VB_AQ_Apr_LS_BS9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_AQ_Apr_LS_BS9_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_BS9_TXN;
format start_date_BS9 ddmmyys10.;
format end_date_BS9 ddmmyys10.;
recency_BS9=intck('day',end_date_BS9,'31Mar2017'd);
active_time_BS9=intck('day',start_date_BS9,end_date_BS9);
avg_units_per_txn_BS9 = total_unit_BS9/no_of_txn_BS9;
avg_units_per_visit_BS9 =  total_unit_BS9/no_of_visits_BS9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_AQ_Apr_LS_BS_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_AQ_Apr_LS_BS_TXN a 
left join  spdtmp7.VB_AQ_Apr_LS_BS3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_BS6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_BS9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_AQ_Apr_LS_BS3_TXN;
proc delete data=spdtmp7.VB_AQ_Apr_LS_BS6_TXN;
proc delete data=spdtmp7.VB_AQ_Apr_LS_BS9_TXN;





/* SM_dataprep */


/*Getting Shoemart Transactions of Lifestyle Acquisiton customer base (Model)*/

data spdtmp7.VB_AQ_Apr_LS_SM_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_dt_wid<=20170331 and txn_dt_wid >= 20160401 and LMG_concept_name="Shoemart" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/

/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_AQ_Apr_LS_SM_TXN (compress=yes) as
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
		   
from spdtmp7.VB_AQ_Apr_LS_SM_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_AQ_Apr_LS_SM_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_SM_TXN;
format start_date_SM ddmmyys10.;
format end_date_SM ddmmyys10.;
recency_SM=intck('day',end_date_SM,'31Mar2017'd);
active_time_SM=intck('day',start_date_SM,end_date_SM);
avg_units_per_txn_SM = total_unit_SM/no_of_txn_SM;
avg_units_per_visit_SM =  total_unit_SM/no_of_visits_SM;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle Acquisiton customer base*/

data spdtmp7.VB_AQ_Apr_LS_SM3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20170101 and txn_dt_wid<=20170331 and LMG_concept_name="Shoemart" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_Apr_LS_SM3_TXN(compress=yes) as
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

from spdtmp7.VB_AQ_Apr_LS_SM3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_AQ_Apr_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_AQ_Apr_LS_SM3_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_SM3_TXN;
format start_date_SM3 ddmmyys10.;
format end_date_SM3 ddmmyys10.;
recency_SM3=intck('day',end_date_SM3,'31Mar2017'd);
active_time_SM3=intck('day',start_date_SM3,end_date_SM3);
avg_units_per_txn_SM3 = total_unit_SM3/no_of_txn_SM3;
avg_units_per_visit_SM3 =  total_unit_SM3/no_of_visits_SM3;
run;

/*6months*/


data spdtmp7.VB_AQ_Apr_LS_SM6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20161001 and txn_dt_wid<=20170331 and LMG_concept_name="Shoemart" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_Apr_LS_SM6_TXN(compress=yes) as
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
from spdtmp7.VB_AQ_Apr_LS_SM6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_AQ_Apr_LS_SM6_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_SM6_TXN;
format start_date_SM6 ddmmyys10.;
format end_date_SM6 ddmmyys10.;
recency_SM6=intck('day',end_date_SM6,'31Mar2017'd);
active_time_SM6=intck('day',start_date_SM6,end_date_SM6);
avg_units_per_txn_SM6 = total_unit_SM6/no_of_txn_SM6;
avg_units_per_visit_SM6 =  total_unit_SM6/no_of_visits_SM6;
run;

/*9months*/

data spdtmp7.VB_AQ_Apr_LS_SM9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20160701 and txn_dt_wid<=20170331 and LMG_concept_name="Shoemart" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_AQ_Apr_LS_SM9_TXN(compress=yes) as
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

from spdtmp7.VB_AQ_Apr_LS_SM9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_AQ_Apr_LS_SM9_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_SM9_TXN;
format start_date_SM9 ddmmyys10.;
format end_date_SM9 ddmmyys10.;
recency_SM9=intck('day',end_date_SM9,'31Mar2017'd);
active_time_SM9=intck('day',start_date_SM9,end_date_SM9);
avg_units_per_txn_SM9 = total_unit_SM9/no_of_txn_SM9;
avg_units_per_visit_SM9 =  total_unit_SM9/no_of_visits_SM9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_AQ_Apr_LS_SM_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_AQ_Apr_LS_SM_TXN a 
left join  spdtmp7.VB_AQ_Apr_LS_SM3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_SM6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_SM9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_AQ_Apr_LS_SM3_TXN;
proc delete data=spdtmp7.VB_AQ_Apr_LS_SM6_TXN;
proc delete data=spdtmp7.VB_AQ_Apr_LS_SM9_TXN;



/* Max_Dataprep */



/*Getting Max Transactions of Lifestyle Acquisiton customer base (Model)*/

data spdtmp7.VB_AQ_Apr_LS_MX_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_dt_wid<=20170331 and txn_dt_wid >= 20160401 and LMG_concept_name="Max" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from;*/
/*quit;*/

/*all metrics ls all customers*/

proc sql;
create table spdtmp7.VB_AQ_Apr_LS_MX_TXN (compress=yes) as
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
		   
from spdtmp7.VB_AQ_Apr_LS_MX_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_AQ_Apr_LS_MX_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_MX_TXN;
format start_date_MX ddmmyys10.;
format end_date_MX ddmmyys10.;
recency_MX=intck('day',end_date_MX,'31Mar2017'd);
active_time_MX=intck('day',start_date_MX,end_date_MX);
avg_units_per_txn_MX = total_unit_MX/no_of_txn_MX;
avg_units_per_visit_MX =  total_unit_MX/no_of_visits_MX;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle Acquisiton customer base*/

data spdtmp7.VB_AQ_Apr_LS_MX3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20170101 and txn_dt_wid<=20170331 and LMG_concept_name="Max" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_Apr_LS_MX3_TXN(compress=yes) as
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

from spdtmp7.VB_AQ_Apr_LS_MX3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_AQ_Apr_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_AQ_Apr_LS_MX3_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_MX3_TXN;
format start_date_MX3 ddmmyys10.;
format end_date_MX3 ddmmyys10.;
recency_MX3=intck('day',end_date_MX3,'31Mar2017'd);
active_time_MX3=intck('day',start_date_MX3,end_date_MX3);
avg_units_per_txn_MX3 = total_unit_MX3/no_of_txn_MX3;
avg_units_per_visit_MX3 =  total_unit_MX3/no_of_visits_MX3;
run;

/*6months*/


data spdtmp7.VB_AQ_Apr_LS_MX6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20161001 and txn_dt_wid<=20170331 and LMG_concept_name="Max" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_AQ_Apr_LS_MX6_TXN(compress=yes) as
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
from spdtmp7.VB_AQ_Apr_LS_MX6_TXN

group by LMG_MEM_CARD_Number;

quit;


data spdtmp7.VB_AQ_Apr_LS_MX6_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_MX6_TXN;
format start_date_MX6 ddmmyys10.;
format end_date_MX6 ddmmyys10.;
recency_MX6=intck('day',end_date_MX6,'31Mar2017'd);
active_time_MX6=intck('day',start_date_MX6,end_date_MX6);
avg_units_per_txn_MX6 = total_unit_MX6/no_of_txn_MX6;
avg_units_per_visit_MX6 =  total_unit_MX6/no_of_visits_MX6;
run;

/*9months*/

data spdtmp7.VB_AQ_Apr_LS_MX9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_AQ_Apr_LS_TXN;
where txn_Dt_wid>=20160701 and txn_dt_wid<=20170331 and LMG_concept_name="Max" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_AQ_Apr_LS_MX9_TXN(compress=yes) as
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

from spdtmp7.VB_AQ_Apr_LS_MX9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_AQ_Apr_LS_MX9_TXN(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_MX9_TXN;
format start_date_MX9 ddmmyys10.;
format end_date_MX9 ddmmyys10.;
recency_MX9=intck('day',end_date_MX9,'31Mar2017'd);
active_time_MX9=intck('day',start_date_MX9,end_date_MX9);
avg_units_per_txn_MX9 = total_unit_MX9/no_of_txn_MX9;
avg_units_per_visit_MX9 =  total_unit_MX9/no_of_visits_MX9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_AQ_Apr_LS_MX_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_AQ_Apr_LS_MX_TXN a 
left join  spdtmp7.VB_AQ_Apr_LS_MX3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_MX6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_MX9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_AQ_Apr_LS_MX3_TXN;
proc delete data=spdtmp7.VB_AQ_Apr_LS_MX6_TXN;
proc delete data=spdtmp7.VB_AQ_Apr_LS_MX9_TXN;


/* All_Dataprep */






proc sql; 
create table spdtmp7.VB_AQ_Apr_LS_Alldata (compress=yes) as
select a.*,c.*,d.*,e.*,f.*,g.*,h.* from spdtmp7.VB_AQ_Apr_LMG_TXN_Overall a 
left join spdtmp7.VB_AQ_Apr_LS_SH_TXN_Overall c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_HC_TXN_Overall d on a.LMG_mem_card_number=d.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_HB_TXN_Overall e on a.LMG_mem_card_number=e.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_BS_TXN_Overall f on a.LMG_mem_card_number=f.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_SM_TXN_Overall g on a.LMG_mem_card_number=g.LMG_mem_card_number
left join spdtmp7.VB_AQ_Apr_LS_MX_TXN_Overall h on a.LMG_mem_card_number=h.LMG_mem_card_number;

quit;




proc delete data=spdtmp7.VB_AQ_Apr_LS_SH_TXN_Overall;run;
proc delete data=spdtmp7.VB_AQ_Apr_LS_HC_TXN_Overall;run;
proc delete data=spdtmp7.VB_AQ_Apr_LS_HB_TXN_Overall;run;
proc delete data=spdtmp7.VB_AQ_Apr_LS_BS_TXN_Overall;run;
proc delete data=spdtmp7.VB_AQ_Apr_LS_SM_TXN_Overall;run;
proc delete data=spdtmp7.VB_AQ_Apr_LS_MX_TXN_Overall;run;

 
/* Joining the customer demographic details table */

proc sql;
create table spdtmp7.VB_AQ_Apr_LS_Alldata1(compress=yes) as
select * from spdtmp7.VB_AQ_Apr_LS_Alldata a
left join SPDTMP7.VB_LS_CUST_DETL_LMG_AE_1 b
on a.LMG_MEM_CARD_NUMBER  = b.LMG_MEM_CARD_NUMBER;
quit;

/*proc means data=spdtmp7.VB_AQ_Apr_LS_Alldata1;*/
/*run;*/



/* IMPUTATION */



/*Missing Value imputation*/

data spdtmp7.VB_AQ_Apr_LS_Alldata2(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_Alldata1 ;
Format age_group $50.0;
Format age_group $50.0;
if age>0 and age <=10 then age_group = "ag1";
else if age>10 and age <=18 then age_group = "ag2";
else if age>19 and age <=25 then age_group = "ag3";
else if age>25 and age<=35 then age_group = "ag4";
else if age>35 and age <=50 then age_group = "ag5";
else if age>50 and age<=75 then age_group = "ag6";
else if age>75 then age_group = "ag7";
else age_group = "NA";
run;



data spdtmp7.VB_AQ_Apr_LS_Alldata_11 (compress= yes);
set spdtmp7.VB_AQ_Apr_LS_Alldata2;
where age_group<> "NA";
run;


proc freq data=spdtmp7.VB_AQ_Apr_LS_Alldata_11;
table age_group;
run;

proc delete data=spdtmp7.VB_AQ_Apr_LS_Alldata_11;run;



data spdtmp7.VB_AQ_Apr_LS_Alldata3 (compress= yes);
set spdtmp7.VB_AQ_Apr_LS_Alldata2;
Rand_no = ranuni(123);

if age_group = "NA" and Rand_no <=0.0063 then age_group = "ag1";
else if age_group = "NA" and Rand_no > 0.0063 and Rand_no <= 0.0115 then age_group = "ag2";
else if age_group = "NA" and Rand_no > 0.0115 and Rand_no <= 0.0997 then age_group = "ag3";
else if age_group = "NA" and Rand_no > 0.0997 and Rand_no <= 0.5680 then age_group = "ag4";
else if age_group = "NA" and Rand_no > 0.5680 and Rand_no <= 0.9311 then age_group = "ag5";
else if age_group = "NA" and Rand_no > 0.9311 and Rand_no <= 0.9989 then age_group = "ag6";
else if age_group = "NA" and Rand_no > 0.9989 and Rand_no <= 1.00 then age_group = "ag7";

run;

/*proc freq data=spdtmp7.VB_AQ_Apr_LS_TXN_Overall;*/
/*table age_group;*/
/*run;*/


data spdtmp7.VB_AQ_Apr_LS_Alldata4(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_Alldata3;
if sex_mf_name="" or sex_mf_name="Unspecified"
then sex_mf_name="NA";
run;


/*data spdtmp7.VB_AQ_Apr_LS_TXN_Overall_11(compress= yes);*/
/*set spdtmp7.VB_AQ_Apr_LS_Alldata4;*/
/*where sex_mf_name<>"NA";*/
/*run;*/
/**/
/**/
/*proc freq data= spdtmp7.VB_AQ_Apr_LS_TXN_Overall_11;*/
/*tables sex_mf_name;*/
/*run;*/
/**/
/*proc delete data = spdtmp7.VB_AQ_Apr_LS_TXN_Overall_11;*/
/*run;*/


data spdtmp7.VB_AQ_Apr_LS_Alldata5 (compress= yes);
set spdtmp7.VB_AQ_Apr_LS_Alldata4;
Rand_no = ranuni(123);
if sex_mf_name = "NA" and Rand_no <=0.3173 then sex_mf_name = "F";
else if sex_mf_name = "NA" and Rand_no > 0.3173 and Rand_no <= 1 then sex_mf_name = "M";

run;

/*proc sql;*/
/*create table abc as*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_AQ_Apr_LS_TXN_Overall;*/
/*quit;*/

data spdtmp7.VB_AQ_Apr_LS_Alldata6(compress= yes);
set spdtmp7.VB_AQ_Apr_LS_Alldata5;
if cvm_nationality_group="" or cvm_nationality_group="Unspecified"
then cvm_nationality_group="NA";
run;


/*data spdtmp7.VB_AQ_Apr_LS_TXN_Overall_11(compress=yes);*/
/*set spdtmp7.VB_AQ_Apr_LS_Alldata6;*/
/*where cvm_nationality_group <> "NA";*/
/*run;*/
/**/
/*proc freq data=spdtmp7.VB_AQ_Apr_LS_TXN_Overall_11;*/
/*table cvm_nationality_group;*/
/*run;*/
/**/
/*proc delete data= spdtmp7.VB_AQ_Apr_LS_TXN_Overall_11;*/
/*run;*/


data spdtmp7.VB_AQ_Apr_LS_Alldata7(compress= yes);
set spdtmp7.VB_AQ_Apr_LS_Alldata6;
Rand_no = ranuni(123);

if cvm_nationality_group="NA" and Rand_no <=0.1452 then  cvm_nationality_group= "Expat Arab";
else if cvm_nationality_group="NA" and Rand_no > 0.1452 and Rand_no <= .4570 then cvm_nationality_group = "ISC";
else if cvm_nationality_group="NA" and Rand_no > 0.4570 and Rand_no <= .5399 then cvm_nationality_group = "Local";
else if cvm_nationality_group="NA" and Rand_no > 0.5399 and Rand_no <= 1 then cvm_nationality_group = "Others";

run;


data spdtmp7.VB_AQ_Apr_LS_Alldata8(compress= yes);
set spdtmp7.VB_AQ_Apr_LS_Alldata7;
if lang_name ="" or lang_name="Unspecified"
then lang_name="NA";
run;

/*data spdtmp7.VB_AQ_Apr_LS_TXN_Overall_11(compress=yes);*/
/*set spdtmp7.VB_AQ_Apr_LS_Alldata8;*/
/*where lang_name <> "NA";*/
/*run;*/
/**/
/*proc freq data=spdtmp7.VB_AQ_Apr_LS_TXN_Overall_11;*/
/*table lang_name;*/
/*run;*/
/**/
/*proc delete data= spdtmp7.VB_AQ_Apr_LS_TXN_Overall_11;*/
/*run;*/


data spdtmp7.VB_AQ_Apr_LS_Alldata9(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_Alldata8;
Rand_no = ranuni(123);
if lang_name = "NA" and Rand_no <=0.1245 then lang_name = "Arabic";
else if lang_name = "NA" and Rand_no > 0.1245 and Rand_no <= 1 then lang_name = "English";

run;


/*Adding Lifestage variables*/



proc sql;
create table spdtmp7.VB_AQ_Apr_LS_Alldata10 (compress = yes) as
select * from spdtmp7.VB_AQ_Apr_LS_Alldata9 as a 
left join SPDTMP7.VB_LSTG_SGMT_AE as c
on a.LMG_MEM_CARD_NUMBER = c.LMG_MEM_CARD_NUMBER;
quit;



data spdtmp7.VB_AQ_Apr_LS_Alldata10(compress= yes);
set spdtmp7.VB_AQ_Apr_LS_Alldata10;
if lstage_sgmnt ="" or lstage_sgmnt= "8. Unclassified"
then lstage_sgmnt="NA";
run;

data spdtmp7.VB_AQ_Apr_LS_TXN_Overall_11(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_Alldata10;
where lstage_sgmnt <> "NA"  ;
run;

proc freq data= spdtmp7.VB_AQ_Apr_LS_TXN_Overall_11;
tables lstage_sgmnt;
run;

proc delete data= spdtmp7.VB_AQ_Apr_LS_TXN_Overall_11;run;


data spdtmp7.VB_AQ_Apr_LS_Alldata11(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_Alldata10;
Rand_no = ranuni(123);
if lstage_sgmnt = "NA" and Rand_no <=0.2596 then lstage_sgmnt = "1. Singles";
else if lstage_sgmnt = "NA" and Rand_no > 0.2596 and Rand_no <= 0.3500 then lstage_sgmnt = "2. Couples";
else if lstage_sgmnt = "NA" and Rand_no > 0.3500 and Rand_no <= 0.3826 then lstage_sgmnt = "3. Family w. Baby";
else if lstage_sgmnt = "NA" and Rand_no > 0.3826 and Rand_no <= 0.5974 then lstage_sgmnt = "4. Family w. Kids";
else if lstage_sgmnt = "NA" and Rand_no > 0.5974 and Rand_no <= 0.6271 then lstage_sgmnt = "5. Family w. Teen";
else if lstage_sgmnt = "NA" and Rand_no > 0.6271 and Rand_no <= 0.8532 then lstage_sgmnt = "6. Small Family";
else if lstage_sgmnt = "NA" and Rand_no > 0.8532 and Rand_no <= 1 then lstage_sgmnt = "7. Large Family";

run;




data spdtmp7.VB_AQ_Apr_LS_Alldata12(compress=yes);
set spdtmp7.VB_AQ_Apr_LS_Alldata11;
           /* Age Dummy */
  if age_group = "ag1" then age_grp_1_dummy = 1; else age_grp_1_dummy = 0;
  if age_group = "ag2" then age_grp_2_dummy = 1; else age_grp_2_dummy = 0;
  if age_group = "ag3" then age_grp_3_dummy = 1; else age_grp_3_dummy = 0;
  if age_group = "ag4" then age_grp_4_dummy = 1; else age_grp_4_dummy = 0;
  if age_group = "ag5" then age_grp_5_dummy = 1; else age_grp_5_dummy = 0;
  if age_group = "ag6" then age_grp_6_dummy= 1; else age_grp_6_dummy = 0;

                 /*Nationality Dummy*/
  if CVM_Nationality_group = "Local" then Local_nat_dummy = 1; else Local_nat_dummy = 0;
  if CVM_Nationality_group = "Expat Arab" then Expat_Arab_nat_dummy = 1; else Expat_Arab_nat_dummy = 0;
  if CVM_Nationality_group = "ISC" then  ISC_nat_dummy = 1; else ISC_nat_dummy = 0;
    
                 /*Gender Dummy */
  if SEX_MF_NAME = "M" then Gender_M_dummy = 1; else Gender_M_dummy = 0;

  				/*language dummy */
  if lang_name = "Arabic" then lang_Arabic_dummy = 1; else lang_Arabic_dummy = 0;

       /* Lsegmnt dummy */
  Lstg_sgmnt_1 = (Lstage_Sgmnt = "1. Singles");
  Lstg_sgmnt_2 = (Lstage_Sgmnt = "2. Couples");
  Lstg_sgmnt_3 = (Lstage_Sgmnt = "3. Family w. Baby");
  Lstg_sgmnt_4 = (Lstage_Sgmnt = "4. Family w. Kids");
  Lstg_sgmnt_5 = (Lstage_Sgmnt = "5. Family w. Teen");
  Lstg_sgmnt_6 = (Lstage_Sgmnt = "6. Small Family");
 
       
run;





/* Final Dataset */



Data spdtmp7.VB_AQ_Apr_LS_Alldata13 (compress=yes);
set spdtmp7.VB_AQ_Apr_LS_Alldata12;


Rev_SH_perc = sum_revenue_aed_SH/sum_revenue_aed_lmg;
Rev_HC_perc = sum_revenue_aed_HC/sum_revenue_aed_lmg;
Rev_HB_perc = sum_revenue_aed_HB/sum_revenue_aed_lmg;
Rev_SM_perc = sum_revenue_aed_SM/sum_revenue_aed_lmg;
Rev_MX_perc = sum_revenue_aed_MX/sum_revenue_aed_lmg;
Rev_BS_perc = sum_revenue_aed_BS/sum_revenue_aed_lmg;


Units_SH_perc = total_unit_SH/total_unit_lmg;
Units_HC_perc = total_unit_HC/total_unit_lmg;
Units_HB_perc = total_unit_HB/total_unit_lmg;
Units_BS_perc = total_unit_BS/total_unit_lmg;
Units_MX_perc = total_unit_MX/total_unit_lmg;
Units_SM_perc = total_unit_SM/total_unit_lmg;


run;


proc stdize data=spdtmp7.VB_AQ_Apr_LS_Alldata13 OUT=spdtmp7.VB_AQ_Apr_LS_Alldata14 (compress=yes)  reponly missing=0;

run; 


proc means data= spdtmp7.VB_AQ_Apr_LS_Alldata14 max min;
run;


proc delete data= spdtmp7.VB_AQ_Apr_LS_Alldata13; run;
proc delete data= spdtmp7.VB_AQ_Apr_LS_Alldata12; run;
proc delete data= spdtmp7.VB_AQ_Apr_LS_Alldata11; run;
proc delete data= spdtmp7.VB_AQ_Apr_LS_Alldata10; run;
proc delete data= spdtmp7.VB_AQ_Apr_LS_Alldata9;run;
proc delete data= spdtmp7.VB_AQ_Apr_LS_Alldata8;run;
proc delete data= spdtmp7.VB_AQ_Apr_LS_Alldata7;run;
proc delete data= spdtmp7.VB_AQ_Apr_LS_Alldata6;run;
proc delete data= spdtmp7.VB_AQ_Apr_LS_Alldata5;run;
proc delete data= spdtmp7.VB_AQ_Apr_LS_Alldata4;run;
proc delete data= spdtmp7.VB_AQ_Apr_LS_Alldata3;run;
proc delete data= spdtmp7.VB_AQ_Apr_LS_Alldata2;run;



proc logistic  
     inmodel = spdtmp7.VB_AQ_LS_Train_scores;    /* Use the outmodel file from Model_Training here */ 
     score data = spdtmp7.VB_AQ_Apr_LS_Alldata14
	 Out  = spdtmp7.VB_AQ_LS_Aprscr (compress =yes);
run; 



 data xxx (Compress=yes);
      set spdtmp7.sd_txn_wb ;
  	   where TXN_DT_WID >= 20170401 and TXN_DT_WID<= 20170431 and LMG_CONCEPT_NAME = "Lifestyle" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;
	   Bought_flag = 1;
 run;


 proc sql;
 create table yyy as 
 select distinct lmg_mem_card_number, bought_flag from xxx;
 quit;


proc sql;
create table zzz(compress=yes) as
select a.lmg_mem_card_number,a.P_1, b.Bought_flag from spdtmp7.VB_AQ_LS_Aprscr a
left join yyy b
on a.lmg_mem_card_number = b.lmg_mem_card_number;

quit;

Data zzz1;
set zzz;
if bought_flag = . then bought_flag = 0;
pred_bought_flag = ( P_1 >= 0.008);

run;


proc freq data= zzz1;
table Bought_flag * pred_bought_flag;
run;










