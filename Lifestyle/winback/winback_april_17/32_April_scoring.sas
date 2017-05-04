

proc logistic  
     inmodel = spdtmp7.VB_WB_LS_Train_scores;    /* Use the outmodel file from Model_Training here */ 
     score data = spdtmp7.VB_WB_Apr_LS_Alldata14
	 Out  = spdtmp30.VB_WB_LS_Apr_scores;
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
select a.lmg_mem_card_number,a.P_1, b.Bought_flag from spdtmp30.VB_WB_LS_Apr_scores a
left join yyy b
on a.lmg_mem_card_number = b.lmg_mem_card_number;

quit;

Data zzz1;
set zzz;
if bought_flag = . then bought_flag = 0;
pred_bought_flag = ( P_1 >= 0.0173);

run;


proc freq data= zzz1;
table Bought_flag * pred_bought_flag;
run;





 data temp_march2017 (Compress=yes);
      set spdtmp7.sd_txn_wb ;
  	   where TXN_DT_WID >= 20170301 and TXN_DT_WID<= 20170331 and LMG_CONCEPT_NAME = "Lifestyle" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;
	   Bought_flag = 1;
 run;

proc sql ;
create table customers_march (compress=yes) as
select Distinct LMG_MEM_CARD_NUMBER, Bought_flag from temp_march2017 ;
quit;

proc sql;
create table temp_cust (Compress = yes) as 
select lmg_mem_card_number from spdtmp30.VB_WB_LS_Apr_scores;
quit; 



proc sql;
create table temp_march1 as
select * from temp_cust a
left join customers_march b
on a.lmg_mem_card_number = b.lmg_mem_card_number;
quit;


proc freq data= temp_march1;
tables Bought_flag;
run;