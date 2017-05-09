proc logistic  
     inmodel = spdtmp7.sd_hc_scoringwb;
     score data = spdtmp7.sd_hc_txn_wboos
     Out  = spdtmp7.sd_hc_test_scorewb1;
run;    
data spdtmp7.sd_hc_model_confusionwb1;
set spdtmp7.sd_hc_test_scorewb1;

if P_1 >= 0.042 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.sd_hc_model_confusionwb1;
        table purchase_flag * prediction ;
run;