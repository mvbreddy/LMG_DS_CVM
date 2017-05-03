data spdtmp7.sd_hc_txn_wbapr(compress=yes);
   set spdtmp7.sd_hc_txn_wbapr;
   array change _numeric_;
        do over change;
            if change=. then change=0;
        end;
		array _nums {*} _numeric_;
do i = 1 to dim(_nums);
  _nums{i} = round(_nums{i},.001);
end;
drop i;
run;



proc logistic  
     inmodel = spdtmp7.sd_hc_scoringwb;
     score data = spdtmp7.sd_hc_txn_wbapr
     Out  = spdtmp7.sd_hc_test_scorewbapr1(compress=yes);
run;    
data spdtmp7.sd_hc_model_confusionwbapr1;
set spdtmp7.sd_hc_test_scorewbapr1;

if P_1 >= 0.0395 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.sd_hc_model_confusionwbapr1;
        table purchase_flag * prediction ;
run;