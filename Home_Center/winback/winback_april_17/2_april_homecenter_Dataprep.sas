/*Table for wb cust base all obs*/

proc sql;
create table spdtmp7.sd_txn_wbapr_all(compress=yes) as
select a.*,b.* from spdtmp7.sd_hc_txn_wb_cust_apr a left join spdtmp7.sd_txn_wb b
on a.LMG_mem_Card_number=b.LMG_mem_card_number;
quit;

/*Home center winback customers*/

data spdtmp7.sd_hc_txn_wbapr(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbapr_all;
where txn_dt_wid >=20150401 and txn_dt_wid<=20160331 and LMG_concept_name="Home center" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table abc(compress=yes) as 
select count(distinct LMG_mem_Card_number) from spdtmp7.sd_hc_txn_wbapr;
quit;


/*all metrices hc all customers*/


proc sql;
create table spdtmp7.sd_hc_txn_wbapr (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed, 
           count(distinct date) as no_of_visits, 
         count(distinct invoice_number) as no_of_txn, 
           max(date) as end_date, 
           min(date) as start_date,
         count(distinct item_code) as distinct_prod, 
           sum(units) as total_unit, 
           sum(base_points_accrued) as total_points ,
		   sum(retail_cost_1_aed) as sum_cost_1,
		   sum(retail_cost_2_aed) as sum_cost_2
from spdtmp7.sd_hc_txn_wbapr
group by LMG_MEM_CARD_Number;
quit;


data spdtmp7.sd_hc_txn_wbapr (compress=yes);
set spdtmp7.sd_hc_txn_wbapr;
format start_date ddmmyys10.;
format end_date ddmmyys10.;
recency=intck('day',end_date,'31Mar2016'd);
active_time=intck('day',start_date,end_date);
avg_units_per_txn = total_unit/no_of_txn;
avg_units_per_visit =  total_unit/no_of_visits;
run;


/*joining the customer table */

proc sql;
Create Table spdtmp7.sd_hc_txn_wbapr (compress=yes) as 
select a.*,b.SEX_MF_NAME,b.AGE,b.LMG_EFFECTIVE_POINTS,b.CVM_Nationality_group from spdtmp7.sd_hc_txn_wbapr a
left join sascrm.CUST_DETL_LMG_AE b
on a.LMG_MEM_CARD_NUMBER  = b.LMG_MEM_CARD_NUMBER;
Quit;





