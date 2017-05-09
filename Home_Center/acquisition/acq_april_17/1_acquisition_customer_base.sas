%include'/home/unxsrv/code/Automated_Solutions/Libnames/LIBNAMES.sas';


data spdtmp7.sd_txn_wb(compress=yes);
set sascrm.tn_itm_rev_ae;
where txn_dt_wid>=20140101 and txn_dt_wid<=20170415;
run;

/*2015-16 non homecenter custs*/




proc sql;
create table spdtmp7.sd_txn_custnonhc16_may (compress=yes) as 
select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where txn_dt_wid>=20160501 and txn_dt_wid<=20170430 and 
Lmg_mem_card_number not in (select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where Lmg_concept_name="Home center" and txn_dt_wid>=20160501  and txn_dt_wid<=20170430 );
quit;

/*2years*/
proc sql;
create table spdtmp7.sd_txn_custnonhc1516_may (compress=yes) as 
select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where txn_dt_wid>=20150501 and txn_dt_wid<=20170430 and 
Lmg_mem_card_number not in (select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where Lmg_concept_name="Home center" and txn_dt_wid>=20150501  and txn_dt_wid<=20170430 );
quit;

data spdtmp7.sd_hc_txn_ac_cust_apr(compress=yes);
merge spdtmp7.sd_txn_custnonhc1516_may(in=b) spdtmp7.sd_txn_custnonhc16_may(in=a);
by LMG_mem_Card_number;
if a=1 and b=1 ;
run;





proc sql;
create table abc(compress=yes) as 
select count(distinct LMG_mem_Card_number) from spdtmp7.sd_hc_txn_ac ;
quit;


proc delete data=spdtmp7.sd_txn_custnonhc15;run;




proc means data=spdtmp7.sd_txn_wb;
var txn_dt_wid;
run;


data x(compress=yes);
merge spdtmp7.sd_hc_txn_final6(in=a) spdtmp7.sd_hc_txn_ac_cust(in=b) spdtmp7.sd_hc_txn_wb_cust(in=c);

by LMG_mem_card_number;
if a=1 and b=1 and c=1 ;

run;

proc sql;
create table x as
select * from spdtmp7.sd_txn_wb where LMG_mem_card_number= '1800000006365351';
quit;