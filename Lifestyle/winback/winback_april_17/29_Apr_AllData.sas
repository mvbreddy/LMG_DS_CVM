






proc sql; 
create table spdtmp7.VB_WB_Apr_LS_Alldata (compress=yes, drop = age) as
select a.*,b.*,c.*,d.*,e.*,f.*,g.*,h.* from spdtmp7.VB_WB_Apr_LS_TXN_5 a 
left join  spdtmp7.VB_WB_Apr_LMG_TXN_Overall b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_SH_TXN_Overall c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_HC_TXN_Overall d on a.LMG_mem_card_number=d.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_HB_TXN_Overall e on a.LMG_mem_card_number=e.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_BS_TXN_Overall f on a.LMG_mem_card_number=f.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_MX_TXN_Overall g on a.LMG_mem_card_number=g.LMG_mem_card_number
left join spdtmp7.VB_WB_Apr_LS_SM_TXN_Overall h on a.LMG_mem_card_number=h.LMG_mem_card_number;
quit;


proc delete data= spdtmp7.VB_WB_Apr_LS_SH_TXN_Overall;run;
proc delete data=spdtmp7.VB_WB_Apr_LS_HC_TXN_Overall;run;
proc delete data=spdtmp7.VB_WB_Apr_LS_HB_TXN_Overall;run;
proc delete data=spdtmp7.VB_WB_Apr_LS_BS_TXN_Overall;run;
proc delete data=spdtmp7.VB_WB_Apr_LS_MX_TXN_Overall;run; 
proc delete data=spdtmp7.VB_WB_Apr_LS_SM_TXN_Overall;run;





/* Joining the customer demographic details table */

proc sql;
create table spdtmp7.VB_WB_Apr_LS_Alldata1(compress = yes) as
select * from spdtmp7.VB_WB_Apr_LS_Alldata a
left join SPDTMP7.VB_LS_CUST_DETL_LMG_AE_1 b
on a.LMG_MEM_CARD_NUMBER  = b.LMG_MEM_CARD_NUMBER;
quit;



/* Getting the RFM segmentation data for Lifestyle */


/*data SPDTMP7.VB_RFM_SGMT_LS_AE (compress=yes) ;*/
/*set spddata.RFM_SGMNT_LS_AE ;*/
/*by LMG_MEM_CARD_NUMBER seg_yr_end_d  ;*/
/*if last.LMG_MEM_CARD_NUMBER then output  ;*/
/*run;*/

data SPDTMP7.VB_RFM_SGMT_LS_AE_1(compress= yes);
set SPDTMP7.VB_RFM_SGMT_LS_AE ( drop= LSTAGE_SGMNT) ;
if rfm_sgmnt_n = "0_Not Segmented" then rfm_sgmnt_n = "0 - Not Segmented"  ;
run;


/* Getting the Lifestage segmentation data for Lifestyle */

data SPDTMP7.VB_LSTG_SGMT_AE (compress= yes);
set spddata.LSTG_SGMNT_AE;
run;

/* Adding the RFM and Lifestage segmentation data */

proc sql;
create table spdtmp7.VB_WB_Apr_LS_Alldata1 (compress = yes) as
select * from spdtmp7.VB_WB_Apr_LS_Alldata1 as a 
left join SPDTMP7.VB_RFM_SGMT_LS_AE_1 as b
on a.LMG_MEM_CARD_NUMBER = b.LMG_MEM_CARD_NUMBER
left join SPDTMP7.VB_LSTG_SGMT_AE as c
on a.LMG_MEM_CARD_NUMBER = c.LMG_MEM_CARD_NUMBER;
quit;
