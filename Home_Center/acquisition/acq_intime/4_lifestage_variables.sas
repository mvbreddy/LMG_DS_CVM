

data spdtmp7.sd_hc_lifestage1(compress=yes) ;
set spddata.LSTG_SGMNT_AE ;
by LMG_MEM_CARD_NUMBER ;
if last.LMG_MEM_CARD_NUMBER then output  ;
run; 


proc freq data=spdtmp7.sd_hc_lifestage1;
tables Lstage_Sgmnt;
run;






 proc sql; 
create table spdtmp7.sd_hc_txn_ac(compress=y) as
select a.*, b.Lstage_Sgmnt from spdtmp7.sd_hc_txn_ac a left join spdtmp7.sd_hc_lifestage1 b
on a.LMG_mem_card_number=b.LMG_mem_card_number;
quit;



data spdtmp7.sd_hc_txn_ac(compress=y);
set spdtmp7.sd_hc_txn_ac;
if Lstage_Sgmnt ="" or Lstage_Sgmnt ="8. Unclassified"
then Lstage_Sgmnt ="NA";
else Lstage_Sgmnt =Lstage_Sgmnt ;
run;


data spdtmp7.sd_hc_txn_ac_11;
set spdtmp7.sd_hc_txn_ac;
where Lstage_Sgmnt <>"NA";
run;

proc freq data=spdtmp7.sd_hc_txn_ac_11;
table Lstage_Sgmnt;
run;



data spdtmp7.sd_hc_txn_ac(compress= yes);
set spdtmp7.sd_hc_txn_ac;
Rand_no = ranuni(123);

if Lstage_Sgmnt ="NA" and Rand_no <=.2090then Lstage_Sgmnt = "1. Singles";
else if Lstage_Sgmnt ="NA" and Rand_no > 0.2090and Rand_no <= .2878 then Lstage_Sgmnt  = "2. Couples";
else if Lstage_Sgmnt ="NA" and Rand_no > 0.2878 and Rand_no <= .3142 then Lstage_Sgmnt  = "3. Family w. Baby";
else if Lstage_Sgmnt ="NA" and Rand_no > 0.3142 and Rand_no <= .4913then Lstage_Sgmnt  = "4. Family w. Kids";
else if Lstage_Sgmnt ="NA" and Rand_no > 0.4913 and Rand_no <= .5355 then Lstage_Sgmnt  = "5. Family w. Teen";
else if Lstage_Sgmnt ="NA" and Rand_no > 0.5355 and Rand_no <= .7840then Lstage_Sgmnt  = "6. Small Family";
else if Lstage_Sgmnt ="NA" and Rand_no > 0.7840 and Rand_no <= 1 then Lstage_Sgmnt  = "7. Large Family";

else Lstage_Sgmnt =Lstage_Sgmnt ;

run;

proc freq data=spdtmp7.sd_hc_txn_ac;
tables Lstage_Sgmnt;
run;

data spdtmp7.sd_hc_txn_ac (compress= y );
set spdtmp7.sd_hc_txn_ac;


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



proc freq data= spdtmp7.sd_hc_txn_ac;
tables   Lstg_sgmnt_1 Lstg_sgmnt_2 Lstg_sgmnt_3 Lstg_sgmnt_4 Lstg_sgmnt_5 Lstg_sgmnt_6 Lstg_sgmnt_7 ;
run;

proc delete data=spdtmp7.sd_hc_txn_ac1;
run;

proc delete data=spdtmp7.sd_hc_lifestage1;
run;