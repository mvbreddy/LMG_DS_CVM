%include'/home/unxsrv/code/Automated_Solutions/Libnames/LIBNAMES.sas';


data spdtmp7.sd_txn_wb(compress=yes);
set sascrm.tn_itm_rev_ae;
where txn_dt_wid>=20140101 and txn_dt_wid<=20170415;
run;

/*2015 custs*/



proc sql;
create table spdtmp7.sd_txn_custhc2015 (compress=yes) as 
select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where Lmg_concept_name="Home center" and txn_dt_wid>=20150401 and txn_dt_wid<=20160331
group by LMG_mem_card_number;
quit;


proc sql;
create table abc(compress=yes) as 
select count(distinct LMG_mem_Card_number) from spdtmp7.sd_hc_txn_wb_cust ;
quit;
/*2016 custs*/

proc sql;
create table spdtmp7.sd_txn_custhc2016 (compress=yes) as 
select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb where
 txn_dt_wid>=20160401 and  txn_dt_wid<=20170331 and Lmg_mem_card_number not in (select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where Lmg_concept_name="Home center" and txn_dt_wid>=20160401  and txn_dt_wid<=20170331 );
quit;



/*winback cust base*/

data spdtmp7.sd_hc_txn_wb_cust_apr(compress=yes);
merge spdtmp7.sd_txn_custhc2015(in=a) spdtmp7.sd_txn_custhc2016(in=b);
if a=1 and b=1 ;
by LMG_mem_card_number;
run;



proc sql;
create table abc(compress=yes) as 
select count(distinct LMG_mem_Card_number) from spdtmp7.sd_txn_wb
where LMG_concept_name="Home center" and txn_dt_wid<=20161231;
quit;


proc delete data=spdtmp7.sd_txn_custhc2015;run;

proc delete data=spdtmp7.sd_txn_custhc2016;run;


data check (compress=yes);
merge spdtmp7.sd_hc_txn_wb_cust(in=a) spdtmp7.sd_hc_txn_final7(in=b);
by LMG_mem_card_number;
if a=1 and b=1 ;

run;
proc sql;
create table x as
select LMG_mem_Card_number, LMG_concept_name, txn_dt_wid from
spdtmp7.sd_txn_wb where LMG_mem_Card_number="1800000006365902" and LMG_concept_name="Home center";
quit;