data spdtmp7.sd_hc_activemay_3;
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20170201 and txn_dt_wid<=20170430 and Lmg_concept_name="Home center";
run;

data spdtmp7.sd_hc_activemay_3;
set spdtmp7.sd_hc_activemay_3 (keep= lmg_mem_card_number txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued);
where units >0 and revenue_aed >0 and base_points_accrued >0;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;

run;



proc sql;
create table spdtmp7.sd_hc_activemay_3(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_3, 
           count(distinct date) as no_of_visits_3, 
         count(distinct invoice_number) as no_of_txn_3, 
           max(date) as end_date_3, 
           min(date) as start_date_3,
         count(distinct item_code) as distinct_prod_3, 
           sum(units) as total_unit_3, 
           avg(base_points_accrued) as avg_points_3 
from spdtmp7.sd_hc_activemay_3

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_activemay_3(compress=yes);
set spdtmp7.sd_hc_activemay_3;
format start_date_3 ddmmyys10.;
format end_date_3 ddmmyys10.;
recency_3=intck('day',end_date_3,'30Apr2017'd);
active_time_3=intck('day',start_date_3,end_date_3);
avg_units_per_txn_3 = total_unit_3/no_of_txn_3;
avg_units_per_visit_3 =  total_unit_3/no_of_visits_3;
run;

/*6months*/



data spdtmp7.sd_hc_activemay_6;
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20161101 and txn_dt_wid<=20170430 and Lmg_concept_name="Home center";
run;



data spdtmp7.sd_hc_activemay_6;
set spdtmp7.sd_hc_activemay_6 (keep= lmg_mem_card_number txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued);
where units >0 and revenue_aed >0 and base_points_accrued >0;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;

run;



proc sql;
create table spdtmp7.sd_hc_activemay_6(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_6, 
           count(distinct date) as no_of_visits_6, 
         count(distinct invoice_number) as no_of_txn_6, 
           max(date) as end_date_6, 
           min(date) as start_date_6,
         count(distinct item_code) as distinct_prod_6, 
           sum(units) as total_unit_6, 
           avg(base_points_accrued) as avg_points_6 
from spdtmp7.sd_hc_activemay_6

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_activemay_6(compress=yes);
set spdtmp7.sd_hc_activemay_6;
format start_date_6 ddmmyys10.;
format end_date_6 ddmmyys10.;
recency_6=intck('day',end_date_6,'30Apr2017'd);
active_time_6=intck('day',start_date_6,end_date_6);
avg_units_per_txn_6 = total_unit_6/no_of_txn_6;
avg_units_per_visit_6 =  total_unit_6/no_of_visits_6;
run;

/*9months*/

data spdtmp7.sd_hc_activemay_9;
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20160801 and txn_dt_wid<=20170430 and Lmg_concept_name="Home center";
run;



data spdtmp7.sd_hc_activemay_9;
set spdtmp7.sd_hc_activemay_9 (keep= lmg_mem_card_number txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued);
where units >0 and revenue_aed >0 and base_points_accrued >0;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;

run;



proc sql;
create table spdtmp7.sd_hc_activemay_9(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_9, 
           count(distinct date) as no_of_visits_9, 
         count(distinct invoice_number) as no_of_txn_9, 
           max(date) as end_date_9, 
           min(date) as start_date_9,
         count(distinct item_code) as distinct_prod_9, 
           sum(units) as total_unit_9, 
           avg(base_points_accrued) as avg_points_9 
from spdtmp7.sd_hc_activemay_9

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_activemay_9(compress=yes);
set spdtmp7.sd_hc_activemay_9;
format start_date_9 ddmmyys10.;
format end_date_9 ddmmyys10.;
recency_9=intck('day',end_date_9,'30Apr2017'd);
active_time_9=intck('day',start_date_9,end_date_9);
avg_units_per_txn_9 = total_unit_9/no_of_txn_9;
avg_units_per_visit_9 =  total_unit_9/no_of_visits_9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.sd_hc_activemay as
select a.*,b.*,c.*,d.* from spdtmp7.sd_hc_activemay a left join  spdtmp7.sd_hc_activemay_3 b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.sd_hc_activemay_6 c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.sd_hc_activemay_9 d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;

proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_94 ;
quit;

proc means data=spdtmp7.sd_hc_activemay;
run;
