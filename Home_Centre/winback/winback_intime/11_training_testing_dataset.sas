data spdtmp7.sd_hc_txn_wb(compress=yes);
   set spdtmp7.sd_hc_txn_wb;
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


proc means data=spdtmp7.sd_hc_trainingwb;
run;







data spdtmp7.sd_hc_tempwb(compress=yes);
set spdtmp7.sd_hc_txn_wb;
n=ranuni(8);
proc sort data=spdtmp7.sd_hc_tempwb(compress=yes);
  by n;
  data spdtmp7.sd_hc_trainingwb(compress=yes) spdtmp7.sd_hc_testingwb(compress=yes);
   set spdtmp7.sd_hc_tempwb nobs=nobs;
   if _n_<=.7*nobs then output spdtmp7.sd_hc_trainingwb;
    else output spdtmp7.sd_hc_testingwb;
   run;


   proc contents data=spdtmp7.sd_hc_trainingwb out=a;
   run;