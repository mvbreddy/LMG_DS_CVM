/*LMG_ALL*/

data spdtmp7.sd_hc_txn_wbaprcy0(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbapr_all;
where txn_Dt_wid>=20160401 and txn_dt_wid<=20170331  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbaprcy0 (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmgcy, 
           count(distinct date) as no_of_visits_lmgcy, 
         count(distinct invoice_number) as no_of_txn_lmgcy, 
           max(date) as end_date_lmgcy, 
           min(date) as start_date_lmgcy,
         count(distinct item_code) as distinct_prod_lmgcy, 
           sum(units) as total_unit_lmgcy, 
          sum(base_points_accrued) as total_points_lmgcy ,
		   sum(retail_cost_1_aed) as sum_cost_1_lmgcy,
		   sum(retail_cost_2_aed) as sum_cost_2_lmgcy,
		   count(distinct LMG_concept_name) as distinct_concept
from spdtmp7.sd_hc_txn_wbaprcy0

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_wbaprcy0(compress=yes);
set spdtmp7.sd_hc_txn_wbaprcy0;
format start_date_lmgcy ddmmyys10.;
format end_date_lmgcy ddmmyys10.;
recency_lmgcy=intck('day',end_date_lmgcy,'31Mar2017'd);
active_time_lmgcy=intck('day',start_date_lmgcy,end_date_lmgcy);
avg_units_per_txn_lmgcy = total_unit_lmgcy/no_of_txn_lmgcy;
avg_units_per_visit_lmgcy =  total_unit_lmgcy/no_of_visits_lmgcy;
run;


/*3months*/

data spdtmp7.sd_hc_txn_wbaprcy1(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbapr_all;
where txn_Dt_wid>=20170101 and txn_dt_wid<=20170331  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbaprcy1(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmgcy3, 
           count(distinct date) as no_of_visits_lmgcy3, 
         count(distinct invoice_number) as no_of_txn_lmgcy3, 
           max(date) as end_date_lmgcy3, 
           min(date) as start_date_lmgcy3,
         count(distinct item_code) as distinct_prod_lmgcy3, 
           sum(units) as total_unit_lmgcy3, 
           sum(base_points_accrued) as total_points_lmgcy3 ,
		   sum(retail_cost_1_aed) as sum_cost_1_lmgcy3,
		   sum(retail_cost_2_aed) as sum_cost_2_lmgcy3,
		   count(distinct Lmg_concept_name) as distinct_concept_lmgcy3
from spdtmp7.sd_hc_txn_wbaprcy1

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_wbaprcy1(compress=yes);
set spdtmp7.sd_hc_txn_wbaprcy1;
format start_date_lmgcy3 ddmmyys10.;
format end_date_lmgcy3 ddmmyys10.;
recency_lmgcy3=intck('day',end_date_lmgcy3,'31Mar2017'd);
active_time_lmgcy3=intck('day',start_date_lmgcy3,end_date_lmgcy3);
avg_units_per_txn_lmgcy3 = total_unit_lmgcy3/no_of_txn_lmgcy3;
avg_units_per_visit_lmgcy3 =  total_unit_lmgcy3/no_of_visits_lmgcy3;
run;

/*6months*/

data spdtmp7.sd_hc_txn_wbaprcy2(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbapr_all;
where txn_Dt_wid>=20161001 and txn_dt_wid<=20170331  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbaprcy2(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmgcy6, 
           count(distinct date) as no_of_visits_lmgcy6, 
         count(distinct invoice_number) as no_of_txn_lmgcy6, 
           max(date) as end_date_lmgcy6, 
           min(date) as start_date_lmgcy6,
         count(distinct item_code) as distinct_prod_lmgcy6, 
           sum(units) as total_unit_lmgcy6, 
           sum(base_points_accrued) as total_points_lmgcy6 ,
		   sum(retail_cost_1_aed) as sum_cost_1_lmgcy6,
		   sum(retail_cost_2_aed) as sum_cost_2_lmgcy6,
		   count(distinct lmg_concept_name) as distinct_concept_lmgcy6
from spdtmp7.sd_hc_txn_wbaprcy2

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_wbaprcy2(compress=yes);
set spdtmp7.sd_hc_txn_wbaprcy2;
format start_date_lmgcy6 ddmmyys10.;
format end_date_lmgcy6 ddmmyys10.;
recency_lmgcy6=intck('day',end_date_lmgcy6,'31Mar2017'd);
active_time_lmgcy6=intck('day',start_date_lmgcy6,end_date_lmgcy6);
avg_units_per_txn_lmgcy6 = total_unit_lmgcy6/no_of_txn_lmgcy6;
avg_units_per_visit_lmgcy6 =  total_unit_lmgcy6/no_of_visits_lmgcy6;
run;


/*9 months*/


data spdtmp7.sd_hc_txn_wbaprcy3(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbapr_all;
where txn_Dt_wid>=20160701 and txn_dt_wid<=20170331 and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbaprcy3(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmgcy9, 
           count(distinct date) as no_of_visits_lmgcy9, 
         count(distinct invoice_number) as no_of_txn_lmgcy9, 
           max(date) as end_date_lmgcy9, 
           min(date) as start_date_lmgcy9,
         count(distinct item_code) as distinct_prod_lmgcy9, 
           sum(units) as total_unit_lmgcy9, 
           sum(base_points_accrued) as total_points_lmgcy9 ,
		   sum(retail_cost_1_aed) as sum_cost_1_lmgcy9,
		   sum(retail_Cost_2_aed) as sum_cost_2_lmgcy9,
		   count(distinct Lmg_concept_name) as distinct_concept_lmgcy9

from spdtmp7.sd_hc_txn_wbaprcy3

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_wbaprcy3(compress=yes);
set spdtmp7.sd_hc_txn_wbaprcy3;
format start_date_lmgcy9 ddmmyys10.;
format end_date_lmgcy9 ddmmyys10.;
recency_lmgcy9=intck('day',end_date_lmgcy9,'31Mar2017'd);
active_time_lmgcy9=intck('day',start_date_lmgcy9,end_date_lmgcy9);
avg_units_per_txn_lmgcy9 = total_unit_lmgcy9/no_of_txn_lmgcy9;
avg_units_per_visit_lmgcy9 =  total_unit_lmgcy9/no_of_visits_lmgcy9;
run;

/*join all tables*/

proc sql;
create table spdtmp7.sd_hc_txn_wbapr (compress=yes) as
select a.*,b.*,c.*,d.*,e.* from spdtmp7.sd_hc_txn_wbapr a left join spdtmp7.sd_hc_txn_wbaprcy0 b on a.LMG_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.sd_hc_txn_wbaprcy1 c on a.LMG_mem_card_number=c.LMG_mem_card_number left join spdtmp7.sd_hc_txn_wbaprcy2 d
on a.LMG_mem_card_number=d.LMG_mem_card_number left join spdtmp7.sd_hc_txn_wbaprcy3 e on a.LMG_mem_card_number=e.LMG_mem_card_number;
quit;

proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_wbapr ;
quit;

proc delete data=spdtmp7.sd_hc_txn_wbaprcy0;
proc delete data=spdtmp7.sd_hc_txn_wbaprcy1;
proc delete data=spdtmp7.sd_hc_txn_wbaprcy2;
proc delete data=spdtmp7.sd_hc_txn_wbaprcy3;

