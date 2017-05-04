


proc sql;
  create table SPDTMP30.VB_LS_TN_ITM_REV_AE_0 (compress = yes) as
  select t1.* , t2.GRP_CD , t2.GRP_NM , t2.DPT_CD, DPT_NM from SPDTMP30.VB_LS_TN_ITM_REV_AE_ as t1
  left join SPDTMP30.VB_LS_Dim_itm_ls as t2
  on t1.ITEM_CODE = t2.ITM_CD;
 quit;

 
proc sql ;
  Create Table SPDTMP30.VB_LS_TN_ITM_REV_AE_1 (compress = yes) as
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

		,( '28Feb2017'd-max(date)) as recency 
		,('28Feb2017'd- max(case when Visit_flag=1 then date else . end))as recency_3
		,('28Feb2017'd- max(case when Visit_flag=1 and Visit_flag = 2 then date else . end))as recency_6
		,('28Feb2017'd- max(case when Visit_flag=1 and Visit_flag = 2 and Visit_flag = 3 then date else . end))as recency_9

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

		,('28Feb2017'd - max(case when LMG_STORE_TYPE = "Centerpoint" then date else . end)) as recency_CP
		,('28Feb2017'd - max(case when LMG_STORE_TYPE = "Stand alone" then date else . end)) as recency_Standalone 
		,('28Feb2017'd - max(case when LMG_STORE_TYPE = "Multi Concept" then date else . end)) as recency_MC
		
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

from SPDTMP30.VB_LS_TN_ITM_REV_AE_0
Group By LMG_MEM_CARD_NUMBER ;
quit;




data SPDTMP30.VB_LS_TN_ITM_REV_AE_1_1 (compress=yes);
set SPDTMP30.VB_LS_TN_ITM_REV_AE_1;

atv_LS = (Total_REVENUE_AED)/NUM_Transactions   ;
atv_LS_3 = (REVENUEAED_3)/NUM_Transactions_3;
atv_LS_6 = (REVENUEAED_6)/NUM_Transactions_6;
atv_LS_9 = (REVENUEAED_9)/NUM_Transactions_9;

run;