data spdtmp7.sd_hc_lifestage_add(compress=yes drop=Lstage_sgmnt) ;
set spddata.LSTG_SGMNT_AE ;
by LMG_MEM_CARD_NUMBER ;
if last.LMG_MEM_CARD_NUMBER then output  ;
run; 


proc sql; 
create table spdtmp7.sd_hc_txn_acapr(compress=y) as
select a.*,b.* from spdtmp7.sd_hc_txn_acapr a left join spdtmp7.sd_hc_lifestage_add b
on a.LMG_mem_card_number=b.LMG_mem_card_number;
quit;