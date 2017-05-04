


proc sql; 
create table spdtmp7.VB_AQ_LS_Alldata (compress=yes) as
select a.*,c.*,d.*,e.*,f.*,g.*,h.* from spdtmp7.VB_AQ_LMG_TXN_Overall a 
left join spdtmp7.VB_AQ_LS_SH_TXN_Overall c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_AQ_LS_HC_TXN_Overall d on a.LMG_mem_card_number=d.LMG_mem_card_number
left join spdtmp7.VB_AQ_LS_HB_TXN_Overall e on a.LMG_mem_card_number=e.LMG_mem_card_number
left join spdtmp7.VB_AQ_LS_BS_TXN_Overall f on a.LMG_mem_card_number=f.LMG_mem_card_number
left join spdtmp7.VB_AQ_LS_SM_TXN_Overall g on a.LMG_mem_card_number=g.LMG_mem_card_number
left join spdtmp7.VB_AQ_LS_MX_TXN_Overall h on a.LMG_mem_card_number=h.LMG_mem_card_number;

quit;




proc delete data=spdtmp7.VB_AQ_LS_SH_TXN_Overall;run;
proc delete data=spdtmp7.VB_AQ_LS_HC_TXN_Overall;run;
proc delete data=spdtmp7.VB_AQ_LS_HB_TXN_Overall;run;
proc delete data=spdtmp7.VB_AQ_LS_BS_TXN_Overall;run;
proc delete data=spdtmp7.VB_AQ_LS_SM_TXN_Overall;run;
proc delete data=spdtmp7.VB_AQ_LS_MX_TXN_Overall;run;

 
/* Joining the customer demographic details table */

proc sql;
create table spdtmp7.VB_AQ_LS_Alldata1 as
select * from spdtmp7.VB_AQ_LS_Alldata a
left join SPDTMP7.VB_LS_CUST_DETL_LMG_AE_1 b
on a.LMG_MEM_CARD_NUMBER  = b.LMG_MEM_CARD_NUMBER;
quit;

/*proc means data=spdtmp7.VB_AQ_LS_Alldata1;*/
/*run;*/



