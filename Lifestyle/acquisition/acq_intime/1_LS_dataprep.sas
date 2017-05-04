
%include'/home/unxsrv/code/Automated_Solutions/Libnames/LIBNAMES.sas';

   
proc sql;
create table spdtmp7.VB_AQ_Cus2016 (compress=yes) as 
select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where txn_dt_wid>=20160201 and txn_dt_wid<=20170131 and 
Lmg_mem_card_number not in (select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where Lmg_concept_name="Lifestyle" and txn_dt_wid>=20160201  and txn_dt_wid<=20170131 );
quit;

/*2years*/
proc sql;
create table spdtmp7.VB_AQ_Cus201516 (compress=yes) as 
select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where txn_dt_wid>=20150201 and txn_dt_wid<=20170131 and 
Lmg_mem_card_number not in (select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where Lmg_concept_name="Lifestyle" and txn_dt_wid>=20150201  and txn_dt_wid<=20170131 );
quit; 


data spdtmp7.VB_AQ_LS_Cust;
merge spdtmp7.VB_AQ_Cus201516(in=a) spdtmp7.VB_AQ_Cus2016(in=b);
if a=1 and b=1 ;
by lmg_mem_card_number;
run;


/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number) from spdtmp7.sd_txn_wb*/
/*where LMG_concept_name="Lifestyle" and txn_dt_wid<=20161231;*/
/*quit;*/


/*proc delete data=spdtmp7.VB_AQ_LS_TXN_Cust2015;run;*/
/**/
/*proc delete data=spdtmp7.VB_AQ_LS_TXN_Cust2016;run;*/

/*Table for wb cust base all obs*/

proc sql;
create table spdtmp7.VB_AQ_LS_TXN(compress=yes) as
select a.*, b.* from  spdtmp7.VB_AQ_LS_Cust a
left join spdtmp7.sd_txn_wb b
on a.LMG_mem_card_number = b.LMG_mem_card_number;
run;




