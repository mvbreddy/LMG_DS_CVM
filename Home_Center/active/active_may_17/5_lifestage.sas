data spdtmp7.sd_hc_lifestage_may ;
set spddata.RFM_SGMNT_hc_AE ;
by LMG_MEM_CARD_NUMBER seg_yr_end_d  ;
if last.LMG_MEM_CARD_NUMBER then output  ;
run; 


proc freq data=spdtmp7.sd_hc_lifestage_may;
tables rfm_sgmnt_n Lstage_Sgmnt;

data spdtmp7.sd_hc_lifestage1_may (keep= LMG_mem_Card_Number  RFM_1 RFM_2 RFM_3 RFM_4 RFM_5 RFM_6 Lstg_sgmnt_1 Lstg_sgmnt_2 Lstg_sgmnt_3 Lstg_sgmnt_4 Lstg_sgmnt_5 Lstg_sgmnt_6 Lstg_sgmnt_7);
set spdtmp7.sd_hc_lifestage_may;


  RFM_1 = (rfm_sgmnt_n = "1 - Least Engaged" or rfm_sgmnt_n= "1_Least Engaged");
  RFM_2 = (rfm_sgmnt_n = "2 - Occasional" or rfm_sgmnt_n="2_Occasional");
  RFM_3 = (rfm_sgmnt_n = "3 - Sleeping_stars" or rfm_sgmnt_n="3_Sleeping_stars");
  RFM_4 = (rfm_sgmnt_n = "4 - Average" or rfm_sgmnt_n="4_Average");
  RFM_5 = (rfm_sgmnt_n = "5 - Gold" or rfm_sgmnt_n="5_Gold");
  RFM_6 = (rfm_sgmnt_n = "6 - Premium" or rfm_sgmnt_n="6_Premium");     /* Lsegmnt dummy */
  Lstg_sgmnt_1 = (Lstage_Sgmnt = "1. Singles");
  Lstg_sgmnt_2 = (Lstage_Sgmnt = "2. Couples");
  Lstg_sgmnt_3 = (Lstage_Sgmnt = "3. Family w. Baby");
  Lstg_sgmnt_4 = (Lstage_Sgmnt = "4. Family w. Kids");
  Lstg_sgmnt_5 = (Lstage_Sgmnt = "5. Family w. Teen");
  Lstg_sgmnt_6 = (Lstage_Sgmnt = "6. Small Family");
  Lstg_sgmnt_7 = (Lstage_Sgmnt = "7. Large Family");
  run;

  proc sql; 
create table spdtmp7.sd_hc_activemay(compress=yes) as
select a.*,b.* from spdtmp7.sd_hc_activemay a left join spdtmp7.sd_hc_lifestage1_may b
on a.LMG_mem_card_number=b.LMG_mem_card_number;
quit;



proc freq data= spdtmp7.sd_hc_activemay;
tables  RFM_1 RFM_2 RFM_3 RFM_4 RFM_5 RFM_6 Lstg_sgmnt_1 Lstg_sgmnt_2 Lstg_sgmnt_3 Lstg_sgmnt_4 Lstg_sgmnt_5 Lstg_sgmnt_6 Lstg_sgmnt_7;
run;