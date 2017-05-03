%include'/home/unxsrv/code/Automated_Solutions/Libnames/LIBNAMES.sas';




data spdtmp7.sd_txn_wb(compress=yes);
set sascrm.tn_itm_rev_ae;
where txn_dt_wid>=20140101 and txn_dt_wid<=20170415;
run;

proc sql;
create table spdtmp7.sd_txn_custhc2014oos (compress=yes) as 
select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where Lmg_concept_name="Home center" and txn_dt_wid>=20140301 and txn_dt_wid<=20150228
group by LMG_mem_card_number;
quit;


proc sql;
create table abc(compress=yes) as 
select count(distinct LMG_mem_Card_number) from spdtmp7.sd_hc_txn_wb_cust ;
quit;
/*2015 custs*/

proc sql;
create table spdtmp7.sd_txn_custhc2015oos (compress=yes) as 
select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb where
 txn_dt_wid>=20150301 and  txn_dt_wid<=20160229 and Lmg_mem_card_number not in (select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where Lmg_concept_name="Home center" and txn_dt_wid>=20150301 and txn_dt_wid<=20160229 );
quit;



/*winback cust base*/

data spdtmp7.sd_hc_txn_wb_custoos(compress=yes);
merge spdtmp7.sd_txn_custhc2014oos(in=a) spdtmp7.sd_txn_custhc2015oos(in=b);
if a=1 and b=1 ;
by LMG_mem_card_number;
run;



proc sql;
create table abc(compress=yes) as 
select count(distinct LMG_mem_Card_number) from spdtmp7.sd_txn_wb
where LMG_concept_name="Home center" and txn_dt_wid<=20161231;
quit;


proc delete data=spdtmp7.sd_txn_custhc2014oos;run;

proc delete data=spdtmp7.sd_txn_custhc2015oos;run;


data check(compress=yes);
merge spdtmp7.sd_hc_txn_wb_custoos(in=a) spdtmp7.sd_hc_txn_ac_cust_oos(in=b) spdtmp7.sd_hc_txn_final6_oos(in=c);
if a=1 and b=1 and c=1;
by LMG_mem_card_number;
run;
