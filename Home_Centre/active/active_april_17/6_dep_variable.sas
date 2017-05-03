data spdtmp7.sd_hc_txn_dep(compress=yes);
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20170401 and txn_dt_wid<=20170430 and Lmg_concept_name="Home center";
run;


proc sql;
create table spdtmp7.sd_hc_txn_dep1 (compress=yes) as 
select distinct LMG_mem_card_number from spdtmp7.sd_hc_txn_dep
group by LMG_mem_card_number;
run;

data spdtmp7.sd_hc_txn_dep2(compress=yes);
set spdtmp7.sd_hc_txn_dep1;
purchase_flag=1;
run;

proc sql;
create table spdtmp7.sd_hc_txn_dep3 (compress=yes) as
select a.*,b.* from spdtmp7.sd_hc_txn_final6_apr a left join spdtmp7.sd_hc_txn_dep2 b on
a.LMG_mem_card_number=b.LMG_mem_Card_number;
run;

data spdtmp7.sd_hc_txn_final6_apr(compress=yes);
set spdtmp7.sd_hc_txn_dep3;
if purchase_flag=. then purchase_flag=0;
else purchase_flag=purchase_flag;
run;