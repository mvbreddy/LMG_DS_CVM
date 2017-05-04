








/*This part of the code creates a dataset of final Variables from Table VB_ALL_TN_ITM_REV_AE i.e. Data of all concepts
  This table needs to be joined with the Lifestyle Table*/



proc sql;
create table SPDTMP30.VB_ALL_TN_ITM_REV_AE_overall (compress=yes) as
select LMG_MEM_CARD_Number, 
		sum(revenue_aed) as LMG_sum_revenue_aed , 
		count(distinct date) as no_of_visits_LMG, 
	    count(distinct invoice_number) as no_of_txn_LMG, 		
		max(date) as end_date_LMG, 
		min(date) as start_date_LMG,
	    count(distinct item_code) as distinct_prod_LMG, 
		sum(units) as total_unit_LMG, 
		sum(base_points_accrued) as Total_points_LMG, 
		count(distinct LMG_CONCEPT_NAME) as concept_count_LMG
from SPDTMP30.VB_ALL_TN_ITM_REV_AE
 
group by LMG_MEM_CARD_Number;

quit;

data SPDTMP30.VB_ALL_TN_ITM_REV_AE_overall_1(compress=yes);
set SPDTMP30.VB_ALL_TN_ITM_REV_AE_overall;
format start_date_LMG ddmmyys10.;
format end_date_LMG ddmmyys10.;
active_time_LMG=intck('day',start_date_LMG,end_date_LMG);
avg_units_per_txn_LMG = total_unit_LMG/no_of_txn_LMG;
avg_units_per_visit_LMG =  total_unit_LMG/no_of_visits_LMG;
atv_LMG = LMG_sum_revenue_aed/no_of_txn_LMG;
run;


/*data SPDTMP30.VB_ALL_TN_ITM_REV_AE9(compress=yes);*/
/*set SPDTMP30.VB_ALL_TN_ITM_REV_AE (keep= lmg_mem_card_number lmg_concept_name txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued date);*/
/*where txn_dt_wid>=20150501 and txn_dt_wid<=20160131 ;*/
/**/
/*run;*/

proc sql;
create table SPDTMP30.VB_ALL_TN_ITM_REV_AE9_2 (compress=yes) as
select LMG_MEM_CARD_Number, 
		sum(revenue_aed) as LMG_sum_revenue_aed_9 , 
		count(distinct date) as no_of_visits_LMG9, 
	    count(distinct invoice_number) as no_of_txn_LMG9, 
		max(date) as end_date_LMG9, 
		min(date) as start_date_LMG9,
	    count(distinct item_code) as distinct_prod_LMG9, 
		sum(units) as total_unit_LMG9, 
		sum(base_points_accrued) as Total_points_LMG9,
		count(distinct LMG_CONCEPT_NAME) as concept_count_LMG9 

from SPDTMP30.VB_ALL_TN_ITM_REV_AE9
 
group by LMG_MEM_CARD_Number;

quit;

data SPDTMP30.VB_ALL_TN_ITM_REV_AE9_3(compress=yes);
set SPDTMP30.VB_ALL_TN_ITM_REV_AE9_2;
format start_date_LMG9 ddmmyys10.;
format end_date_LMG9 ddmmyys10.;
active_time_LMG9=intck('day',start_date_LMG9,end_date_LMG9);
avg_units_per_txn_LMG9 = total_unit_LMG9/no_of_txn_LMG9;
avg_units_per_visit_LMG9 =  total_unit_LMG9/no_of_visits_LMG9;
atv_LMG9 = LMG_sum_revenue_aed_9/no_of_txn_LMG9;
run;


/*data SPDTMP30.VB_ALL_TN_ITM_REV_AE6(compress=yes);*/
/*set SPDTMP30.VB_ALL_TN_ITM_REV_AE(keep= lmg_mem_card_number lmg_concept_name  txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued date);*/
/*where txn_dt_wid>=20150801 and txn_dt_wid<=20160131 ;*/
/**/
/*run;*/


proc sql;
create table SPDTMP30.VB_ALL_TN_ITM_REV_AE6_2new (compress=yes) as
select LMG_MEM_CARD_Number, 
        sum(revenue_aed) as LMG_sum_revenue_aed_6 , 
		count(distinct date) as no_of_visits_LMG6, 
		count(distinct invoice_number) as no_of_txn_LMG6, 
		max(date) as end_date_LMG6, min(date) as start_date_LMG6, 
		count(distinct item_code) as distinct_prod_LMG6, sum(units) as total_unit_LMG6, 
		sum(base_points_accrued) as Total_points_LMG6,
		count(distinct LMG_CONCEPT_NAME) as concept_count_LMG6 
from SPDTMP30.VB_ALL_TN_ITM_REV_AE6
group by LMG_MEM_CARD_Number;
quit;

data SPDTMP30.VB_ALL_TN_ITM_REV_AE6_3(compress=yes);
set SPDTMP30.VB_ALL_TN_ITM_REV_AE6_2new;
format start_date_LMG6 ddmmyys10.;
format end_date_LMG6 ddmmyys10.;
active_time_LMG6=intck('day',start_date_LMG6,end_date_LMG6);
avg_units_per_txn_LMG6=total_unit_LMG6/no_of_txn_LMG6;
avg_units_per_visit_LMG6=total_unit_LMG6/no_of_visits_LMG6;
atv_LMG6 = LMG_sum_revenue_aed_6/no_of_txn_LMG6;
run;

/*data SPDTMP30.VB_ALL_TN_ITM_REV_AE3(compress=yes);*/
/*set SPDTMP30.VB_ALL_TN_ITM_REV_AE(keep= lmg_mem_card_number lmg_concept_name txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued date);*/
/*where txn_dt_wid>=20151201 and txn_dt_wid<=20160228 ;*/
/*run;*/

proc sql;
create table SPDTMP30.VB_ALL_TN_ITM_REV_AE3_2 (compress=yes) as
select LMG_MEM_CARD_Number, 
sum(revenue_aed) as LMG_sum_revenue_aed_3 ,
count(distinct date) as no_of_visits_LMG3, 
count(distinct invoice_number) as no_of_txn_LMG3, 
max(date) as end_date_LMG3, min(date) as start_date_LMG3, 
count(distinct item_code) as distinct_prod_LMG3, 
sum(units) as total_unit_LMG3, 
sum(base_points_accrued) as Total_points_LMG3 ,
count(distinct LMG_CONCEPT_NAME) as concept_count_LMG3  

from SPDTMP30.VB_ALL_TN_ITM_REV_AE3
group by LMG_MEM_CARD_Number;
quit;

data SPDTMP30.VB_ALL_TN_ITM_REV_AE3_3(compress=yes);
set SPDTMP30.VB_ALL_TN_ITM_REV_AE3_2;
format start_date_LMG3 ddmmyys10.;
format end_date_LMG3 ddmmyys10.;
active_time_LMG3=intck('day',start_date_LMG3,end_date_LMG3);
avg_units_per_txn_LMG3=total_unit_LMG3/no_of_txn_LMG3;
avg_units_per_visit_LMG3=total_unit_LMG3/no_of_visits_LMG3;
atv_LMG3 = LMG_sum_revenue_aed_3/no_of_txn_LMG3;
run;

/*joining the Overall, 9,6 and 3 month tables to create a consolidated table */

proc sql;
create Table SPDTMP30.VB_ALL_TN_ITM_REV_AE_1_newer (compress=yes, drop = end_date_lmg start_date_lmg end_date_lmg9 start_date_lmg9 end_date_lmg6 start_date_lmg6 end_date_lmg3 start_date_lmg3) as 
select * from SPDTMP30.VB_ALL_TN_ITM_REV_AE_overall_1 as T1
left join (Select * from (select * from SPDTMP30.VB_ALL_TN_ITM_REV_AE9_3 as a 
				              left join SPDTMP30.VB_ALL_TN_ITM_REV_AE6_3 as b 
				               on a.LMG_MEM_CARD_NUMBER = b.LMG_MEM_CARD_NUMBER) as c
                          left join SPDTMP30.VB_ALL_TN_ITM_REV_AE3_3 as d
                          on c.LMG_MEM_CARD_NUMBER = d.LMG_MEM_CARD_NUMBER) as e

on T1.LMG_MEM_CARD_NUMBER = e.LMG_MEM_CARD_NUMBER;
run;

