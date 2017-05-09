data spdtmp7.sd_hc_txn_acoos2(compress=yes keep= LMG_mem_card_number txn_dt_wid revenue_aed date);
set spdtmp7.sd_txn_acoos_all;
where txn_dt_wid>=20150301 and txn_dt_wid<=20160229;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;	


data spdtmp7.sd_hc_txn_acoos2(compress=yes);
set spdtmp7.sd_hc_txn_acoos2;
by LMG_mem_card_number date;


days_dif = dif(date);
if first.LMG_mem_card_number then do;

 days_dif=.;
 end; 


run;
data spdtmp7.sd_hc_txn_acoos(compress=yes drop=days_dif avg_days_dif);
set spdtmp7.sd_hc_txn_acoos;
run;

proc sql;
create table spdtmp7.sd_hc_txn_acoos2(compress=yes)as
select LMG_mem_card_number, avg(days_dif) as avg_days_dif
from spdtmp7.sd_hc_txn_acoos2 group by LMG_mem_card_number;
quit;



proc sql;
create table spdtmp7.sd_hc_txn_acoos (compress=yes) as
select a.*,b.avg_days_dif from spdtmp7.sd_hc_txn_acoos a left join spdtmp7.sd_hc_txn_acoos2 b
on a.LMG_mem_card_number=b.LMG_mem_card_number;
quit;
proc contents data= spdtmp7.sd_hc_txn_acoos;
run;
proc means data= spdtmp7.sd_hc_txn_acoos;
run;

/*data spdtmp7.sd_hc_txn_acoos (drop=avg_days_dif);*/
/*set spdtmp7.sd_hc_txn_acoos;*/
/*run;*/

data spdtmp7.sd_hc_txn_acoos(compress=yes );
   set spdtmp7.sd_hc_txn_acoos;
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



proc means data=spdtmp7.sd_hc_txn_acoos;
run;



proc delete data=spdtmp7.sd_hc_txn_acoos1;run;


data spdtmp7.sd_hc_txn_acoos(compress=yes );
   set spdtmp7.sd_hc_txn_acoos;
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