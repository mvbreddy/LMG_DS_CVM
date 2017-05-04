

 data SPDTMP7.VB_AQ_LS_TXN_DV (Compress=yes);
      set spdtmp7.sd_txn_wb ;
  	   where TXN_DT_WID >= 20170201 and TXN_DT_WID<= 20170231 and LMG_CONCEPT_NAME = "Lifestyle" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;
	   Bought_flag = 1;
 run;


proc sql ;
create table SPDTMP7.VB_AQ_LS_Customers (compress=yes) as
select Distinct LMG_MEM_CARD_NUMBER, Bought_flag from SPDTMP7.VB_AQ_LS_TXN_DV ;
quit;

proc sql;
create table spdtmp7.VB_AQ_LS_Alldata13 (Compress = yes) as 
select a.*,b.*
from spdtmp7.VB_AQ_LS_Alldata12 as a
left join SPDTMP7.VB_AQ_LS_Customers as b
on a.LMG_MEM_CARD_NUMBER = b.LMG_MEM_CARD_NUMBER;
quit; 




Data spdtmp7.VB_AQ_LS_Alldata14 (compress=yes);
set spdtmp7.VB_AQ_LS_Alldata13;


Rev_SH_perc = sum_revenue_aed_SH/sum_revenue_aed_lmg;
Rev_HC_perc = sum_revenue_aed_HC/sum_revenue_aed_lmg;
Rev_HB_perc = sum_revenue_aed_HB/sum_revenue_aed_lmg;
Rev_SM_perc = sum_revenue_aed_SM/sum_revenue_aed_lmg;
Rev_MX_perc = sum_revenue_aed_MX/sum_revenue_aed_lmg;
Rev_BS_perc = sum_revenue_aed_BS/sum_revenue_aed_lmg;


Units_SH_perc = total_unit_SH/total_unit_lmg;
Units_HC_perc = total_unit_HC/total_unit_lmg;
Units_HB_perc = total_unit_HB/total_unit_lmg;
Units_BS_perc = total_unit_BS/total_unit_lmg;
Units_MX_perc = total_unit_MX/total_unit_lmg;
Units_SM_perc = total_unit_SM/total_unit_lmg;


run;


proc stdize data=spdtmp7.VB_AQ_LS_Alldata14 OUT=spdtmp7.VB_AQ_LS_Alldata15 (compress=yes)  reponly missing=0;

run; 

/*proc freq data= spdtmp7.VB_AQ_LS_Alldata16;*/
/*tables Bought_flag;*/
/*run;*/




/* Dividing data into Train and Test Datasets*/

Data spdtmp7.VB_AQ_LS_Alldata16 (compress= yes drop= rnd_no);
set spdtmp7.VB_AQ_LS_Alldata15;    /* For running the model without stratification change this file name to _5* With stratification _6 */
rnd_no = ranuni(123);
if rnd_no < 0.7 then data_divide = "Training";
else data_divide = "Test";
run;

Data spdtmp7.VB_AQ_LS_Alldata16_Train (compress=yes Drop=data_divide);
set spdtmp7.VB_AQ_LS_Alldata16;
where data_divide = "Training";
run; 

Data spdtmp7.VB_AQ_LS_Alldata16_Test (compress=yes Drop= data_divide);
set spdtmp7.VB_AQ_LS_Alldata16;
where data_divide = "Test";
run;

proc freq data= spdtmp7.VB_AQ_LS_Alldata16;
tables Bought_flag;
run;




proc delete data= spdtmp7.VB_AQ_LS_Alldata12; run;
proc delete data= spdtmp7.VB_AQ_LS_Alldata11; run;
proc delete data= spdtmp7.VB_AQ_LS_Alldata10; run;
proc delete data= spdtmp7.VB_AQ_LS_Alldata9;run;
proc delete data= spdtmp7.VB_AQ_LS_Alldata8;run;
proc delete data= spdtmp7.VB_AQ_LS_Alldata7;run;
proc delete data= spdtmp7.VB_AQ_LS_Alldata6;run;
proc delete data= spdtmp7.VB_AQ_LS_Alldata5;run;
proc delete data= spdtmp7.VB_AQ_LS_Alldata4;run;
proc delete data= spdtmp7.VB_AQ_LS_Alldata3;run;
proc delete data= spdtmp7.VB_AQ_LS_Alldata2;run;