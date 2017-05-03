/*LMG_ALL*/

data spdtmp7.sd_hc_txn_wbapr0(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbapr_all;
where txn_Dt_wid>=20150401 and txn_dt_wid<=20160331  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbapr0 (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmg, 
           count(distinct date) as no_of_visits_lmg, 
         count(distinct invoice_number) as no_of_txn_lmg, 
           max(date) as end_date_lmg, 
           min(date) as start_date_lmg,
         count(distinct item_code) as distinct_prod_lmg, 
           sum(units) as total_unit_lmg, 
          sum(base_points_accrued) as total_points_lmg ,
		   sum(retail_cost_1_aed) as sum_cost_1_LMG,
		   sum(retail_cost_2_aed) as sum_cost_2_LMG,
		   count(distinct LMG_concept_name) as distinct_concept
from spdtmp7.sd_hc_txn_wbapr0

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_wbapr0(compress=yes);
set spdtmp7.sd_hc_txn_wbapr0;
format start_date_lmg ddmmyys10.;
format end_date_lmg ddmmyys10.;
recency_lmg=intck('day',end_date_lmg,'31Mar2016'd);
active_time_lmg=intck('day',start_date_lmg,end_date_lmg);
avg_units_per_txn_lmg = total_unit_lmg/no_of_txn_lmg;
avg_units_per_visit_lmg =  total_unit_lmg/no_of_visits_lmg;
run;


/*3months*/

data spdtmp7.sd_hc_txn_wbapr1(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbapr_all;
where txn_Dt_wid>=20160101 and txn_dt_wid<=20160331 and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbapr1(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmg3, 
           count(distinct date) as no_of_visits_lmg3, 
         count(distinct invoice_number) as no_of_txn_lmg3, 
           max(date) as end_date_lmg3, 
           min(date) as start_date_lmg3,
         count(distinct item_code) as distinct_prod_lmg3, 
           sum(units) as total_unit_lmg3, 
           sum(base_points_accrued) as total_points_lmg3 ,
		   sum(retail_cost_1_aed) as sum_cost_1_lmg3,
		   sum(retail_cost_2_aed) as sum_cost_2_lmg3,
		   count(distinct Lmg_concept_name) as distinct_concept_lmg3
from spdtmp7.sd_hc_txn_wbapr1

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_wbapr1(compress=yes);
set spdtmp7.sd_hc_txn_wbapr1;
format start_date_lmg3 ddmmyys10.;
format end_date_lmg3 ddmmyys10.;
recency_lmg3=intck('day',end_date_lmg3,'31Mar2017'd);
active_time_lmg3=intck('day',start_date_lmg3,end_date_lmg3);
avg_units_per_txn_lmg3 = total_unit_lmg3/no_of_txn_lmg3;
avg_units_per_visit_lmg3 =  total_unit_lmg3/no_of_visits_lmg3;
run;

/*6months*/

data spdtmp7.sd_hc_txn_wbapr2(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbapr_all;
where txn_Dt_wid>=20151001 and txn_dt_wid<=20160331 and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbapr2(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmg6, 
           count(distinct date) as no_of_visits_lmg6, 
         count(distinct invoice_number) as no_of_txn_lmg6, 
           max(date) as end_date_lmg6, 
           min(date) as start_date_lmg6,
         count(distinct item_code) as distinct_prod_lmg6, 
           sum(units) as total_unit_lmg6, 
           sum(base_points_accrued) as total_points_lmg6 ,
		   sum(retail_cost_1_aed) as sum_cost_1_lmg6,
		   sum(retail_cost_2_aed) as sum_cost_2_lmg6,
		   count(distinct lmg_concept_name) as distinct_concept_lmg6
from spdtmp7.sd_hc_txn_wbapr2

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_wbapr2(compress=yes);
set spdtmp7.sd_hc_txn_wbapr2;
format start_date_lmg6 ddmmyys10.;
format end_date_lmg6 ddmmyys10.;
recency_lmg6=intck('day',end_date_lmg6,'31Mar2016'd);
active_time_lmg6=intck('day',start_date_lmg6,end_date_lmg6);
avg_units_per_txn_lmg6 = total_unit_lmg6/no_of_txn_lmg6;
avg_units_per_visit_lmg6 =  total_unit_lmg6/no_of_visits_lmg6;
run;


/*9 months*/


data spdtmp7.sd_hc_txn_wbapr3(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbapr_all;
where txn_Dt_wid>=20150701 and txn_dt_wid<=20160331  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbapr3(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmg9, 
           count(distinct date) as no_of_visits_lmg9, 
         count(distinct invoice_number) as no_of_txn_lmg9, 
           max(date) as end_date_lmg9, 
           min(date) as start_date_lmg9,
         count(distinct item_code) as distinct_prod_lmg9, 
           sum(units) as total_unit_lmg9, 
           sum(base_points_accrued) as total_points_lmg9 ,
		   sum(retail_cost_1_aed) as sum_cost_1_lmg9,
		   sum(retail_Cost_2_aed) as sum_cost_2_lmg9,
		   count(distinct Lmg_concept_name) as distinct_concept_lmg9

from spdtmp7.sd_hc_txn_wbapr3

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_wbapr3(compress=yes);
set spdtmp7.sd_hc_txn_wbapr3;
format start_date_lmg9 ddmmyys10.;
format end_date_lmg9 ddmmyys10.;
recency_lmg9=intck('day',end_date_lmg9,'31Mar2016'd);
active_time_lmg9=intck('day',start_date_lmg9,end_date_lmg9);
avg_units_per_txn_lmg9 = total_unit_lmg9/no_of_txn_lmg9;
avg_units_per_visit_lmg9 =  total_unit_lmg9/no_of_visits_lmg9;
run;

/*join all tables*/

proc sql;
create table spdtmp7.sd_hc_txn_wbapr (compress=yes) as
select a.*,b.*,c.*,d.*,e.* from spdtmp7.sd_hc_txn_wbapr a left join spdtmp7.sd_hc_txn_wbapr0 b on a.LMG_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.sd_hc_txn_wbapr1 c on a.LMG_mem_card_number=c.LMG_mem_card_number left join spdtmp7.sd_hc_txn_wbapr2 d
on a.LMG_mem_card_number=d.LMG_mem_card_number left join spdtmp7.sd_hc_txn_wbapr3 e on a.LMG_mem_card_number=e.LMG_mem_card_number;
quit;

proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_wbapr ;
quit;


proc means data=spdtmp7.sd_hc_txn_wbapr;
run;

proc delete data=spdtmp7.sd_hc_txn_wbapr0;run;
proc delete data=spdtmp7.sd_hc_txn_wbapr1;run;
proc delete data=spdtmp7.sd_hc_txn_wbapr2;run;
proc delete data=spdtmp7.sd_hc_txn_wbapr3;run;
