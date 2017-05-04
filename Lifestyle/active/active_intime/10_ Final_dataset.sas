




data SPDTMP7.VB_LS_TN_ITM_REV_AE_Model (Compress=yes);
      set sascrm.TN_ITM_REV_AE ;
  	   where TXN_DT_WID >= 20170201 and TXN_DT_WID<= 20170228 and LMG_CONCEPT_NAME = "Lifestyle" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;
	   Bought_flag = 1;
run;

proc sql ;
create table SPDTMP7.VB_LS_TN_ITM_REV_AE_Cust (compress=yes) as
select Distinct LMG_MEM_CARD_NUMBER, Bought_flag from SPDTMP7.VB_LS_TN_ITM_REV_AE_Model ;
quit;

proc sql;
create table SPDTMP7.VB_CUS_TN_ITM_REV_AE_3 (Compress = yes) as 
select *
from SPDTMP7.VB_CUS_TN_ITM_REV_AE_2 as a
left join SPDTMP7.VB_LS_TN_ITM_REV_AE_Cust as b
on a.LMG_MEM_CARD_NUMBER = b.LMG_MEM_CARD_NUMBER;
quit; 

Data SPDTMP7.VB_CUS_TN_ITM_REV_AE_3new;
set SPDTMP7.VB_CUS_TN_ITM_REV_AE_3;

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


proc stdize data=SPDTMP7.VB_CUS_TN_ITM_REV_AE_3new OUT=SPDTMP7.VB_CUS_TN_ITM_REV_AE_4  reponly missing=0;

run; 


/*Making dummy variables for Categorical Variables */

data SPDTMP7.VB_CUS_TN_ITM_REV_AE_5;
set SPDTMP7.VB_CUS_TN_ITM_REV_AE_4;
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




Data SPDTMP7.VB_CUS_TN_ITM_REV_AE_7 (drop= rnd_no);
set SPDTMP7.VB_CUS_TN_ITM_REV_AE_5;    /* For running the model without stratification change this file name to _5* With stratification _6 */
rnd_no = ranuni(123);
if rnd_no < 0.7 then data_divide = "Training";
else data_divide = "Test";
run;

Data SPDTMP7.VB_CUS_TN_ITM_REV_AE_Training (Drop=data_divide);
set SPDTMP7.VB_CUS_TN_ITM_REV_AE_7;
where data_divide = "Training";
run; 

Data SPDTMP7.VB_CUS_TN_ITM_REV_AE_Test (Drop= data_divide);
set SPDTMP7.VB_CUS_TN_ITM_REV_AE_7;
where data_divide = "Test";
run;