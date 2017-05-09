


/*ls*/


data spdtmp7.sd_hc_txn_wbmaylscy(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbmay_all;
where txn_Dt_wid>=20160501 and txn_dt_wid<=20170430 and lmg_concept_name="Lifestyle"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbmaylscy (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lscy, 
           count(distinct date) as no_of_visits_lscy, 
         count(distinct invoice_number) as no_of_txn_lscy, 
           max(date) as end_date_lscy, 
           min(date) as start_date_lscy,
         count(distinct item_code) as distinct_prod_lscy, 
           sum(units) as total_unit_lscy, 
           sum(base_points_accrued) as total_points_lscy,
		   sum(retail_cost_1_Aed) as sum_cost_1_lscy,
sum(retail_cost_2_Aed) as sum_cost_2_lscy
from spdtmp7.sd_hc_txn_wbmaylscy

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_wbmaylscy(compress=yes);
set spdtmp7.sd_hc_txn_wbmaylscy;
format start_date_lscy ddmmyys10.;
format end_date_lscy ddmmyys10.;
recency_lscy=intck('day',end_date_lscy,'30Apr2017'd);
active_time_lscy=intck('day',start_date_lscy,end_date_lscy);
avg_units_per_txn_lscy = total_unit_lscy/no_of_txn_lscy;
avg_units_per_visit_lscy =  total_unit_lscy/no_of_visits_lscy;
run;

/*hb*/





data spdtmp7.sd_hc_txn_wbmayhbcy(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbmay_all;
where txn_Dt_wid>=20160501 and txn_dt_wid<=20170430 and lmg_concept_name="Home Box"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbmayhbcy (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_hbcy, 
           count(distinct date) as no_of_visits_hbcy, 
         count(distinct invoice_number) as no_of_txn_hbcy, 
           max(date) as end_date_hbcy, 
           min(date) as start_date_hbcy,
         count(distinct item_code) as distinct_prod_hbcy, 
           sum(units) as total_unit_hbcy, 
		   sum(retail_cost_1_aed) as sum_cost_1_hbcy,
		   sum(retail_cost_2_aed) as sum_cost_2_hbcy,
           sum(base_points_accrued) as total_points_hbcy 
from spdtmp7.sd_hc_txn_wbmayhbcy

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_wbmayhbcy(compress=yes);
set spdtmp7.sd_hc_txn_wbmayhbcy;
format start_date_hbcy ddmmyys10.;
format end_date_hbcy ddmmyys10.;
recency_hbcy=intck('day',end_date_hbcy,'30Apr2017'd);
active_time_hbcy=intck('day',start_date_hbcy,end_date_hbcy);
avg_units_per_txn_hbcy = total_unit_hbcy/no_of_txn_hbcy;
avg_units_per_visit_hbcy =  total_unit_hbcy/no_of_visits_hbcy;
run;

/*emax*/
data spdtmp7.sd_hc_txn_wbmayemcy(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbmay_all;
where txn_Dt_wid>=20160401 and txn_dt_wid<=20170331 and lmg_concept_name="Emax"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbmayemcy(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_emcy, 
           count(distinct date) as no_of_visits_emcy, 
         count(distinct invoice_number) as no_of_txn_emcy, 
           max(date) as end_date_emcy, 
           min(date) as start_date_emcy,
         count(distinct item_code) as distinct_prod_emcy, 
           sum(units) as total_unit_emcy, 
		   sum(retail_cost_1_aed) as sum_cost_1_emcy,
		   sum(retail_cost_2_aed) as sum_cost_2_emcy,
           sum(base_points_accrued) as total_points_emcy 
from spdtmp7.sd_hc_txn_wbmayemcy

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_wbmayemcy(compress=yes);
set spdtmp7.sd_hc_txn_wbmayemcy;
format start_date_emcy ddmmyys10.;
format end_date_emcy ddmmyys10.;
recency_emcy=intck('day',end_date_emcy,'30Apr2017'd);
active_time_emcy=intck('day',start_date_emcy,end_date_emcy);
avg_units_per_txn_emcy = total_unit_emcy/no_of_txn_emcy;
avg_units_per_visit_emcy =  total_unit_emcy/no_of_visits_emcy;
run;
/*bs*/

data spdtmp7.sd_hc_txn_wbmaybscy(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbmay_all;
where txn_Dt_wid>=20160501 and txn_dt_wid<=20170430 and lmg_concept_name="Babyshop"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbmaybscy (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_bscy, 
           count(distinct date) as no_of_visits_bscy, 
         count(distinct invoice_number) as no_of_txn_bscy, 
           max(date) as end_date_bscy, 
           min(date) as start_date_bscy,
         count(distinct item_code) as distinct_prod_bscy, 
           sum(units) as total_unit_bscy, 
		   sum(retail_cost_1_aed) as sum_cost_1_bscy,
		   sum(retail_cost_2_aed) as sum_cost_2_bscy,
           sum(base_points_accrued) as total_points_bscy 
from spdtmp7.sd_hc_txn_wbmaybscy

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_wbmaybscy(compress=yes);
set spdtmp7.sd_hc_txn_wbmaybscy;
format start_date_bscy ddmmyys10.;
format end_date_bscy ddmmyys10.;
recency_bscy=intck('day',end_date_bscy,'30Apr2017'd);
active_time_bscy=intck('day',start_date_bscy,end_date_bscy);
avg_units_per_txn_bscy = total_unit_bscy/no_of_txn_bscy;
avg_units_per_visit_bscy =  total_unit_bscy/no_of_visits_bscy;
run;


/*join all tables*/


proc sql;
create table spdtmp7.sd_hc_txn_wbmay (compress=yes) as
select a.*,b.*,c.*,d.*,e.* from spdtmp7.sd_hc_txn_wbmay a left join spdtmp7.sd_hc_txn_wbmaylscy b on a.LMG_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.sd_hc_txn_wbmayhbcy c on a.LMG_mem_card_number=c.LMG_mem_card_number left join spdtmp7.sd_hc_txn_wbmayemcy d on a.LMG_mem_card_number=d.LMG_mem_card_number
left join spdtmp7.sd_hc_txn_wbmaybscy e
on a.LMG_mem_Card_number=e.LMG_mem_card_number;
quit;

proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_final1;
quit;




proc means data=spdtmp7.sd_hc_txn_wbmay;
run;

proc delete data=spdtmp7.sd_hc_txn_wbmaylscy;run;
proc delete data= spdtmp7.sd_hc_txn_wbmayhbcy;run;
proc delete data=spdtmp7.sd_hc_txn_wbmayemcy;run;
proc delete data=spdtmp7.sd_hc_txn_wbmaybscy;run;






