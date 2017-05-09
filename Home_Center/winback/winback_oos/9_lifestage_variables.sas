


proc contents data=spdtmp7.sd_hc_txn_wboos;
run;

data spdtmp7.sd_hc_lifestage(compress=yes) ;
set spddata.RFM_SGMNT_hc_AE ;
by LMG_MEM_CARD_NUMBER seg_yr_end_d  ;
if last.LMG_MEM_CARD_NUMBER then output  ;
run; 


proc freq data=spdtmp7.sd_hc_lifestage;
tables rfm_sgmnt_n Lstage_Sgmnt;

/*Lstg_sgmnt_1 Lstg_sgmnt_2 Lstg_sgmnt_3 Lstg_sgmnt_4 Lstg_sgmnt_5 Lstg_sgmnt_6 Lstg_sgmnt_7*/

data spdtmp7.sd_hc_lifestage (compress= y keep= LMG_mem_Card_Number  RFM_1 RFM_2 RFM_3 RFM_4 RFM_5 RFM_6 );
set spdtmp7.sd_hc_lifestage;


  RFM_1 = (rfm_sgmnt_n = "1 - Least Engaged" or rfm_sgmnt_n= "1_Least Engaged");
  RFM_2 = (rfm_sgmnt_n = "2 - Occasional" or rfm_sgmnt_n="2_Occasional");
  RFM_3 = (rfm_sgmnt_n = "3 - Sleeping_stars" or rfm_sgmnt_n="3_Sleeping_stars");
  RFM_4 = (rfm_sgmnt_n = "4 - Average" or rfm_sgmnt_n="4_Average");
  RFM_5 = (rfm_sgmnt_n = "5 - Gold" or rfm_sgmnt_n="5_Gold");
  RFM_6 = (rfm_sgmnt_n = "6 - Premium" or rfm_sgmnt_n="6_Premium");     /* Lsegmnt dummy */
/*  Lstg_sgmnt_1 = (Lstage_Sgmnt = "1. Singles");*/
/*  Lstg_sgmnt_2 = (Lstage_Sgmnt = "2. Couples");*/
/*  Lstg_sgmnt_3 = (Lstage_Sgmnt = "3. Family w. Baby");*/
/*  Lstg_sgmnt_4 = (Lstage_Sgmnt = "4. Family w. Kids");*/
/*  Lstg_sgmnt_5 = (Lstage_Sgmnt = "5. Family w. Teen");*/
/*  Lstg_sgmnt_6 = (Lstage_Sgmnt = "6. Small Family");*/
/*  Lstg_sgmnt_7 = (Lstage_Sgmnt = "7. Large Family");*/
  run;

  proc sql; 
create table spdtmp7.sd_hc_txn_wboos(compress=y) as
select a.*,b.* from spdtmp7.sd_hc_txn_wboos a left join spdtmp7.sd_hc_lifestage b
on a.LMG_mem_card_number=b.LMG_mem_card_number;
quit;


proc freq data= spdtmp7.sd_hc_txn_wboos;
tables  RFM_1 RFM_2 RFM_3 RFM_4 RFM_5 RFM_6 ;
run;


proc sql;
select count(LMG_mem_card_number) from spdtmp7.sd_hc_txn_final6
;
quit;

proc delete data= spdtmp7.sd_hc_txn_wboos1;
run;
 

proc delete data=spdtmp7.sd_hc_lifestage;
run;




data spdtmp7.sd_hc_lifestage1(compress=yes) ;
set spddata.LSTG_SGMNT_AE ;
by LMG_MEM_CARD_NUMBER ;
if last.LMG_MEM_CARD_NUMBER then output  ;
run; 


proc freq data=spdtmp7.sd_hc_lifestage1;
tables Lstage_Sgmnt;
run;


  



 proc sql; 
create table spdtmp7.sd_hc_txn_wboos(compress=y) as
select a.*,b.Lstage_Sgmnt from spdtmp7.sd_hc_txn_wboos a left join spdtmp7.sd_hc_lifestage1 b
on a.LMG_mem_card_number=b.LMG_mem_card_number;
quit;



data spdtmp7.sd_hc_txn_wboos;
set spdtmp7.sd_hc_txn_wboos;
if Lstage_Sgmnt ="" or Lstage_Sgmnt ="8. Unclassified"
then Lstage_Sgmnt ="NA";
else Lstage_Sgmnt =Lstage_Sgmnt ;
run;


data spdtmp7.sd_hc_txn_wboos_11;
set spdtmp7.sd_hc_txn_wboos;
where Lstage_Sgmnt <>"NA";
run;

proc freq data=spdtmp7.sd_hc_txn_wboos_11;
table Lstage_Sgmnt;
run;



data spdtmp7.sd_hc_txn_wboos(compress= yes);
set spdtmp7.sd_hc_txn_wboos;
Rand_no = ranuni(123);

if Lstage_Sgmnt ="NA" and Rand_no <=.0897 then Lstage_Sgmnt = "1. Singles";
else if Lstage_Sgmnt ="NA" and Rand_no > 0.0897 and Rand_no <= .1454 then Lstage_Sgmnt  = "2. Couples";
else if Lstage_Sgmnt ="NA" and Rand_no > 0.1454and Rand_no <= .1678 then Lstage_Sgmnt  = "3. Family w. Baby";
else if Lstage_Sgmnt ="NA" and Rand_no > 0.1678and Rand_no <= .2788 then Lstage_Sgmnt  = "4. Family w. Kids";
else if Lstage_Sgmnt ="NA" and Rand_no > 0.2788 and Rand_no <= .3163 then Lstage_Sgmnt  = "5. Family w. Teen";
else if Lstage_Sgmnt ="NA" and Rand_no > 0.3163 and Rand_no <= .6032 then Lstage_Sgmnt  = "6. Small Family";
else if Lstage_Sgmnt ="NA" and Rand_no > 0.6032and Rand_no <= 1 then Lstage_Sgmnt  = "7. Large Family";

else Lstage_Sgmnt =Lstage_Sgmnt ;

run;

proc freq data=spdtmp7.sd_hc_txn_wboos1;
tables Lstage_Sgmnt;
run;

data spdtmp7.sd_hc_txn_wboos (compress= y );
set spdtmp7.sd_hc_txn_wboos;


/*  RFM_1 = (rfm_sgmnt_n = "1 - Least Engaged" or rfm_sgmnt_n= "1_Least Engaged");*/
/*  RFM_2 = (rfm_sgmnt_n = "2 - Occasional" or rfm_sgmnt_n="2_Occasional");*/
/*  RFM_3 = (rfm_sgmnt_n = "3 - Sleeping_stars" or rfm_sgmnt_n="3_Sleeping_stars");*/
/*  RFM_4 = (rfm_sgmnt_n = "4 - Average" or rfm_sgmnt_n="4_Average");*/
/*  RFM_5 = (rfm_sgmnt_n = "5 - Gold" or rfm_sgmnt_n="5_Gold");*/
/*  RFM_6 = (rfm_sgmnt_n = "6 - Premium" or rfm_sgmnt_n="6_Premium");     /* Lsegmnt dummy */

Lstg_sgmnt_1 = (Lstage_Sgmnt = "1. Singles");
  Lstg_sgmnt_2 = (Lstage_Sgmnt = "2. Couples");
  Lstg_sgmnt_3 = (Lstage_Sgmnt = "3. Family w. Baby");
  Lstg_sgmnt_4 = (Lstage_Sgmnt = "4. Family w. Kids");
  Lstg_sgmnt_5 = (Lstage_Sgmnt = "5. Family w. Teen");
  Lstg_sgmnt_6 = (Lstage_Sgmnt = "6. Small Family");
  Lstg_sgmnt_7 = (Lstage_Sgmnt = "7. Large Family");
  run;



proc freq data= spdtmp7.sd_hc_txn_wboos1;
tables  RFM_1 RFM_2 RFM_3 RFM_4 RFM_5 RFM_6 Lstg_sgmnt_1 Lstg_sgmnt_2 Lstg_sgmnt_3 Lstg_sgmnt_4 Lstg_sgmnt_5 Lstg_sgmnt_6 Lstg_sgmnt_7 ;
run;