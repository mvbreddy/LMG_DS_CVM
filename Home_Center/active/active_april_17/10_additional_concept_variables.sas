/*splash*/

data spdtmp7.sd_hc_txn_final6_aprsp(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set sascrm.tn_itm_rev_ae;
where txn_Dt_wid>=20170401 and txn_dt_wid<=20170331 and lmg_concept_name="Splash"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_final6_aprsp (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_sp, 
           count(distinct date) as no_of_visits_sp, 
         count(distinct invoice_number) as no_of_txn_sp, 
           max(date) as end_date_sp, 
           min(date) as start_date_sp,
         count(distinct item_code) as distinct_prod_sp, 
           sum(units) as total_unit_sp, 
           sum(base_points_accrued) as total_points_sp,
		   sum(retail_cost_1_Aed) as sum_cost_1_sp,
sum(retail_cost_2_Aed) as sum_cost_2_sp
from spdtmp7.sd_hc_txn_final6_aprsp

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_final6_aprsp(compress=yes);
set spdtmp7.sd_hc_txn_final6_aprsp;
format start_date_sp ddmmyys10.;
format end_date_sp ddmmyys10.;
recency_sp=intck('day',end_date_sp,'31Mar2017'd);
active_time_sp=intck('day',start_date_sp,end_date_sp);
avg_units_per_txn_sp = total_unit_sp/no_of_txn_sp;
avg_units_per_visit_sp =  total_unit_sp/no_of_visits_sp;
run;



/*max*/




data spdtmp7.sd_hc_txn_final6_aprmx(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set sascrm.tn_itm_rev_ae;
where txn_Dt_wid>=20170401 and txn_dt_wid<=20170430 and lmg_concept_name="Max"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_final6_aprmx (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_mx, 
           count(distinct date) as no_of_visits_mx, 
         count(distinct invoice_number) as no_of_txn_mx, 
           max(date) as end_date_mx, 
           min(date) as start_date_mx,
         count(distinct item_code) as distinct_prod_mx, 
           sum(units) as total_unit_mx, 
           sum(base_points_accrued) as total_points_mx,
		   sum(retail_cost_1_Aed) as sum_cost_1_mx,
sum(retail_cost_2_Aed) as sum_cost_2_mx
from spdtmp7.sd_hc_txn_final6_aprmx

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_final6_aprmx(compress=yes);
set spdtmp7.sd_hc_txn_final6_aprmx;
format start_date_mx ddmmyys10.;
format end_date_mx ddmmyys10.;
recency_mx=intck('day',end_date_mx,'31Mar2017'd);
active_time_mx=intck('day',start_date_mx,end_date_mx);
avg_units_per_txn_mx = total_unit_mx/no_of_txn_mx;
avg_units_per_visit_mx =  total_unit_mx/no_of_visits_mx;
run;


/*shoemart*/



data spdtmp7.sd_hc_txn_final6_aprsm(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set sascrm.tn_itm_rev_ae;
where txn_Dt_wid>=20170401 and txn_dt_wid<=20170430 and lmg_concept_name="Shoemart"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_final6_aprsm (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_sm, 
           count(distinct date) as no_of_visits_sm, 
         count(distinct invoice_number) as no_of_txn_sm, 
           max(date) as end_date_sm, 
           min(date) as start_date_sm,
         count(distinct item_code) as distinct_prod_sm, 
           sum(units) as total_unit_sm, 
           sum(base_points_accrued) as total_points_sm,
		   sum(retail_cost_1_Aed) as sum_cost_1_sm,
sum(retail_cost_2_Aed) as sum_cost_2_sm
from spdtmp7.sd_hc_txn_final6_aprsm

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_final6_aprsm(compress=yes);
set spdtmp7.sd_hc_txn_final6_aprsm;
format start_date_sm ddmmyys10.;
format end_date_sm ddmmyys10.;
recency_sm=intck('day',end_date_sm,'31Mar2017'd);
active_time_sm=intck('day',start_date_sm,end_date_sm);
avg_units_per_txn_sm = total_unit_sm/no_of_txn_sm;
avg_units_per_visit_sm =  total_unit_sm/no_of_visits_sm;
run;



proc sql;
create table spdtmp7.sd_hc_txn_final6_apr (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.sd_hc_txn_final6_apr a left join spdtmp7.sd_hc_txn_final6_aprsp b on a.LMG_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.sd_hc_txn_final6_aprsm c on a.LMG_mem_card_number=c.LMG_mem_card_number left join spdtmp7.sd_hc_txn_final6_aprmx d on a.LMG_mem_card_number=d.LMG_mem_card_number
;
quit;


proc means data=spdtmp7.sd_hc_txn_final6_apr;
run;