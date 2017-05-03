data spdtmp7.sd_hc_txn_dep_oos(compress=y);
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20160301 and txn_dt_wid<=20160331 and Lmg_concept_name="Home center";
run;


proc sql;
create table spdtmp7.sd_hc_txn_dep1_oos(compress=y) as 
select distinct LMG_mem_card_number from spdtmp7.sd_hc_txn_dep_oos
group by LMG_mem_card_number;
run;

data spdtmp7.sd_hc_txn_dep2_oos(compress=y);
set spdtmp7.sd_hc_txn_dep1_oos;
purchase_flag=1;
run;

proc sql;
create table spdtmp7.sd_hc_txn_final6_oos(compress=y) as
select a.*,b.* from spdtmp7.sd_hc_txn_final6_oos a left join spdtmp7.sd_hc_txn_dep2_oos b on
a.LMG_mem_card_number=b.LMG_mem_Card_number;
run;

data spdtmp7.sd_hc_txn_final6_oos(compress=y);
set spdtmp7.sd_hc_txn_final6_oos;
if purchase_flag=. then purchase_flag=0;
else purchase_flag=purchase_flag;
run;



proc means data= spdtmp7.sd_hc_txn_final2_oos;
run;
