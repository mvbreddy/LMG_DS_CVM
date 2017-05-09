%include'/home/unxsrv/code/Automated_Solutions/Libnames/LIBNAMES.sas';




data spdtmp7.sd_hc_txn_all_may;
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20160501 and txn_dt_wid<=20170430 and Lmg_concept_name="Home center";
run;
/*subsetting data*/
data spdtmp7.sd_hc_activemay;
set spdtmp7.sd_hc_txn_all_may (keep= lmg_mem_card_number txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued);
where units >0 and revenue_aed >0 and base_points_accrued >0;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;

run;


proc sql ;
create table x as
select count (distinct LMG_mem_card_number) from spdtmp7.sd_hc_activemay;
quit;


proc sql;
create table spdtmp7.sd_hc_activemay (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed, 
           count(distinct date) as no_of_visits, 
         count(distinct invoice_number) as no_of_txn, 
           max(date) as end_date, 
           min(date) as start_date,
         count(distinct item_code) as distinct_prod, 
           sum(units) as total_unit, 
           avg(base_points_accrued) as avg_points 
from spdtmp7.sd_hc_activemay

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_activemay(compress=yes);
set spdtmp7.sd_hc_activemay;
format start_date ddmmyys10.;
format end_date ddmmyys10.;
recency=intck('day',end_date,'30Apr2017'd);
active_time=intck('day',start_date,end_date);
avg_units_per_txn = total_unit/no_of_txn;
avg_units_per_visit =  total_unit/no_of_visits;
run;



/*cust detl table*/


data spdtmp7.sd_hc_cust_may (Compress=yes keep= LMG_MEM_CARD_NUMBER SEX_MF_NAME  
            LANG_NAME  AGE LMG_EFFECTIVE_POINTS CVM_Nationality_group  );
      set sascrm.CUST_DETL_LMG_AE ;
run;


proc sql;
Create Table spdtmp7.sd_hc_activemay(compress=yes) as 
select a.*,b.* from spdtmp7.sd_hc_activemay a
left join spdtmp7.sd_hc_cust_may b
on a.LMG_MEM_CARD_NUMBER  = b.LMG_MEM_CARD_NUMBER;
Quit;


proc means data=spdtmp7.sd_hc_txn_cust_may;
run;

