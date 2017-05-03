data spdtmp7.sd_hc_txn_final7(compress=yes);
   set spdtmp7.sd_hc_txn_final6;
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


proc means data=spdtmp7.sd_hc_txn_final7;
run;

proc contents data=spdtmp7.sd_hc_training out=a;
run;




data spdtmp7.sd_hc_temp;
set spdtmp7.sd_hc_txn_final7;
n=ranuni(8);
proc sort data=spdtmp7.sd_hc_temp;
  by n;
  data spdtmp7.sd_hc_training spdtmp7.sd_hc_testing;
   set spdtmp7.sd_hc_temp nobs=nobs;
   if _n_<=.7*nobs then output spdtmp7.sd_hc_training;
    else output spdtmp7.sd_hc_testing;
   run;


   data spdtmp7.sd_hc_temp1;
set spdtmp7.sd_hc_txn_final7;
n=ranuni(8);
proc sort data=spdtmp7.sd_hc_temp1;
  by n;
  data spdtmp7.sd_hc_training1 spdtmp7.sd_hc_testing1;
   set spdtmp7.sd_hc_temp nobs=nobs;
   if _n_<=.25*nobs then output spdtmp7.sd_hc_training1;
    else output spdtmp7.sd_hc_testing1;
   run;

   proc contents data=spdtmp7.sd_hc_temp;
   run;


   data validation (compress=yes);
   set spdtmp7.sd_hc_txn_final7;
   where LMG_mem_Card_number="1500000001975484";
   run;

   data validation1 (compress=yes);
   set sascrm.tn_itm_rev_ae;
   where txn_dt_wid>=20160301 and txn_dt_wid<=20170228 and LMG_mem_Card_number="1500000001975484";
   run;