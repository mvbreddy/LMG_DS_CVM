/*LMG_ALL*/

data spdtmp7.sd_hc_activemay_lmg;
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20160501 and txn_dt_wid<=20170430 ;
run;



data spdtmp7.sd_hc_activemay_lmg;
set spdtmp7.sd_hc_activemay_lmg (keep= lmg_mem_card_number txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued);
where units >0 and revenue_aed >0 and base_points_accrued >0;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;

run;



proc sql;
create table spdtmp7.sd_hc_activemay_lmg (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmg, 
           count(distinct date) as no_of_visits_lmg, 
         count(distinct invoice_number) as no_of_txn_lmg, 
           max(date) as end_date_lmg, 
           min(date) as start_date_lmg,
         count(distinct item_code) as distinct_prod_lmg, 
           sum(units) as total_unit_lmg, 
           avg(base_points_accrued) as avg_points_lmg 
from spdtmp7.sd_hc_activemay_lmg

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_activemay_lmg(compress=yes);
set spdtmp7.sd_hc_activemay_lmg;
format start_date_lmg ddmmyys10.;
format end_date_lmg ddmmyys10.;
recency_lmg=intck('day',end_date_lmg,'30Apr2017'd);
active_time_lmg=intck('day',start_date_lmg,end_date_lmg);
avg_units_per_txn_lmg = total_unit_lmg/no_of_txn_lmg;
avg_units_per_visit_lmg =  total_unit_lmg/no_of_visits_lmg;
run;



proc sql; 
create table spdtmp7.sd_hc_activemay as
select a.*,b.* from spdtmp7.sd_hc_activemay a left join  spdtmp7.sd_hc_activemay_lmg b on a.Lmg_mem_card_number=b.LMG_mem_card_number;
run;

proc means data=spdtmp7.sd_hc_activemay;
run;