

   

  %include'/home/unxsrv/code/Automated_Solutions/Libnames/LIBNAMES.sas';


  /*Getting LMG transactions between the given dates. A formatted date variable is also added*/
  

  data SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE (Compress=yes);
      set sascrm.TN_ITM_REV_AE ;
		where TXN_DT_WID >= 20160401 and TXN_DT_WID<= 20170331 and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;

	    date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
		format date ddmmyys10.;
  run;

/*data crosscheck1;*/
/*set SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE;*/
/*where TXN_DT_WID >= 20160401 and TXN_DT_WID<= 20170331 and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 */
/*		and lmg_mem_card_number = "1800000006365362";*/
/*	    date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); */
/*		format date ddmmyys10.;*/
/**/
/*run;*/
/**/
/*data crosscheck;*/
/*set SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_7;*/
/*where LMG_MEM_CARD_NUMBER = "1800000006365362";*/
/*run;*/
 

/*Getting Lifestyle transactions between the given dates and creating a Visit_flag as a categorical  variable to 
  give a time component to visits. A formatted date variable is also added*/

data SPDTMP7.VB_Apr_LS_TN_ITM_REV_AE_ (Compress=yes);
      set sascrm.TN_ITM_REV_AE ;
		where TXN_DT_WID >= 20160401 and TXN_DT_WID<= 20170331 and LMG_CONCEPT_NAME = "Lifestyle" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;

	   if TXN_DT_WID>= 20160401 and TXN_DT_WID<= 20160630 then visit_flag = 4 ;
	   else if TXN_DT_WID> 20160630 and TXN_DT_WID<= 20160930 then visit_flag = 3 ;
	   else if TXN_DT_WID> 20160930 and TXN_DT_WID<= 20161231 then visit_flag = 2; 
	   else if TXN_DT_WID> 20161231 and TXN_DT_WID<= 20170331 then visit_flag = 1; 
	   date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
	   format date ddmmyys10.;
  run;
 
  data SPDTMP7.VB_Apr_SH_TN_ITM_REV_AE_ (Compress=yes);
      set sascrm.TN_ITM_REV_AE ;
		where TXN_DT_WID >= 20160401 and TXN_DT_WID<= 20170331 and LMG_CONCEPT_NAME = "Splash" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;

	   if TXN_DT_WID>= 20160401 and TXN_DT_WID<= 20160630 then visit_flag = 4 ;
	   else if TXN_DT_WID> 20160630 and TXN_DT_WID<= 20160930 then visit_flag = 3 ;
	   else if TXN_DT_WID> 20160930 and TXN_DT_WID<= 20161231 then visit_flag = 2; 
	   else if TXN_DT_WID> 20161231 and TXN_DT_WID<= 20170331 then visit_flag = 1; 
	   date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
	   format date ddmmyys10.;
  run;


data SPDTMP7.VB_Apr_HC_TN_ITM_REV_AE_ (Compress=yes);
      set sascrm.TN_ITM_REV_AE ;
		where TXN_DT_WID >= 20160401 and TXN_DT_WID<= 20170331 and LMG_CONCEPT_NAME = "Home center" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;

	   if TXN_DT_WID>= 20160401 and TXN_DT_WID<= 20160630 then visit_flag = 4 ;
	   else if TXN_DT_WID> 20160630 and TXN_DT_WID<= 20160930 then visit_flag = 3 ;
	   else if TXN_DT_WID> 20160930 and TXN_DT_WID<= 20161231 then visit_flag = 2; 
	   else if TXN_DT_WID> 20161231 and TXN_DT_WID<= 20170331 then visit_flag = 1; 
	   date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
	   format date ddmmyys10.;
  run;

data SPDTMP7.VB_Apr_HB_TN_ITM_REV_AE_ (Compress=yes);
      set sascrm.TN_ITM_REV_AE ;
		where TXN_DT_WID >= 20160401 and TXN_DT_WID<= 20170331 and LMG_CONCEPT_NAME = "Home Box" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;

	   if TXN_DT_WID>= 20160401 and TXN_DT_WID<= 20160630 then visit_flag = 4 ;
	   else if TXN_DT_WID> 20160630 and TXN_DT_WID<= 20160930 then visit_flag = 3 ;
	   else if TXN_DT_WID> 20160930 and TXN_DT_WID<= 20161231 then visit_flag = 2; 
	   else if TXN_DT_WID> 20161231 and TXN_DT_WID<= 20170331 then visit_flag = 1; 
	   date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
	   format date ddmmyys10.;
  run;

  

data SPDTMP7.VB_Apr_BS_TN_ITM_REV_AE_ (Compress=yes);
      set sascrm.TN_ITM_REV_AE ;
		where TXN_DT_WID >= 20160401 and TXN_DT_WID<= 20170331 and LMG_CONCEPT_NAME = "Babyshop" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;

	   if TXN_DT_WID>= 20160401 and TXN_DT_WID<= 20160630 then visit_flag = 4 ;
	   else if TXN_DT_WID> 20160630 and TXN_DT_WID<= 20160930 then visit_flag = 3 ;
	   else if TXN_DT_WID> 20160930 and TXN_DT_WID<= 20161231 then visit_flag = 2; 
	   else if TXN_DT_WID> 20161231 and TXN_DT_WID<= 20170331 then visit_flag = 1; 
	   date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
	   format date ddmmyys10.;
  run;

  /*
data SPDTMP7.VB_Apr_LS_TN_ITM_REV_AE;
set SPDTMP7.VB_Apr_LS_TN_ITM_REV_AE ; 
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
format date ddmmyys10.;
run;

data SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE;
set SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE ; 
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
format date ddmmyys10.;
run;
*/

data SPDTMP7.VB_Apr_LS_CUST_DETL_LMG_AE (Compress=yes);
      set sascrm.CUST_DETL_LMG_AE ;
run;


/* 
  proc export
   Data = SPDTMP7.VB_Apr_LS_TN_ITM_REV_AE
   OUTFILE="/sasusers/process/ds/vijayb/VB_Apr_LS_TN_ITM_REV_AE_ver1"
   REPLACE;
  Run;

proc contents data= SPDTMP7.VB_Apr_LS_TN_ITM_REV_AE_ver1;
run; 

*/
/*This part of the code creates a dataset of final Variables from Table VB_Apr_ALL_TN_ITM_REV_AE i.e. Data of all concepts
  This table needs to be joined with the Lifestyle Table*/



proc sql;
create table SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE_oval (compress=yes) as
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
from SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE
 
group by LMG_MEM_CARD_Number;

quit;

data SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE_oval_1(compress=yes);
set SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE_oval;
format start_date_LMG ddmmyys10.;
format end_date_LMG ddmmyys10.;
active_time_LMG=intck('day',start_date_LMG,end_date_LMG);
avg_units_per_txn_LMG = total_unit_LMG/no_of_txn_LMG;
avg_units_per_visit_LMG =  total_unit_LMG/no_of_visits_LMG;
atv_LMG = LMG_sum_revenue_aed/no_of_txn_LMG;
run;


/*proc means data= SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE_oval_1;*/
/*run;*/


data SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE9(compress=yes);
set SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE (keep= lmg_mem_card_number lmg_concept_name txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued date);
where txn_dt_wid>=20160701 and txn_dt_wid<=20170331 ;

run;

proc sql;
create table SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE9_2 (compress=yes) as
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

from SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE9
 
group by LMG_MEM_CARD_Number;

quit;




data SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE9_3(compress=yes);
set SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE9_2;
format start_date_LMG9 ddmmyys10.;
format end_date_LMG9 ddmmyys10.;
active_time_LMG9=intck('day',start_date_LMG9,end_date_LMG9);
avg_units_per_txn_LMG9 = total_unit_LMG9/no_of_txn_LMG9;
avg_units_per_visit_LMG9 =  total_unit_LMG9/no_of_visits_LMG9;
atv_LMG9 = LMG_sum_revenue_aed_9/no_of_txn_LMG9;
run;

/*proc means data= SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE9_3;*/
/*run;*/


data SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE6(compress=yes);
set SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE(keep= lmg_mem_card_number lmg_concept_name  txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued date);
where txn_dt_wid>=20161001 and txn_dt_wid<=20170331 ;

run;


proc sql;
create table SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE6_2 (compress=yes) as
select LMG_MEM_CARD_Number, 
        sum(revenue_aed) as LMG_sum_revenue_aed_6 , 
		count(distinct date) as no_of_visits_LMG6, 
		count(distinct invoice_number) as no_of_txn_LMG6, 
		max(date) as end_date_LMG6, min(date) as start_date_LMG6, 
		count(distinct item_code) as distinct_prod_LMG6, sum(units) as total_unit_LMG6, 
		sum(base_points_accrued) as Total_points_LMG6,
		count(distinct LMG_CONCEPT_NAME) as concept_count_LMG6 
from SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE6
group by LMG_MEM_CARD_Number;
quit;

data SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE6_3(compress=yes);
set SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE6_2;
format start_date_LMG6 ddmmyys10.;
format end_date_LMG6 ddmmyys10.;
active_time_LMG6=intck('day',start_date_LMG6,end_date_LMG6);
avg_units_per_txn_LMG6=total_unit_LMG6/no_of_txn_LMG6;
avg_units_per_visit_LMG6=total_unit_LMG6/no_of_visits_LMG6;
atv_LMG6 = LMG_sum_revenue_aed_6/no_of_txn_LMG6;
run;


/*proc means data= SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE6_3;*/
/*run;*/


data SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE3(compress=yes);
set SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE(keep= lmg_mem_card_number lmg_concept_name txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued date);
where txn_dt_wid>=20170101 and txn_dt_wid<=20170331 ;
run;

proc sql;
create table SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE3_2 (compress=yes) as
select LMG_MEM_CARD_Number, 
sum(revenue_aed) as LMG_sum_revenue_aed_3 ,
count(distinct date) as no_of_visits_LMG3, 
count(distinct invoice_number) as no_of_txn_LMG3, 
max(date) as end_date_LMG3, min(date) as start_date_LMG3, 
count(distinct item_code) as distinct_prod_LMG3, 
sum(units) as total_unit_LMG3, 
sum(base_points_accrued) as Total_points_LMG3 ,
count(distinct LMG_CONCEPT_NAME) as concept_count_LMG3

from SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE3
group by LMG_MEM_CARD_Number;
quit;

data SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE3_3(compress=yes);
set SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE3_2;
format start_date_LMG3 ddmmyys10.;
format end_date_LMG3 ddmmyys10.;
active_time_LMG3=intck('day',start_date_LMG3,end_date_LMG3);
avg_units_per_txn_LMG3=total_unit_LMG3/no_of_txn_LMG3;
avg_units_per_visit_LMG3=total_unit_LMG3/no_of_visits_LMG3;
atv_LMG3 = LMG_sum_revenue_aed_3/no_of_txn_LMG3;
run;

/*joining the Overall, 9,6 and 3 month tables to create a consolidated table */

proc sql;
create Table SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE_1_newer (compress=yes, drop = end_date_lmg start_date_lmg end_date_lmg9 start_date_lmg9 end_date_lmg6 start_date_lmg6 end_date_lmg3 start_date_lmg3) as 
select * from SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE_oval_1 as T1
left join (Select * from (select * from SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE9_3 as a 
				              left join SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE6_3 as b 
				               on a.LMG_MEM_CARD_NUMBER = b.LMG_MEM_CARD_NUMBER) as c
                          left join SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE3_3 as d
                          on c.LMG_MEM_CARD_NUMBER = d.LMG_MEM_CARD_NUMBER) as e

on T1.LMG_MEM_CARD_NUMBER = e.LMG_MEM_CARD_NUMBER;
run;


/*Creating a dataset of final Variables from Table VB_Apr_LS_TN_ITM_REV_AE i.e. Data of only the Lifestyle concept*/
/*Joining the DIM_ITM_LS Table to LS Transactions table */

data SPDTMP7.VB_Apr_LS_Dim_itm_ls (compress= yes) ;
set saser.dim_itm_ls;
run;

proc sql;
  create table SPDTMP7.VB_Apr_LS_TN_ITM_REV_AE_0 (compress = yes) as
  select t1.* , t2.GRP_CD , t2.GRP_NM , t2.DPT_CD, DPT_NM from SPDTMP7.VB_Apr_LS_TN_ITM_REV_AE_ as t1
  left join SPDTMP7.VB_Apr_LS_Dim_itm_ls as t2
  on t1.ITEM_CODE = t2.ITM_CD;
 quit;



/**/
/* proc freq data= SPDTMP7.VB_Apr_LS_TN_ITM_REV_AE_0;*/
/**/
/* tables dpt_nm grp_nm;*/
/* run;*/


proc sql ;
  Create Table SPDTMP7.VB_Apr_LS_TN_ITM_REV_AE_1 (compress = yes) as
   select LMG_MEM_CARD_NUMBER 
		
   		,count (distinct INVOICE_NUMBER) as NUM_Transactions
	    ,count(distinct (case when Visit_flag = 1 then INVOICE_NUMBER else '' end)) as Num_transactions_3 
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 then INVOICE_NUMBER else '' end)) as Num_transactions_6
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3   then INVOICE_NUMBER else '' end)) as Num_transactions_9
		
		,count (distinct TXN_DT_WID)as NUM_VISITS 
		,count(distinct (case when Visit_flag=1 then TXN_DT_WID else . end)) as Num_Visits_3
		,count (distinct (case when Visit_flag=1 or Visit_flag = 2 then TXN_DT_WID else . end)) as Num_Visits_6
		,count(distinct (case when Visit_flag=1 or Visit_flag = 2 or Visit_flag = 3 then TXN_DT_WID else . end)) as Num_Visits_9
			
	
		,count (distinct ITEM_CODE) as NUM_DIST_PRODUCTS 
		,count(distinct(case when Visit_flag=1 then ITEM_CODE else '' end)) as Num_Dist_prod_3
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2   then ITEM_CODE else '' end)) as Num_Dist_prod_6
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then ITEM_CODE else '' end)) as Num_Dist_prod_9
		
		,sum(Retail_cost_1_AED) as Total_Retail_cost_1_AED
		,sum(case when Visit_flag=1 then Retail_cost_1_AED else . end) as Retail_cost_1_AED_3
		,sum(case when Visit_flag= 1 or Visit_flag=2   then Retail_cost_1_AED else . end) as Retail_cost_1_AED_6
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then Retail_cost_1_AED else . end) as Retail_cost_1_AED_9


		,sum(Retail_cost_2_AED) as Total_Retail_cost_2_AED
		,sum(case when Visit_flag=1 then Retail_cost_2_AED else . end) as Retail_cost_2_AED_3
		,sum(case when Visit_flag= 1 or Visit_flag=2   then Retail_cost_2_AED else . end) as Retail_cost_2_AED_6
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then Retail_cost_2_AED else . end) as Retail_cost_2_AED_9

		,sum(REVENUE_AED) as Total_REVENUE_AED
		,sum(case when Visit_flag=1 then REVENUE_AED else . end) as REVENUEAED_3
		,sum(case when Visit_flag= 1 or Visit_flag=2   then REVENUE_AED else . end) as REVENUEAED_6
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3 then REVENUE_AED else . end) as REVENUEAED_9

		,sum(REVENUEAED_SALE) as Total_REVENUEAED_SALE
		,sum(case when Visit_flag=1 then REVENUEAED_SALE else . end) as REVENUEAED_SALE_3
		,sum(case when Visit_flag= 1 or Visit_flag=2   then REVENUEAED_SALE else . end) as REVENUEAED_SALE_6
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3 then REVENUEAED_SALE else . end) as REVENUEAED_SALE_9

		,sum(REVENUEAED_NONSALE) as Total_REVENUEAED_NONSALE
		,sum(case when Visit_flag=1 then REVENUEAED_NONSALE else . end) as REVENUEAED_NONSALE_3
		,sum(case when Visit_flag= 1 or Visit_flag=2   then REVENUEAED_NONSALE else . end) as REVENUEAED_NONSALE_6
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then REVENUEAED_NONSALE else . end) as REVENUEAED_NONSALE_9

		,sum(BASE_POINTS_ACCRUED) as Total_BASE_POINTS
		,sum(BASE_POINTS_ACCRUED_SALE) as Total_BASE_POINTS_SALE 
		,sum(BASE_POINTS_ACCRUED_NONSALE) as Total_BASE_POINTS_NONSALE
		,sum(BONUS_POINTS_ACCRUED) as Total_BONUS_POINTS_ACCRUED
 
		,sum(UNITS) as Total_UNITS 
		,sum(case when Visit_flag=1 then UNITS else . end) as Units_3
		,sum(case when Visit_flag= 1 or Visit_flag=2   then UNITS else . end) as Units_6
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then UNITS else . end) as Units_9

		,( '28Apr2017'd-max(date)) as recency 
		,('28Apr2017'd- max(case when Visit_flag=1 then date else . end))as recency_3
		,('28Apr2017'd- max(case when Visit_flag=1 or  Visit_flag = 2 then date else . end))as recency_6
		,('28Apr2017'd- max(case when Visit_flag=1 or  Visit_flag = 2 or Visit_flag = 3 then date else . end))as recency_9

		, (max(date)-min(date)) as period_bw_trnxns

		,count(distinct (case when LMG_STORE_TYPE = "Centerpoint" then TXN_DT_WID else . end)) as CP_Visits  
		,count(distinct (case when LMG_STORE_TYPE = "Stand alone" then TXN_DT_WID else . end)) as Standalone_Visits
		,count(distinct(case when LMG_STORE_TYPE = "Multi Concept" then TXN_DT_WID else . end)) as MultiConcept_Visits
		
		,count(distinct (case when LMG_STORE_TYPE = "Centerpoint" then INVOICE_NUMBER else '' end)) as CP_transactions  
		,count(distinct (case when LMG_STORE_TYPE = "Stand alone" then INVOICE_NUMBER else '' end)) as Standalone_transactions
		,count(distinct(case when LMG_STORE_TYPE = "Multi Concept" then INVOICE_NUMBER else'' end)) as MultiConcept_transactions
		
		,count(distinct (case when LMG_STORE_TYPE = "Centerpoint" then ITEM_CODE else '' end)) as CP_dist_products  
		,count(distinct (case when LMG_STORE_TYPE = "Stand alone" then ITEM_CODE else '' end)) as Standalone_dist_products
		,count(distinct(case when LMG_STORE_TYPE = "Multi Concept" then ITEM_CODE else '' end)) as MultiConcept_dist_products
		
		,sum(case when LMG_STORE_TYPE = "Centerpoint" then REVENUE_AED else . end) as CP_REVENUEAED
		,sum(case when LMG_STORE_TYPE = "Stand alone" then REVENUE_AED else . end) as Standalone_REVENUEAED
		,sum(case when LMG_STORE_TYPE = "Multi Concept" then REVENUE_AED else . end) as MultiConcept_REVENUEAED

		
		,sum(case when LMG_STORE_TYPE = "Centerpoint" then UNITS else . end) as CP_Total_UNITS
		,sum(case when LMG_STORE_TYPE = "Stand alone" then UNITS else . end) as Standalone_Total_UNITS
		,sum(case when LMG_STORE_TYPE = "Multi Concept" then UNITS else . end) as MultiConcept_Total_UNITS

		,('28Apr2017'd - max(case when LMG_STORE_TYPE = "Centerpoint" then date else . end)) as recency_CP
		,('28Apr2017'd - max(case when LMG_STORE_TYPE = "Stand alone" then date else . end)) as recency_Standalone 
		,('28Apr2017'd - max(case when LMG_STORE_TYPE = "Multi Concept" then date else . end)) as recency_MC
		
	    ,sum(case when GRP_NM = "White Box" then REVENUE_AED else . end) as Grp_WB_Revenue
		,sum(case when GRP_NM = "Brown Box" then REVENUE_AED else . end) as Grp_BB_Revenue
		,sum(case when GRP_NM = "Lifestyle" then REVENUE_AED else . end) as Grp_LS_Revenue
         
		,count(Distinct (case when GRP_NM = "White Box" then INVOICE_NUMBER else '' end)) as Grp_WB_Tranxs
		,count(Distinct (case when GRP_NM = "Brown Box" then INVOICE_NUMBER else '' end)) as Grp_BB_Tranxs
		,count(Distinct (case when GRP_NM = "Lifestyle" then INVOICE_NUMBER else '' end)) as Grp_NM_Tranxs
         		
		,sum(case when GRP_NM = "White Box" then Units else . end) as Grp_WB_Units
		,sum(case when GRP_NM = "Brown Box" then Units else . end) as Grp_BB_Units
		,sum(case when GRP_NM = "Lifestyle" then Units else . end) as Grp_NM_Units          
		
 		,count(distinct LMG_X_DEPT_CD) as Dpt_count

		,sum (case when  DPT_NM = "Cosmetics" then REVENUE_AED else . end) as Dpt_Cosm_Rev
        ,sum (case when  DPT_NM = "Home Fragrance" then REVENUE_AED else . end) as Dpt_HomeFrag_Rev
		,sum (case when  DPT_NM = "Teen Gifts" then REVENUE_AED else . end) as Dpt_TeenGifts_Rev
		,sum (case when  DPT_NM = "Fashion Accessories" then REVENUE_AED else . end) as Dpt_FashAcc_Rev
		,sum (case when DPT_NM = "Hair Accessories" then REVENUE_AED else . end) as Dpt_HairAcc_Rev
		,sum (case when DPT_NM = "Spa" then REVENUE_AED else . end) as Dpt_Spa_Rev
		,sum (case when DPT_NM = "Towels" then REVENUE_AED else . end) as Dpt_Tow_Rev

		,sum (case when  DPT_NM = "Cosmetics" then Units else . end) as Dpt_Cosm_Units
        ,sum (case when  DPT_NM = "Home Fragrance" then Units else . end) as Dpt_HomeFrag_Units
		,sum (case when  DPT_NM = "Teen Gifts" then Units else . end) as Dpt_TeenGifts_Units
		,sum (case when  DPT_NM = "Fashion Accessories" then Units else . end) as Dpt_FashAcc_Units
		,sum (case when DPT_NM = "Hair Accessories" then Units else . end) as Dpt_HairAcc_Units
		,sum (case when DPT_NM = "Spa" then Units else . end) as Dpt_Spa_Units
		,sum (case when DPT_NM = "Towels" then Units else . end) as Dpt_Tow_Units

		,count (distinct (case when  DPT_NM = "Cosmetics" then ITEM_CODE else '' end)) as Dpt_Cosm_prod
        ,count (distinct(case when  DPT_NM = "Home Fragrance" then ITEM_CODE else '' end)) as Dpt_HomeFrag_prod
		,count (distinct(case when  DPT_NM = "Teen Gifts" then ITEM_CODE else '' end)) as Dpt_TeenGifts_prod
		,count (distinct(case when  DPT_NM = "Fashion Accessories" then ITEM_CODE else '' end)) as Dpt_FashAcc_prod
		,count (distinct(case when DPT_NM = "Hair Accessories" then ITEM_CODE else '' end)) as Dpt_HairAcc_prod
		,count (distinct(case when DPT_NM = "Spa" then ITEM_CODE else '' end)) as Dpt_Spa_prod
		,count (distinct(case when DPT_NM = "Towels" then ITEM_CODE else '' end)) as Dpt_Tow_prod

		,count (distinct (case when  DPT_NM = "Cosmetics" then INVOICE_NUMBER else '' end)) as Dpt_Cosm_trnxns
        ,count (distinct(case when  DPT_NM = "Home Fragrance" then INVOICE_NUMBER else '' end)) as Dpt_HomeFrag_trnxns
		,count (distinct(case when  DPT_NM = "Teen Gifts" then INVOICE_NUMBER else '' end)) as Dpt_TeenGifts_trnxns
		,count (distinct(case when  DPT_NM = "Fashion Accessories" then INVOICE_NUMBER else '' end)) as Dpt_FashAcc_trnxns
		,count (distinct(case when DPT_NM = "Hair Accessories" then INVOICE_NUMBER else '' end)) as Dpt_HairAcc_trnxns
		,count (distinct(case when DPT_NM = "Spa" then INVOICE_NUMBER else '' end)) as Dpt_Spa_trnxns
		,count (distinct(case when DPT_NM = "Towels" then INVOICE_NUMBER else '' end)) as Dpt_Tow_trnxns

from SPDTMP7.VB_Apr_LS_TN_ITM_REV_AE_0
Group By LMG_MEM_CARD_NUMBER ;
quit;


data SPDTMP7.VB_Apr_LS_TN_ITM_REV_AE_1_1 (compress=yes);
set SPDTMP7.VB_Apr_LS_TN_ITM_REV_AE_1;

atv_LS = (Total_REVENUE_AED)/NUM_Transactions   ;
atv_LS_3 = (REVENUEAED_3)/NUM_Transactions_3;
atv_LS_6 = (REVENUEAED_6)/NUM_Transactions_6;
atv_LS_9 = (REVENUEAED_9)/NUM_Transactions_9;

run;


proc means data= SPDTMP7.VB_Apr_LS_TN_ITM_REV_AE_1_1;
run;

proc sql ;
  Create Table SPDTMP7.VB_Apr_SH_TN_ITM_REV_AE_1 (compress = yes) as
   select LMG_MEM_CARD_NUMBER 
		
   		,count (distinct INVOICE_NUMBER) as NUM_Transactions_SH
	    ,count(distinct (case when Visit_flag = 1 then INVOICE_NUMBER else '' end)) as Num_transactions_3_SH
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 then INVOICE_NUMBER else '' end)) as Num_transactions_6_SH
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3   then INVOICE_NUMBER else '' end)) as Num_transactions_9_SH
		
		,count (distinct TXN_DT_WID)as NUM_VISITS_SH 
		,count(distinct (case when Visit_flag=1 then TXN_DT_WID else . end)) as Num_Visits_3_SH
		,count (distinct (case when Visit_flag=1 or Visit_flag = 2 then TXN_DT_WID else . end)) as Num_Visits_6_SH
		,count(distinct (case when Visit_flag=1 or Visit_flag = 2 or Visit_flag = 3 then TXN_DT_WID else . end)) as Num_Visits_9_SH
			
	
		,count (distinct ITEM_CODE) as NUM_DIST_PRODUCTS_SH 
		,count(distinct(case when Visit_flag=1 then ITEM_CODE else '' end)) as Num_Dist_prod_3_SH
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2   then ITEM_CODE else '' end)) as Num_Dist_prod_6_SH
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then ITEM_CODE else '' end)) as Num_Dist_prod_9_SH
		
		,sum(Retail_cost_1_AED) as Total_Retail_cost_1_AED_SH
		,sum(case when Visit_flag=1 then Retail_cost_1_AED else . end) as Retail_cost_1_AED_3_SH
		,sum(case when Visit_flag= 1 or Visit_flag=2   then Retail_cost_1_AED else . end) as Retail_cost_1_AED_6_SH
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then Retail_cost_1_AED else . end) as Retail_cost_1_AED_9_SH


		,sum(Retail_cost_2_AED) as Total_Retail_cost_2_AED_SH
		,sum(case when Visit_flag=1 then Retail_cost_2_AED else . end) as Retail_cost_2_AED_3_SH
		,sum(case when Visit_flag= 1 or Visit_flag=2   then Retail_cost_2_AED else . end) as Retail_cost_2_AED_6_SH
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then Retail_cost_2_AED else . end) as Retail_cost_2_AED_9_SH

		,sum(REVENUE_AED) as Total_REVENUEAED_SH
		,sum(case when Visit_flag=1 then REVENUE_AED else . end) as REVENUEAED_3_SH
		,sum(case when Visit_flag= 1 or Visit_flag=2   then REVENUE_AED else . end) as REVENUEAED_6_SH
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3 then REVENUE_AED else . end) as REVENUEAED_9_SH

		,sum(UNITS) as Total_UNITS_SH 
		,sum(case when Visit_flag=1 then UNITS else . end) as Units_3_SH
		,sum(case when Visit_flag= 1 or Visit_flag=2   then UNITS else . end) as Units_6_SH
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then UNITS else . end) as Units_9_SH

		,( '28Apr2017'd-max(date)) as recency_SH 
		,('28Apr2017'd-max(case when Visit_flag=1 then date else . end))as recency_3_SH
		,('28Apr2017'd-max(case when Visit_flag=1 or  Visit_flag = 2 then date else . end))as recency_6_SH
		,('28Apr2017'd-max(case when Visit_flag=1 or Visit_flag = 2 or Visit_flag = 3 then date else . end))as recency_9_SH

		, (max(date)-min(date)) as period_bw_trnxns_SH

		from SPDTMP7.VB_Apr_SH_TN_ITM_REV_AE_
Group By LMG_MEM_CARD_NUMBER ;
quit;

data SPDTMP7.VB_Apr_SH_TN_ITM_REV_AE_1_1(compress = yes);
set SPDTMP7.VB_Apr_SH_TN_ITM_REV_AE_1;

atv_SH = (Total_REVENUEAED_SH)/NUM_Transactions_SH;
atv_SH_3 = (REVENUEAED_3_SH)/NUM_Transactions_3_SH;
atv_SH_6 = (REVENUEAED_6_SH)/NUM_Transactions_6_SH;
atv_SH_9 = (REVENUEAED_9_SH)/NUM_Transactions_9_SH;

run;

proc means data= SPDTMP7.VB_Apr_SH_TN_ITM_REV_AE_1_1;
run;

proc sql ;
  Create Table SPDTMP7.VB_Apr_HC_TN_ITM_REV_AE_1 (compress = yes) as
   select LMG_MEM_CARD_NUMBER 
		
   		,count (distinct INVOICE_NUMBER) as NUM_Transactions_HC
	    ,count(distinct (case when Visit_flag = 1 then INVOICE_NUMBER else '' end)) as Num_transactions_3_HC
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 then INVOICE_NUMBER else '' end)) as Num_transactions_6_HC
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3   then INVOICE_NUMBER else '' end)) as Num_transactions_9_HC
		
		,count (distinct TXN_DT_WID)as NUM_VISITS_HC 
		,count(distinct (case when Visit_flag=1 then TXN_DT_WID else . end)) as Num_Visits_3_HC
		,count (distinct (case when Visit_flag=1 or Visit_flag = 2 then TXN_DT_WID else . end)) as Num_Visits_6_HC
		,count(distinct (case when Visit_flag=1 or Visit_flag = 2 or Visit_flag = 3 then TXN_DT_WID else . end)) as Num_Visits_9_HC
			
	
		,count (distinct ITEM_CODE) as NUM_DIST_PRODUCTS_HC 
		,count(distinct(case when Visit_flag=1 then ITEM_CODE else '' end)) as Num_Dist_prod_3_HC
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2   then ITEM_CODE else '' end)) as Num_Dist_prod_6_HC
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then ITEM_CODE else '' end)) as Num_Dist_prod_9_HC
		
		,sum(Retail_cost_1_AED) as Total_Retail_cost_1_AED_HC
		,sum(case when Visit_flag=1 then Retail_cost_1_AED else . end) as Retail_cost_1_AED_3_HC
		,sum(case when Visit_flag= 1 or Visit_flag=2   then Retail_cost_1_AED else . end) as Retail_cost_1_AED_6_HC
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then Retail_cost_1_AED else . end) as Retail_cost_1_AED_9_HC


		,sum(Retail_cost_2_AED) as Total_Retail_cost_2_AED_HC
		,sum(case when Visit_flag=1 then Retail_cost_2_AED else . end) as Retail_cost_2_AED_3_HC
		,sum(case when Visit_flag= 1 or Visit_flag=2   then Retail_cost_2_AED else . end) as Retail_cost_2_AED_6_HC
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then Retail_cost_2_AED else . end) as Retail_cost_2_AED_9_HC

		,sum(REVENUE_AED) as Total_REVENUEAED_HC
		,sum(case when Visit_flag=1 then REVENUE_AED else . end) as REVENUEAED_3_HC
		,sum(case when Visit_flag= 1 or Visit_flag=2   then REVENUE_AED else . end) as REVENUEAED_6_HC
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3 then REVENUE_AED else . end) as REVENUEAED_9_HC

		,sum(UNITS) as Total_UNITS_HC 
		,sum(case when Visit_flag=1 then UNITS else . end) as Units_3_HC
		,sum(case when Visit_flag= 1 or Visit_flag=2   then UNITS else . end) as Units_6_HC
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then UNITS else . end) as Units_9_HC

		,( '28Apr2017'd-max(date)) as recency_HC 
		,('28Apr2017'd-max(case when Visit_flag=1 then date else . end))as recency_3_HC
		,('28Apr2017'd-max(case when Visit_flag=1 or  Visit_flag = 2 then date else . end))as recency_6_HC
		,('28Apr2017'd-max(case when Visit_flag=1 or Visit_flag = 2 or Visit_flag = 3 then date else . end))as recency_9_HC

		, (max(date)-min(date)) as period_bw_trnxns_HC

		
from SPDTMP7.VB_Apr_HC_TN_ITM_REV_AE_
Group By LMG_MEM_CARD_NUMBER ;
quit;

data SPDTMP7.VB_Apr_HC_TN_ITM_REV_AE_1_1(compress = yes);
set SPDTMP7.VB_Apr_HC_TN_ITM_REV_AE_1;

atv_HC = (Total_REVENUEAED_HC)/NUM_Transactions_HC   ;
atv_HC_3 = (REVENUEAED_3_HC)/NUM_Transactions_3_HC;
atv_HC_6 = (REVENUEAED_6_HC)/NUM_Transactions_6_HC;
atv_HC_9 = (REVENUEAED_9_HC)/NUM_Transactions_9_HC;

run;


proc means data= SPDTMP7.VB_Apr_HC_TN_ITM_REV_AE_1_1;
run;


proc sql ;
  Create Table SPDTMP7.VB_Apr_HB_TN_ITM_REV_AE_1 (compress = yes) as
   select LMG_MEM_CARD_NUMBER 
		
   		,count (distinct INVOICE_NUMBER) as NUM_Transactions_HB
	    ,count(distinct (case when Visit_flag = 1 then INVOICE_NUMBER else '' end)) as Num_transactions_3_HB
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 then INVOICE_NUMBER else '' end)) as Num_transactions_6_HB
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3   then INVOICE_NUMBER else '' end)) as Num_transactions_9_HB
		
		,count (distinct TXN_DT_WID)as NUM_VISITS_HB 
		,count(distinct (case when Visit_flag=1 then TXN_DT_WID else . end)) as Num_Visits_3_HB
		,count (distinct (case when Visit_flag=1 or Visit_flag = 2 then TXN_DT_WID else . end)) as Num_Visits_6_HB
		,count(distinct (case when Visit_flag=1 or Visit_flag = 2 or Visit_flag = 3 then TXN_DT_WID else . end)) as Num_Visits_9_HB
			
	
		,count (distinct ITEM_CODE) as NUM_DIST_PRODUCTS_HB 
		,count(distinct(case when Visit_flag=1 then ITEM_CODE else '' end)) as Num_Dist_prod_3_HB
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2   then ITEM_CODE else '' end)) as Num_Dist_prod_6_HB
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then ITEM_CODE else '' end)) as Num_Dist_prod_9_HB
		
		,sum(Retail_cost_1_AED) as Total_Retail_cost_1_AED_HB
		,sum(case when Visit_flag=1 then Retail_cost_1_AED else . end) as Retail_cost_1_AED_3_HB
		,sum(case when Visit_flag= 1 or Visit_flag=2   then Retail_cost_1_AED else . end) as Retail_cost_1_AED_6_HB
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then Retail_cost_1_AED else . end) as Retail_cost_1_AED_9_HB


		,sum(Retail_cost_2_AED) as Total_Retail_cost_2_AED_HB
		,sum(case when Visit_flag=1 then Retail_cost_2_AED else . end) as Retail_cost_2_AED_3_HB
		,sum(case when Visit_flag= 1 or Visit_flag=2   then Retail_cost_2_AED else . end) as Retail_cost_2_AED_6_HB
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then Retail_cost_2_AED else . end) as Retail_cost_2_AED_9_HB

		,sum(REVENUE_AED) as Total_REVENUEAED_HB
		,sum(case when Visit_flag=1 then REVENUE_AED else . end) as REVENUEAED_3_HB
		,sum(case when Visit_flag= 1 or Visit_flag=2   then REVENUE_AED else . end) as REVENUEAED_6_HB
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3 then REVENUE_AED else . end) as REVENUEAED_9_HB

		,sum(UNITS) as Total_UNITS_HB 
		,sum(case when Visit_flag=1 then UNITS else . end) as Units_3_HB
		,sum(case when Visit_flag= 1 or Visit_flag=2   then UNITS else . end) as Units_6_HB
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then UNITS else . end) as Units_9_HB

		,( '28Apr2017'd-max(date)) as recency_HB 
		,('28Apr2017'd-max(case when Visit_flag=1 then date else . end))as recency_3_HB
		,('28Apr2017'd-max(case when Visit_flag=1 or Visit_flag = 2 then date else . end))as recency_6_HB
		,('28Apr2017'd-max(case when Visit_flag=1 or Visit_flag = 2 or Visit_flag = 3 then date else . end))as recency_9_HB

		, (max(date)-min(date)) as period_bw_trnxns_HB

		
from SPDTMP7.VB_Apr_HB_TN_ITM_REV_AE_
Group By LMG_MEM_CARD_NUMBER ;
quit;

data SPDTMP7.VB_Apr_HB_TN_ITM_REV_AE_1_1(compress = yes);
set SPDTMP7.VB_Apr_HB_TN_ITM_REV_AE_1;

atv_HB = (Total_REVENUEAED_HB)/NUM_Transactions_HB   ;
atv_HB_3 = (REVENUEAED_3_HB)/NUM_Transactions_3_HB;
atv_HB_6 = (REVENUEAED_6_HB)/NUM_Transactions_6_HB;
atv_HB_9 = (REVENUEAED_9_HB)/NUM_Transactions_9_HB;

run;




proc sql ;
  Create Table SPDTMP7.VB_Apr_BS_TN_ITM_REV_AE_1newer (compress = yes) as
   select LMG_MEM_CARD_NUMBER 
		
   		,count (distinct INVOICE_NUMBER) as NUM_Transactions_BS
	    ,count(distinct (case when Visit_flag = 1 then INVOICE_NUMBER else '' end)) as Num_transactions_3_BS
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 then INVOICE_NUMBER else '' end)) as Num_transactions_6_BS
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3   then INVOICE_NUMBER else '' end)) as Num_transactions_9_BS
		
		,count (distinct TXN_DT_WID)as NUM_VISITS_BS 
		,count(distinct (case when Visit_flag=1 then TXN_DT_WID else . end)) as Num_Visits_3_BS
		,count (distinct (case when Visit_flag=1 or Visit_flag = 2 then TXN_DT_WID else . end)) as Num_Visits_6_BS
		,count(distinct (case when Visit_flag=1 or Visit_flag = 2 or Visit_flag = 3 then TXN_DT_WID else . end)) as Num_Visits_9_BS
			
	
		,count (distinct ITEM_CODE) as NUM_DIST_PRODUCTS_BS 
		,count(distinct(case when Visit_flag=1 then ITEM_CODE else '' end)) as Num_Dist_prod_3_BS
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2   then ITEM_CODE else '' end)) as Num_Dist_prod_6_BS
		,count(distinct (case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then ITEM_CODE else '' end)) as Num_Dist_prod_BS
		
		,sum(Retail_cost_1_AED) as Total_Retail_cost_1_AED_BS
		,sum(case when Visit_flag=1 then Retail_cost_1_AED else . end) as Retail_cost_1_AED_3_BS
		,sum(case when Visit_flag= 1 or Visit_flag=2   then Retail_cost_1_AED else . end) as Retail_cost_1_AED_6_BS
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then Retail_cost_1_AED else . end) as Retail_cost_1_AED_9_BS


		,sum(Retail_cost_2_AED) as Total_Retail_cost_2_AED_BS
		,sum(case when Visit_flag=1 then Retail_cost_2_AED else . end) as Retail_cost_2_AED_3_BS
		,sum(case when Visit_flag= 1 or Visit_flag=2   then Retail_cost_2_AED else . end) as Retail_cost_2_AED_6_BS
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then Retail_cost_2_AED else . end) as Retail_cost_2_AED_9_BS

		,sum(REVENUE_AED) as Total_REVENUEAED_BS
		,sum(case when Visit_flag=1 then REVENUE_AED else . end) as REVENUEAED_3_BS
		,sum(case when Visit_flag= 1 or Visit_flag=2   then REVENUE_AED else . end) as REVENUEAED_6_BS
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3 then REVENUE_AED else . end) as REVENUEAED_9_BS

		,sum(UNITS) as Total_UNITS_BS 
		,sum(case when Visit_flag=1 then UNITS else . end) as Units_3_BS
		,sum(case when Visit_flag= 1 or Visit_flag=2   then UNITS else . end) as Units_6_BS
		,sum(case when Visit_flag= 1 or Visit_flag=2 or Visit_flag=3  then UNITS else . end) as Units_9_BS

		,( '28Apr2017'd-max(date)) as recency_BS 
		,('28Apr2017'd-max(case when Visit_flag=1 then date else . end))as recency_3_BS
		,('28Apr2017'd-max(case when Visit_flag=1 or Visit_flag = 2 then date else . end))as recency_6_BS
		,('28Apr2017'd-max(case when Visit_flag=1 or Visit_flag = 2 or Visit_flag = 3 then date else . end))as recency_9_BS

		, (max(date)-min(date)) as period_bw_trnxns_BS
		
from SPDTMP7.VB_Apr_BS_TN_ITM_REV_AE_
Group By LMG_MEM_CARD_NUMBER ;
quit;




data SPDTMP7.VB_Apr_BS_TN_ITM_REV_AE_1_1(compress = yes);
set SPDTMP7.VB_Apr_BS_TN_ITM_REV_AE_1newer;

atv_BS = (Total_REVENUEAED_BS)/NUM_Transactions_BS;
atv_BS_3 = (REVENUEAED_3_BS)/NUM_Transactions_3_BS;
atv_BS_6 = (REVENUEAED_6_BS)/NUM_Transactions_6_BS;
atv_BS_9 = (REVENUEAED_9_BS)/NUM_Transactions_9_BS;

run;



proc sql;
create table SPDTMP7.VB_Apr_LS_SHHB_TN_ITM_REV_AE_1_1 (Compress = yes) as 
    select * from SPDTMP7.VB_Apr_LS_TN_ITM_REV_AE_1_1  ls
	left join SPDTMP7.VB_Apr_SH_TN_ITM_REV_AE_1_1  sh on ls.LMG_MEM_CARD_NUMBER = sh.LMG_MEM_CARD_NUMBER
	left join  SPDTMP7.VB_Apr_HC_TN_ITM_REV_AE_1_1  hc on ls.LMG_MEM_CARD_NUMBER = hc.LMG_MEM_CARD_NUMBER
	left join SPDTMP7.VB_Apr_HB_TN_ITM_REV_AE_1_1  hb on ls.LMG_MEM_CARD_NUMBER = hb.LMG_MEM_CARD_NUMBER
 	left join SPDTMP7.VB_Apr_BS_TN_ITM_REV_AE_1_1  bs on ls.LMG_MEM_CARD_NUMBER = bs.LMG_MEM_CARD_NUMBER;               
																												
quit;


proc sql;
Create Table SPDTMP7.VB_Apr_ALL_LS_LMG_TN_ITM_REV_AE (compress=yes) as 
select * from SPDTMP7.VB_Apr_LS_SHHB_TN_ITM_REV_AE_1_1 as a
left join SPDTMP7.VB_Apr_ALL_TN_ITM_REV_AE_1_newer as b
on a.LMG_MEM_CARD_NUMBER  = b.LMG_MEM_CARD_NUMBER;
Quit;






/* proc contents data=SPDTMP7.VB_Apr_ALL_LS_LMG_TN_ITM_REV_AE;
run;   */

/*Creating a dataset of final Variables from VB_Apr_ALL_CUST_DETL_LMG_AE Customer Details Table*/
data SPDTMP7.VB_Apr_LS_CUST_DETL_LMG_AE_1  (compress = yes);
set SPDTMP7.VB_Apr_LS_CUST_DETL_LMG_AE (Keep= LMG_MEM_CARD_NUMBER SEX_MF_NAME  
		 LANG_NAME  AGE LMG_EFFECTIVE_POINTS CVM_Nationality_group ); 

run;

/* proc freq data= SPDTMP7.VB_Apr_LS_CUST_DETL_LMG_AE ; */
/*   tables Income_range_name Job_title Marital_stat_name  lang_name active_flg active_lang CVM_Nationality_group/missing;  */
/*   run;  */

/* Excluded variables due to missing data/skewed categories : ENROLLMENT_SOURCE,ACTIVE_FLG,INCOME_RANGE, JOB_TITLE, ACTIVE_FLG, ACTIVE_LANG, MARITAL_STAT_NAME   */

/* joining the Final Transaction Table with the final Customer Details Table */

proc sql;
Create Table SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE (compress=yes) as 
select * from SPDTMP7.VB_Apr_ALL_LS_LMG_TN_ITM_REV_AE as a
left join SPDTMP7.VB_Apr_LS_CUST_DETL_LMG_AE_1 as b
on a.LMG_MEM_CARD_NUMBER  = b.LMG_MEM_CARD_NUMBER;
Quit;

/* Getting the RFM segmentation data for Lifestyle */


data SPDTMP7.VB_Apr_RFM_SGMT_LS_AE (compress=yes) ;
set spddata.RFM_SGMNT_LS_AE ;
by LMG_MEM_CARD_NUMBER seg_yr_end_d  ;
if last.LMG_MEM_CARD_NUMBER then output  ;
run;

data SPDTMP7.VB_Apr_RFM_SGMT_LS_AE_1(compress= yes);
set SPDTMP7.VB_Apr_RFM_SGMT_LS_AE ( drop= LSTAGE_SGMNT) ;
if rfm_sgmnt_n = "0_Not Segmented" then rfm_sgmnt_n = "0 - Not Segmented"  ;
run;


/* Getting the Lifestage segmentation data for Lifestyle */

data SPDTMP7.VB_Apr_LSTG_SGMT_AE (compress= yes);
set spddata.LSTG_SGMNT_AE;
run;

/* Adding the RFM and Lifestage segmentation data */

proc sql;
create table SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_0 (compress = yes) as
select * from SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE as a 
left join SPDTMP7.VB_Apr_RFM_SGMT_LS_AE_1 as b
on a.LMG_MEM_CARD_NUMBER = b.LMG_MEM_CARD_NUMBER
left join SPDTMP7.VB_Apr_LSTG_SGMT_AE as c
on a.LMG_MEM_CARD_NUMBER = c.LMG_MEM_CARD_NUMBER;
quit;


/* Checking for Missing Values and Imputing the missing values */

data SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_1 (compress=yes);
set SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_0 ;
Format age_group $50.0;
Format age_group $50.0;
if age>0 and age <=10 then age_group = "0-10";
else if age>10 and age <=18 then age_group = "11-18";
else if age>19 and age <=25 then age_group = "19-25";
else if age>25 and age<=35 then age_group = "26-35";
else if age>35 and age <=50 then age_group = "36-50";
else if age>50 and age<=75 then age_group = "51-75";
else if age>75 then age_group = ">75";
else age_group = "NA";

run;

/*Imputing age_group*/

data SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_2 (compress= yes);
set SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_1;
where age_group<> "NA";
run;

proc freq data= SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_2;
tables age_group ;
run;


data SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_2 (compress= yes);
set SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_1;
Rand_no = ranuni(123);
if age_group = "NA" and Rand_no <=0.0049 then age_group = "0-10";
else if age_group = "NA" and Rand_no > 0.0049 and Rand_no <= 0.0156 then age_group = "11-18";
else if age_group = "NA" and Rand_no > 0.0156 and Rand_no <= 0.1043 then age_group = "19-25";
else if age_group = "NA" and Rand_no > 0.1043 and Rand_no <= 0.5090 then age_group = "26-35";
else if age_group = "NA" and Rand_no > 0.5090 and Rand_no <= 0.9175 then age_group = "36-50";
else if age_group = "NA" and Rand_no > 0.9175 and Rand_no <= 0.9986 then age_group = "51-75";
else if age_group = "NA" and Rand_no > 0.9986 and Rand_no <= 1.00 then age_group = ">75";

run;



Data SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_3new(compress=yes);
set SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_2;

Rev_LS_perc = Total_REVENUE_AED/LMG_sum_revenue_aed ;
Rev_SH_perc = Total_REVENUEAED_SH/LMG_sum_revenue_aed;
Rev_HC_perc = Total_REVENUEAED_HC/LMG_sum_revenue_aed;
Rev_HB_perc = Total_REVENUEAED_HB/LMG_sum_revenue_aed;

Units_LS_perc = Total_UNITS/total_unit_LMG;
Units_SH_perc = Total_UNITS_SH/total_unit_LMG;
Units_HC_perc = Total_UNITS_HC/total_unit_LMG;
Units_HB_perc = Total_UNITS_HB/total_unit_LMG;
Units_BS_perc = Total_UNITS_BS/total_unit_LMG;

Rev_Grp_WB_perc =  Grp_WB_Revenue/ Total_Revenue_aed;
Rev_Grp_BB_perc =  Grp_BB_Revenue/ Total_Revenue_aed;
Rev_Grp_LS_perc = Grp_LS_Revenue / Total_Revenue_aed;


units_Grp_WB_perc =  Grp_WB_units/ Total_units;
units_Grp_BB_perc =  Grp_BB_units/ Total_units;
units_Grp_LS_perc =  Grp_NM_units / Total_units;

Rev_d_Cosm_perc  = Dpt_Cosm_Rev/Total_Revenue_aed;
Rev_d_HomFrag_perc = Dpt_HomeFrag_Rev/ Total_Revenue_aed;
Rev_d_TeenG_perc = Dpt_TeenGifts_Rev/ Total_Revenue_aed;
Rev_d_FashAcc_perc= Dpt_FashAcc_Rev/ Total_Revenue_aed;
Rev_d_HairAcc_perc = Dpt_HairAcc_Rev/ Total_Revenue_aed;
Rev_d_Spa_perc = Dpt_Spa_Rev/Total_Revenue_aed;
Rev_d_Tow_perc = Dpt_Tow_Rev/Total_Revenue_aed;

Units_d_Cosm_perc  = Dpt_Cosm_units/Total_units;
Units_d_HomFrag_perc = Dpt_HomeFrag_units/ Total_units;
Units_d_TeenG_perc = Dpt_TeenGifts_units/Total_units ;
Units_d_FashAcc_perc= Dpt_FashAcc_units/ Total_units;
Units_d_HairAcc_perc = Dpt_HairAcc_units/ Total_units;
Units_d_Spa_perc = Dpt_Spa_units/Total_units;
Units_d_Tow_perc = Dpt_Tow_units/Total_units;

run;



/* Filling "."s with 0 for numeric variables */


proc stdize data=SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_3new OUT=SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_4  reponly missing=0;

run; 


/*Making dummy variables for Categorical Variables */

data SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_5(compress=yes);
set SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_4;
		/* Age Dummy */
  age_dummy_1 = (age_group = "0-10") ;
  age_dummy_2 = (age_group = "11-18");
  age_dummy_3 = (age_group = "19-25");
  age_dummy_4 = (age_group = "26-35");
  age_dummy_5 = (age_group = "36-50");
  age_dummy_6 = (age_group = "51-75");

      /*Nationality Dummy*/
  Nationality_Local = (CVM_Nationality_group = "Local");
  Nationality_ExpatArab = ( CVM_Nationality_group = "Expat Arab" );
  Nationality_ISC = (CVM_Nationality_group = "ISC");
  
		/*Gender Dummy */
  Sex_F_dummy = (SEX_MF_NAME = "F"); 
  Sex_M_Dummy = (SEX_MF_NAME = "M") ;
  		/*Language Dummy*/
  Lang_Arabic = (Lang_Name = "Arabic");
  Lang_English = (Lang_Name = "English");

      /*RFM dummy */
  RFM_1 = (rfm_sgmnt_n = "1 - Least Engaged");
  RFM_2 = (rfm_sgmnt_n = "2 - Occasional");
  RFM_3 = (rfm_sgmnt_n = "3 - Sleeping_stars");
  RFM_4 = (rfm_sgmnt_n = "4 - Average");
  RFM_5 = (rfm_sgmnt_n = "5 - Gold");
  RFM_6 = (rfm_sgmnt_n = "6 - Premium");
     /* Lsegmnt dummy */
  Lstg_sgmnt_1 = (Lstage_Sgmnt = "1. Singles");
  Lstg_sgmnt_2 = (Lstage_Sgmnt = "2. Couples");
  Lstg_sgmnt_3 = (Lstage_Sgmnt = "3. Family w. Baby");
  Lstg_sgmnt_4 = (Lstage_Sgmnt = "4. Family w. Kids");
  Lstg_sgmnt_5 = (Lstage_Sgmnt = "5. Family w. Teen");
  Lstg_sgmnt_6 = (Lstage_Sgmnt = "6. Small Family");
  Lstg_sgmnt_7 = (Lstage_Sgmnt = "7. Large Family");
  	
run;


proc means data= SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_5;
run;

 /*Scoring*/

proc logistic  
     inmodel = SPDTMP7.VB_CUS_TN_ITM_REV_AE_scoring_new;
     score data =  SPDTMP7.VB_Apr_CUS_TN_ITM_REV_AE_5
	 Out  = SPDTMP7.VB_CUS_TN_ITM_REV_AE_Aprscr;
run;   




 data xxx (Compress=yes);
      set spdtmp7.sd_txn_wb ;
  	   where TXN_DT_WID >= 20170401 and TXN_DT_WID<= 20170431 and LMG_CONCEPT_NAME = "Lifestyle" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;
	   Bought_flag = 1;
 run;


proc sql;
 create table yyy as 
 select distinct lmg_mem_card_number, bought_flag from xxx;
 quit;


proc sql;
create table zzz(compress=yes) as
select a.lmg_mem_card_number,a.P_1, b.Bought_flag from SPDTMP7.VB_CUS_TN_ITM_REV_AE_Aprscr a
left join yyy b
on a.lmg_mem_card_number = b.lmg_mem_card_number;

quit;

Data zzz1;
set zzz;
if bought_flag = . then bought_flag = 0;
pred_bought_flag = ( P_1 >= 0.12);

run;


proc freq data= zzz1;
table Bought_flag * pred_bought_flag;
run;






