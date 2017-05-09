
proc contents data=spdtmp7.sd_hc_txn_acoos;
run;

proc logistic  
     inmodel = spdtmp7.sd_hc_scoringac;
     score data = spdtmp7.sd_hc_txn_acoos
     Out  = spdtmp7.sd_hc_test_scoreac1;
run;    
data spdtmp7.sd_hc_model_confusionac1;
set spdtmp7.sd_hc_test_scoreac1;

if P_1 >= 0.0111 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.sd_hc_model_confusionac1;
        table purchase_flag * prediction ;
run;





