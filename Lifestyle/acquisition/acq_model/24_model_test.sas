





proc reg data= spdtmp7.VB_AQ_LS_Alldata16_Test ;
    model Bought_flag =  &variables1./ VIF;
run; 


ODS graphics on;
proc logistic data = spdtmp7.VB_AQ_LS_Alldata16_Test plots=ROC ; 
        model  Bought_flag = &variables2. /  lackfit rsquare ctable outroc=ROC_sd;
 roc; 
run;
ods graphics off;


/* Scoring the Test Data */

proc logistic  
     inmodel = spdtmp7.VB_AQ_LS_Train_scores;
     score data = spdtmp7.VB_AQ_LS_Alldata16_Test
	 Out  = spdtmp7.VB_AQ_LS_Alldata16_Test_res;
run; 
   

data spdtmp7.VB_AQ_LS_Alldata16_Test_Conf;
set spdtmp7.VB_AQ_LS_Alldata16_Test_res;

if P_1 >= 0.0087 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.VB_AQ_LS_Alldata16_Test_Conf;
        table Bought_flag * prediction ;
run;



/* Lift for test data */

 proc rank data=spdtmp7.VB_AQ_LS_Alldata16_Test_res out= spdtmp7.VB_AQ_LS_Alldata16_Test_dec ties=low
 descending groups=10;
 var P_1;
 ranks decile;
 run;

proc sql;
 select sum(Bought_flag) into: total_hits
 from spdtmp7.VB_AQ_LS_Alldata16_Test_res
 ;
 create table spdtmp7.VB_AQ_LS_Alldata16_Test_lift as
 select sum(Bought_flag)/&total_hits as true_positive_rate,decile + 1 as decile
 from spdtmp7.VB_AQ_LS_Alldata16_Test_dec
 group by decile
 order by decile
 ;
 quit;



 data cum_lift;
 set spdtmp7.VB_AQ_LS_Alldata16_Test_lift;
 cum_positive_rate + true_positive_rate;
 cum_lift=cum_positive_rate/(decile/10);
 run;

 
















 