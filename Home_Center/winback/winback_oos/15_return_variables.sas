data spdtmp7.sd_hc_lifestage_return(compress=yes keep=LMG_mem_card_number MC_return_units MC_return_revenue_aed MC_L9m_return_units MC_L9m_return_revenue_aed MC_L6m_return_units MC_L6m_return_revenue_aed MC_L3m_return_units MC_L3m_return_revenue_aed ) ;
set spddata.RFM_SGMNT_hc_AE ;
by LMG_MEM_CARD_NUMBER seg_yr_end_d  ;
if last.LMG_MEM_CARD_NUMBER then output  ;
run; 




 proc sql; 
create table spdtmp7.sd_hc_txn_wboos(compress=y) as
select a.*,b.* from spdtmp7.sd_hc_txn_wboos a left join spdtmp7.sd_hc_lifestage_return b
on a.LMG_mem_card_number=b.LMG_mem_card_number;
quit;




data spdtmp7.sd_hc_lifestage_add(compress=yes drop=Lstage_sgmnt) ;
set spddata.LSTG_SGMNT_AE ;
by LMG_MEM_CARD_NUMBER ;
if last.LMG_MEM_CARD_NUMBER then output  ;
run; 


proc sql; 
create table spdtmp7.sd_hc_txn_wboos(compress=y) as
select a.*,b.* from spdtmp7.sd_hc_txn_wboos a left join spdtmp7.sd_hc_lifestage_add b
on a.LMG_mem_card_number=b.LMG_mem_card_number;
quit;