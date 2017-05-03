data spdtmp7.sd_hc_txn_acapr(compress=yes );
   set spdtmp7.sd_hc_txn_acapr;
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
data spdtmp7.sd_hc_txn_acapr (compress=yes);
set spdtmp7.sd_hc_txn_acapr;
run;

proc logistic  
     inmodel = spdtmp7.sd_hc_scoringac;
     score data = spdtmp7.sd_hc_txn_acapr
     Out  = spdtmp7.sd_hc_scoreacapr;
run;    

data spdtmp7.sd_hc_model_confusionac;
set spdtmp7.sd_hc_scoreacapr;

if P_1 >= 0.0132 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.sd_hc_model_confusionac;
        table purchase_flag * prediction ;
run;


proc freq data=spdtmp7.sd_hc_txn_acapr;
tables purchase_flag;
run;

