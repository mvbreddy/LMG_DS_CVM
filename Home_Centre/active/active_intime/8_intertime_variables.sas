data spdtmp7.sd_hc_txn_lag (compress=yes keep= LMG_mem_card_number txn_dt_wid revenue_aed date);
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20160301 and txn_dt_wid<=20170228 and Lmg_concept_name="Home center";
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;	


data spdtmp7.sd_hc_txn_lag1(compress=yes);
set spdtmp7.sd_hc_txn_lag;
by LMG_mem_card_number date;


days_dif = dif(date);
if first.LMG_mem_card_number then do;

 days_dif=.;
 end; 


run;

proc sql;
create table spdtmp7.sd_hc_txn_lag2 (compress=yes)as
select LMG_mem_card_number, avg(days_dif) as avg_days_dif
from spdtmp7.sd_hc_txn_lag1 group by LMG_mem_card_number;
run;

proc sql;
create table spdtmp7.sd_hc_txn_final4 (compress=yes) as
select a.*,b.* from spdtmp7.sd_hc_txn_final3 a left join spdtmp7.sd_hc_txn_lag2 b
on a.LMG_mem_card_number=b.LMG_mem_card_number;
quit;
proc contents data= spdtmp7.sd_hc_txn_final4;
run;
proc means data= spdtmp7.sd_hc_txn_final4;
run;

data sd_hc_txn_final5;
set spdtmp7.sd_hc_txn_final4;

s1=sum_revenue_aed;
n1=no_of_txn;

s2=sum_revenue_Aed_3;
n2=no_of_txn_3;
run;

data spdtmp7.sd_hc_txn_final5(compress=yes);
   set spdtmp7.sd_hc_txn_final4;
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

proc contents data=spdtmp7.sd_hc_txn_final5(compress=yes) out=a;
run;

proc means data=spdtmp7.sd_hc_txn_final5;
run;



