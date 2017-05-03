
data spdtmp7.sd_hc_txn_final6_oos(compress=yes);
   set spdtmp7.sd_hc_txn_final6_oos;
   array change _numeric_;
        do over change;
            if change=. then change=0;
        end;
		array _nums {*} _numeric_;
do i = 1 to dim(_nums);
  _nums{i} = round(_nums{i},.001);
end;
drop i;



if no_of_txn=0 then atv=0;
else if no_of_txn<>0 then
atv=sum_revenue_aed/no_of_txn;

if no_of_txn_3=0 then atv_3=0;
else if no_of_txn_3<>0 then
atv_3=sum_revenue_Aed_3/no_of_txn_3;

if no_of_txn_6=0 then atv_6=0;
else if no_of_txn_6<>0 then
atv_6=sum_revenue_aed_6/no_of_txn_6;

if no_of_txn_9=0 then atv_9=0;
else if no_of_txn_9<>0 then
atv_9=sum_revenue_Aed_9/no_of_txn_9;

if no_of_txn_lmg=0 then atv_lmg=0;
else if no_of_txn_lmg<>0 then
atv_lmg=sum_revenue_Aed_lmg/no_of_txn_lmg;

if no_of_txn_lmg3=0 then atv_lmg3=0;
else if no_of_txn_lmg3<>0 then
atv_lmg3=sum_revenue_Aed_lmg3/no_of_txn_lmg3;

if no_of_txn_lmg6=0 then atv_lmg6=0;
else if no_of_txn_lmg6<>0 then
atv_lmg6=sum_revenue_Aed_lmg6/no_of_txn_lmg6;

if no_of_txn_lmg9=0 then atv_lmg9=0;
else if no_of_txn_lmg9<>0 then
atv_lmg9=sum_revenue_Aed_lmg9/no_of_txn_lmg9;

if no_of_txn_ls=0 then atv_ls=0;
else if no_of_txn_ls<>0 then
atv_ls=sum_revenue_aed_ls/no_of_txn_ls;

if no_of_txn_hb=0 then atv_hb=0;
else if no_of_txn_hb<>0 then
atv_hb=sum_revenue_aed_hb/no_of_txn_hb;

if no_of_txn_bs=0 then atv_bs=0;
else if no_of_txn_bs<>0 then
atv_bs=sum_revenue_aed_bs/no_of_txn_bs;

if no_of_txn_em=0 then atv_em=0;
else if no_of_txn_em<>0 then
atv_em=sum_revenue_aed_em/no_of_txn_em;

run;
proc sql;
create table spdtmp7.sd_hc_txn_final6_oos (compress=yes) as 
select *, ((sum_revenue_aed_ls)/(sum_revenue_Aed))*100 as perc_revenue_ls,
((sum_revenue_aed_bs)/(sum_revenue_Aed_lmg))*100 as perc_revenue_bs,
((sum_revenue_aed_em)/(sum_revenue_Aed_lmg))*100 as perc_revenue_em,
((sum_revenue_aed_hb)/(sum_revenue_Aed_lmg))*100 as perc_revenue_hb,
((total_unit_ls)/(total_unit_lmg))*100 as perc_unit_ls,
((total_unit_bs)/(total_unit_lmg))*100 as perc_unit_bs,
((total_unit_em)/(total_unit_lmg))*100 as perc_unit_em,
((total_unit_hb)/(total_unit_lmg))*100 as perc_unit_hb

from spdtmp7.sd_hc_txn_final6_oos;
quit;
data spdtmp7.sd_hc_txn_final6_oos(compress=yes);
   set spdtmp7.sd_hc_txn_final6_oos;
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
     inmodel = spdtmp7.sd_hc_scoring;
     score data = spdtmp7.sd_hc_txn_final6_oos
     Out  = spdtmp7.sd_hc_test_score_oos;
run;    

data spdtmp7.sd_hc_model_confusion_oos;
set spdtmp7.sd_hc_test_score_oos;

if P_1 >= 0.07 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.sd_hc_model_confusion_oos;
        table purchase_flag * prediction ;
run;



