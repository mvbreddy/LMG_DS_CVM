



proc sql ;
  Create Table SPDTMP30.VB_SH_TN_ITM_REV_AE_1 (compress = yes) as
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

		,( '28Feb2017'd-max(date)) as recency_SH 
		,('28Feb2017'd-max(case when Visit_flag=1 then date else . end))as recency_3_SH
		,('28Feb2017'd-max(case when Visit_flag=1 or Visit_flag = 2 then date else . end))as recency_6_SH
		,('28Feb2017'd-max(case when Visit_flag=1 or Visit_flag = 2 or Visit_flag = 3 then date else . end))as recency_9_SH

		, (max(date)-min(date)) as period_bw_trnxns_SH

		from SPDTMP30.VB_SH_TN_ITM_REV_AE_
Group By LMG_MEM_CARD_NUMBER ;
quit;

data SPDTMP30.VB_SH_TN_ITM_REV_AE_1_1(compress = yes);
set SPDTMP30.VB_SH_TN_ITM_REV_AE_1;

atv_SH = (Total_REVENUEAED_SH)/NUM_Transactions_SH;
atv_SH_3 = (REVENUEAED_3_SH)/NUM_Transactions_3_SH;
atv_SH_6 = (REVENUEAED_6_SH)/NUM_Transactions_6_SH;
atv_SH_9 = (REVENUEAED_9_SH)/NUM_Transactions_9_SH;

run;