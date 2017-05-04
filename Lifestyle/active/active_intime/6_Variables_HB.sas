




proc sql ;
  Create Table SPDTMP7.VB_HB_TN_ITM_REV_AE_1 (compress = yes) as
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

		,( '28Feb2017'd-max(date)) as recency_HB 
		,('28Feb2017'd-max(case when Visit_flag=1 then date else . end))as recency_3_HB
		,('28Feb2017'd-max(case when Visit_flag=1 or Visit_flag = 2 then date else . end))as recency_6_HB
		,('28Feb2017'd-max(case when Visit_flag=1 or Visit_flag = 2 or Visit_flag = 3 then date else . end))as recency_9_HB

		, (max(date)-min(date)) as period_bw_trnxns_HB

		
from SPDTMP7.VB_HB_TN_ITM_REV_AE_
Group By LMG_MEM_CARD_NUMBER ;
quit;

data SPDTMP7.VB_HB_TN_ITM_REV_AE_1_1(compress = yes);
set SPDTMP7.VB_HB_TN_ITM_REV_AE_1;

atv_HB = (Total_REVENUEAED_HB)/NUM_Transactions_HB   ;
atv_HB_3 = (REVENUEAED_3_HB)/NUM_Transactions_3_HB;
atv_HB_6 = (REVENUEAED_6_HB)/NUM_Transactions_6_HB;
atv_HB_9 = (REVENUEAED_9_HB)/NUM_Transactions_9_HB;

run;