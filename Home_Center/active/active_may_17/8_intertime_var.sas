data spdtmp7.sd_hc_txn_lag_may (compress=yes keep= LMG_mem_card_number txn_dt_wid revenue_aed date);
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20160501 and txn_dt_wid<=20170430 and Lmg_concept_name="Home center";
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;	


data spdtmp7.sd_hc_txn_lag1_may;
set spdtmp7.sd_hc_txn_lag_may;
by LMG_mem_card_number date;
format amount_lag amount_dif dollar10.2;
amount_lag = lag(revenue_aed);
amount_dif = dif(revenue_aed);
days_dif = dif(date);
if first.LMG_mem_card_number then do;
 amount_lag=.;
 amount_dif=.;
 days_dif=.;
 end; 


run;

proc sql;
create table spdtmp7.sd_hc_txn_lag2_may as
select LMG_mem_card_number, avg(amount_dif) as avg_amount_dif, avg(days_dif) as avg_days_dif
from spdtmp7.sd_hc_txn_lag1_may group by LMG_mem_card_number;
run;

proc sql;
create table spdtmp7.sd_hc_activemay(compress=yes) as
select a.*,b.* from spdtmp7.sd_hc_activemay a left join spdtmp7.sd_hc_txn_lag2_may b
on a.LMG_mem_card_number=b.LMG_mem_card_number;
quit;


data spdtmp7.sd_hc_txn_final5_apr(compress=yes);
   set spdtmp7.sd_hc_txn_final4_apr;
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
