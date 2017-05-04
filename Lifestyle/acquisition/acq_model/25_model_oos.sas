


ODS graphics on;
proc logistic data = spdtmp7.VB_AQ_OOS_LS_Alldata15 plots=ROC ; 
        model  Bought_flag = &variables2. /  lackfit rsquare ctable outroc=ROC_sd;
 roc; 
run;
ods graphics off;

proc means data= spdtmp7.VB_AQ_OOS_LS_Alldata15;
run;

/* scoring the OOS Dataset */


proc logistic  
     inmodel = spdtmp7.VB_AQ_LS_Train_scores;    /* Use the outmodel file from Model_Training here */ 
     score data = spdtmp7.VB_AQ_OOS_LS_Alldata15
	 Out  = spdtmp7.VB_AQ_OOS_LS_Alldata15_OOS_res;
run; 
   

data spdtmp7.VB_AQ_OOS_LS_Alldata15_OOS_Conf;
set spdtmp7.VB_AQ_OOS_LS_Alldata15_OOS_res;

if P_1 >= 0.011 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.VB_AQ_OOS_LS_Alldata15_OOS_Conf;
        table Bought_flag * prediction ;
run;

/* Lift for OOS data */

 proc rank data=spdtmp7.VB_AQ_OOS_LS_Alldata15_OOS_res out= spdtmp7.VB_AQ_OOS_LS_Alldata15_dec ties=low
 descending groups=10;
 var P_1;
 ranks decile;
 run;

proc sql;
 select sum(Bought_flag) into: total_hits
 from spdtmp7.VB_AQ_OOS_LS_Alldata15_OOS_res
 ;
 create table spdtmp7.VB_AQ_OOS_LS_Alldata15_lift as
 select sum(Bought_flag)/&total_hits as true_positive_rate,decile + 1 as decile
 from spdtmp7.VB_AQ_OOS_LS_Alldata15_dec
 group by decile
 order by decile
 ;
 quit;



 data spdtmp7.VB_AQ_OOS_cum_lift;
 set spdtmp7.VB_AQ_OOS_LS_Alldata15_lift;
 cum_positive_rate + true_positive_rate;
 cum_lift=cum_positive_rate/(decile/10);
 run;