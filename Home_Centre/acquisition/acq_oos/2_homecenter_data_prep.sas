/*Table for wb cust base all obs*/

proc sql;
create table spdtmp7.sd_txn_acoos_all(compress=yes) as
select a.*,b.* from spdtmp7.sd_hc_txn_ac_cust_oos a left join spdtmp7.sd_txn_wb b
on a.LMG_mem_Card_number=b.LMG_mem_card_number;
quit;

/*acoosq customers*/

data spdtmp7.sd_hc_txn_acoos(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_acoos_all;
where txn_dt_wid>=20150301 and txn_dt_wid<=20160229 and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table abc(compress=yes) as 
select count(distinct LMG_mem_Card_number), max(txn_dt_wid) from spdtmp7.sd_hc_txn_acoos;
quit;


/*all metrices hc all customers*/


proc sql;
create table spdtmp7.sd_hc_txn_acoos (compress=yes) as
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
from spdtmp7.sd_hc_txn_acoos
group by LMG_MEM_CARD_Number;
quit;


data spdtmp7.sd_hc_txn_acoos (compress=yes);
set spdtmp7.sd_hc_txn_acoos;
format start_date ddmmyys10.;
format end_date ddmmyys10.;
recency=intck('day',end_date,'29Feb2016'd);
acoostive_time=intck('day',start_date,end_date);
avg_units_per_txn = total_unit/no_of_txn;
avg_units_per_visit =  total_unit/no_of_visits;
run;










/*joining customer detls table*/



proc sql;
Create Table spdtmp7.sd_hc_txn_acoos (compress=yes) as 
select a.*,b.SEX_MF_NAME,b.AGE,b.LMG_EFFECTIVE_POINTS,b.CVM_Nationality_group from spdtmp7.sd_hc_txn_acoos a
left join sascrm.CUST_DETL_LMG_AE b
on a.LMG_MEM_CARD_NUMBER  = b.LMG_MEM_CARD_NUMBER;
Quit;


proc means data=spdtmp7.sd_hc_txn_acoos;
run;


