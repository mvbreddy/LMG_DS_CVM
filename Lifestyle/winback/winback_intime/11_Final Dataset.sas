


 data SPDTMP7.VB_WB_LS_TXN_DV (Compress=yes);
      set spdtmp7.sd_txn_wb ;
  	  where TXN_DT_WID >= 20170201 and TXN_DT_WID<= 20170231 and LMG_CONCEPT_NAME = "Lifestyle" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;
	   Bought_flag = 1;
 run;

proc sql ;
create table SPDTMP7.VB_WB_LS_Customers (compress=yes) as
select Distinct LMG_MEM_CARD_NUMBER, Bought_flag from SPDTMP7.VB_WB_LS_TXN_DV ;
quit;

proc sql;
create table spdtmp7.VB_WB_LS_Alldata13 (Compress = yes) as 
select a.*,b.*
from spdtmp7.VB_WB_LS_Alldata12 as a
left join SPDTMP7.VB_WB_LS_Customers as b
on a.LMG_MEM_CARD_NUMBER = b.LMG_MEM_CARD_NUMBER;
quit; 

Data spdtmp7.VB_WB_LS_Alldata14 (compress=yes);
set spdtmp7.VB_WB_LS_Alldata13;

Rev_LS_perc = sum_revenue_aed/sum_revenue_aed_lmg ;
Rev_SH_perc = sum_revenue_aed_SH/sum_revenue_aed_lmg;
Rev_HC_perc = sum_revenue_aed_HC/sum_revenue_aed_lmg;
Rev_HB_perc = sum_revenue_aed_HB/sum_revenue_aed_lmg;
Rev_SM_perc = sum_revenue_aed_SM/sum_revenue_aed_lmg;
Rev_MX_perc = sum_revenue_aed_MX/sum_revenue_aed_lmg;
Rev_BS_perc = sum_revenue_aed_BS/sum_revenue_aed_lmg;

Units_LS_perc = total_unit/total_unit_lmg;
Units_SH_perc = total_unit_SH/total_unit_lmg;
Units_HC_perc = total_unit_HC/total_unit_lmg;
Units_HB_perc = total_unit_HB/total_unit_lmg;
Units_BS_perc = total_unit_BS/total_unit_lmg;
Units_MX_perc = total_unit_MX/total_unit_lmg;
Units_SM_perc = total_unit_SM/total_unit_lmg;

Rev_Grp_Beauty_perc =  revenue_AED_Beauty/ sum_revenue_aed;
Rev_Grp_TG_perc =  revenue_Aed_TG/ sum_revenue_aed;
Rev_Grp_HF_perc = revenue_Aed_HF / sum_revenue_aed;
Rev_Grp_Fas_perc = revenue_Aed_Fas / sum_revenue_aed;

units_Beauty_perc =  total_units_Beauty/ total_unit;
units_TG_perc =  total_units_TG/ total_unit;
units_HF_perc =  total_units_HF / total_unit;
units_Fas_perc =  total_units_Fas / total_unit;

Rev_d_400_perc  = revenue_aed_400/sum_Revenue_aed;
Rev_d_401_perc  = revenue_aed_401/sum_Revenue_aed;
Rev_d_402_perc  = revenue_aed_402/sum_Revenue_aed;
Rev_d_403_perc  = revenue_aed_403/sum_Revenue_aed;
Rev_d_404_perc  = revenue_aed_404/sum_Revenue_aed;
Rev_d_405_perc  = revenue_aed_405/sum_Revenue_aed;
Rev_d_406_perc  = revenue_aed_406/sum_Revenue_aed;
Rev_d_407_perc  = revenue_aed_407/sum_Revenue_aed;
Rev_d_408_perc  = revenue_aed_408/sum_Revenue_aed;
Rev_d_409_perc  = revenue_aed_409/sum_Revenue_aed;
Rev_d_410_perc  = revenue_aed_410/sum_Revenue_aed;
Rev_d_411_perc  = revenue_aed_411/sum_Revenue_aed;
Rev_d_412_perc  = revenue_aed_412/sum_Revenue_aed;
Rev_d_413_perc  = revenue_aed_413/sum_Revenue_aed;
Rev_d_415_perc  = revenue_aed_415/sum_Revenue_aed;
Rev_d_416_perc  = revenue_aed_416/sum_Revenue_aed;
Rev_d_417_perc  = revenue_aed_417/sum_Revenue_aed;
Rev_d_418_perc  = revenue_aed_418/sum_Revenue_aed;
Rev_d_419_perc  = revenue_aed_419/sum_Revenue_aed;

Units_d_400_perc  = Units_400/total_unit;
Units_d_401_perc  = Units_401/total_unit;
Units_d_402_perc  = Units_402/total_unit;
Units_d_403_perc  = Units_403/total_unit;
Units_d_404_perc  = Units_404/total_unit;
Units_d_405_perc  = Units_405/total_unit;
Units_d_406_perc  = Units_406/total_unit;
Units_d_407_perc  = Units_407/total_unit;
Units_d_408_perc  = Units_408/total_unit;
Units_d_409_perc  = Units_409/total_unit;
Units_d_410_perc  = Units_410/total_unit;
Units_d_411_perc  = Units_411/total_unit;
Units_d_412_perc  = Units_412/total_unit;
Units_d_413_perc  = Units_413/total_unit;
Units_d_415_perc  = Units_415/total_unit;
Units_d_416_perc  = Units_416/total_unit;
Units_d_417_perc  = Units_417/total_unit;
Units_d_418_perc  = Units_418/total_unit;
Units_d_419_perc  = Units_419/total_unit;

no_of_txn_d_400_perc  = no_of_txn_400/no_of_txn;
no_of_txn_d_401_perc  = no_of_txn_401/no_of_txn;
no_of_txn_d_402_perc  = no_of_txn_402/no_of_txn;
no_of_txn_d_403_perc  = no_of_txn_403/no_of_txn;
no_of_txn_d_404_perc  = no_of_txn_404/no_of_txn;
no_of_txn_d_405_perc  = no_of_txn_405/no_of_txn;
no_of_txn_d_406_perc  = no_of_txn_406/no_of_txn;
no_of_txn_d_407_perc  = no_of_txn_407/no_of_txn;
no_of_txn_d_408_perc  = no_of_txn_408/no_of_txn;
no_of_txn_d_409_perc  = no_of_txn_409/no_of_txn;
no_of_txn_d_410_perc  = no_of_txn_410/no_of_txn;
no_of_txn_d_411_perc  = no_of_txn_411/no_of_txn;
no_of_txn_d_412_perc  = no_of_txn_412/no_of_txn;
no_of_txn_d_413_perc  = no_of_txn_413/no_of_txn;
no_of_txn_d_415_perc  = no_of_txn_415/no_of_txn;
no_of_txn_d_416_perc  = no_of_txn_416/no_of_txn;
no_of_txn_d_417_perc  = no_of_txn_417/no_of_txn;
no_of_txn_d_418_perc  = no_of_txn_418/no_of_txn;
no_of_txn_d_419_perc  = no_of_txn_419/no_of_txn;

run;



proc stdize data=spdtmp7.VB_WB_LS_Alldata14 OUT=spdtmp7.VB_WB_LS_Alldata15 (compress=yes)  reponly missing=0;

run; 

proc freq data= spdtmp7.VB_WB_LS_Alldata15;
tables Bought_flag;
run;

proc delete data= spdtmp7.VB_WB_LS_Alldata2; run;
proc delete data= spdtmp7.VB_WB_LS_Alldata3; run;

proc delete data= spdtmp7.VB_WB_LS_Alldata4; run;
proc delete data= spdtmp7.VB_WB_LS_Alldata5; run;
proc delete data= spdtmp7.VB_WB_LS_Alldata6; run;

proc delete data= spdtmp7.VB_WB_LS_Alldata7; run;
proc delete data= spdtmp7.VB_WB_LS_Alldata8; run;
proc delete data= spdtmp7.VB_WB_LS_Alldata9; run;


proc delete data= spdtmp7.VB_WB_LS_Alldata12; run;
proc delete data= spdtmp7.VB_WB_LS_Alldata11; run;
proc delete data= spdtmp7.VB_WB_LS_Alldata10; run;


/* Dividing data into Train and Test Datasets*/


Data spdtmp7.VB_WB_LS_Alldata16 (compress= yes drop= rnd_no);
set spdtmp7.VB_WB_LS_Alldata15;    /* For running the model without stratification change this file name to _5* With stratification _6 */
rnd_no = ranuni(123);
if rnd_no < 0.7 then data_divide = "Training";
else data_divide = "Test";
run;

Data spdtmp7.VB_WB_LS_Alldata16_Train (compress=yes Drop=data_divide);
set spdtmp7.VB_WB_LS_Alldata16;
where data_divide = "Training";
run; 

Data spdtmp7.VB_WB_LS_Alldata16_Test (compress=yes Drop= data_divide);
set spdtmp7.VB_WB_LS_Alldata16;
where data_divide = "Test";
run;

proc freq data= spdtmp7.VB_WB_LS_Alldata16;
tables lstage_sgmnt rfm_sgmnt_n;
run;

