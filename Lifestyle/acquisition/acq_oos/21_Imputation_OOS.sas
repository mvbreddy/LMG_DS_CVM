
/*Missing Value imputation*/

data spdtmp7.VB_AQ_OOS_LS_Alldata2(compress=yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata1 ;
Format age_group $50.0;
Format age_group $50.0;
if age>0 and age <=10 then age_group = "ag1";
else if age>10 and age <=18 then age_group = "ag2";
else if age>19 and age <=25 then age_group = "ag3";
else if age>25 and age<=35 then age_group = "ag4";
else if age>35 and age <=50 then age_group = "ag5";
else if age>50 and age<=75 then age_group = "ag6";
else if age>75 then age_group = "ag7";
else age_group = "NA";
run;

data spdtmp7.VB_AQ_OOS_LS_Alldata_11 (compress= yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata2;
where age_group<> "NA";
run;


proc freq data=spdtmp7.VB_AQ_OOS_LS_Alldata_11;
table age_group;
run;

proc delete data=spdtmp7.VB_AQ_OOS_LS_Alldata_11;run;



data spdtmp7.VB_AQ_OOS_LS_Alldata3 (compress= yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata2;
Rand_no = ranuni(123);

if age_group = "NA" and Rand_no <=0.0065 then age_group = "ag1";
else if age_group = "NA" and Rand_no > 0.0065 and Rand_no <= 0.0161 then age_group = "ag2";
else if age_group = "NA" and Rand_no > 0.0161 and Rand_no <= 0.0961 then age_group = "ag3";
else if age_group = "NA" and Rand_no > 0.0961 and Rand_no <= 0.5651 then age_group = "ag4";
else if age_group = "NA" and Rand_no > 0.5651 and Rand_no <= 0.9262 then age_group = "ag5";
else if age_group = "NA" and Rand_no > 0.9262 and Rand_no <= 0.9987 then age_group = "ag6";
else if age_group = "NA" and Rand_no > 0.9987 and Rand_no <= 1.00 then age_group = "ag7";

run;

/*proc freq data=spdtmp7.VB_AQ_OOS_LS_TXN_Overall;*/
/*table age_group;*/
/*run;*/


data spdtmp7.VB_AQ_OOS_LS_Alldata4(compress=yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata3;
if sex_mf_name="" or sex_mf_name="Unspecified"
then sex_mf_name="NA";
run;


data spdtmp7.VB_AQ_OOS_LS_TXN_Overall_11(compress= yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata4;
where sex_mf_name<>"NA";
run;


proc freq data= spdtmp7.VB_AQ_OOS_LS_TXN_Overall_11;
tables sex_mf_name;
run;

proc delete data = spdtmp7.VB_AQ_OOS_LS_TXN_Overall_11;
run;


data spdtmp7.VB_AQ_OOS_LS_Alldata5 (compress= yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata4;
Rand_no = ranuni(123);
if sex_mf_name = "NA" and Rand_no <=0.3246 then sex_mf_name = "F";
else if sex_mf_name = "NA" and Rand_no > 0.3246 and Rand_no <= 1 then sex_mf_name = "M";

run;

/*proc sql;*/
/*create table abc as*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_AQ_OOS_LS_TXN_Overall;*/
/*quit;*/

data spdtmp7.VB_AQ_OOS_LS_Alldata6(compress= yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata5;
if cvm_nationality_group="" or cvm_nationality_group="Unspecified"
then cvm_nationality_group="NA";
run;


data spdtmp7.VB_AQ_OOS_LS_TXN_Overall_11(compress=yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata6;
where cvm_nationality_group <> "NA";
run;

proc freq data=spdtmp7.VB_AQ_OOS_LS_TXN_Overall_11;
table cvm_nationality_group;
run;

proc delete data= spdtmp7.VB_AQ_OOS_LS_TXN_Overall_11;
run;


data spdtmp7.VB_AQ_OOS_LS_Alldata7(compress= yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata6;
Rand_no = ranuni(123);

if cvm_nationality_group="NA" and Rand_no <=0.1795 then  cvm_nationality_group= "Expat Arab";
else if cvm_nationality_group="NA" and Rand_no > 0.1795 and Rand_no <= .5260 then cvm_nationality_group = "ISC";
else if cvm_nationality_group="NA" and Rand_no > 0.5260 and Rand_no <= .6079 then cvm_nationality_group = "Local";
else if cvm_nationality_group="NA" and Rand_no > 0.6079 and Rand_no <= 1 then cvm_nationality_group = "Others";

run;


data spdtmp7.VB_AQ_OOS_LS_Alldata8(compress= yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata7;
if lang_name ="" or lang_name="Unspecified"
then lang_name="NA";
run;

data spdtmp7.VB_AQ_OOS_LS_TXN_Overall_11(compress=yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata8;
where lang_name <> "NA";
run;

proc freq data=spdtmp7.VB_AQ_OOS_LS_TXN_Overall_11;
table lang_name;
run;

proc delete data= spdtmp7.VB_AQ_OOS_LS_TXN_Overall_11;
run;


data spdtmp7.VB_AQ_OOS_LS_Alldata9(compress=yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata8;
Rand_no = ranuni(123);
if lang_name = "NA" and Rand_no <=0.1445 then lang_name = "Arabic";
else if lang_name = "NA" and Rand_no > 0.1445 and Rand_no <= 1 then lang_name = "English";

run;


/*Adding Lifestage variables*/


proc sql;
create table spdtmp7.VB_AQ_OOS_LS_Alldata10 (compress = yes) as
select * from spdtmp7.VB_AQ_OOS_LS_Alldata9 as a 
left join SPDTMP7.VB_LSTG_SGMT_AE as c
on a.LMG_MEM_CARD_NUMBER = c.LMG_MEM_CARD_NUMBER;
quit;


data spdtmp7.VB_AQ_OOS_LS_Alldata10(compress= yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata10;
if lstage_sgmnt ="" or lstage_sgmnt= "8. Unclassified"
then lstage_sgmnt="NA";
run;

data spdtmp7.VB_AQ_OOS_LS_TXN_Overall_11(compress=yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata10;
where lstage_sgmnt <> "NA"  ;
run;

proc freq data= spdtmp7.VB_AQ_OOS_LS_TXN_Overall_11;
tables lstage_sgmnt;
run;

proc delete data= spdtmp7.VB_AQ_OOS_LS_TXN_Overall_11;run;


data spdtmp7.VB_AQ_OOS_LS_Alldata11(compress=yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata10;
Rand_no = ranuni(123);
if lstage_sgmnt = "NA" and Rand_no <=0.2127 then lstage_sgmnt = "1. Singles";
else if lstage_sgmnt = "NA" and Rand_no > 0.2127 and Rand_no <= 0.3001 then lstage_sgmnt = "2. Couples";
else if lstage_sgmnt = "NA" and Rand_no > 0.3001 and Rand_no <= 0.3308 then lstage_sgmnt = "3. Family w. Baby";
else if lstage_sgmnt = "NA" and Rand_no > 0.3308 and Rand_no <= 0.5210 then lstage_sgmnt = "4. Family w. Kids";
else if lstage_sgmnt = "NA" and Rand_no > 0.5210 and Rand_no <= 0.5547 then lstage_sgmnt = "5. Family w. Teen";
else if lstage_sgmnt = "NA" and Rand_no > 0.5547 and Rand_no <= 0.8061 then lstage_sgmnt = "6. Small Family";
else if lstage_sgmnt = "NA" and Rand_no > 0.8061 and Rand_no <= 1 then lstage_sgmnt = "7. Large Family";

run;


data spdtmp7.VB_AQ_OOS_LS_Alldata12(compress=yes);
set spdtmp7.VB_AQ_OOS_LS_Alldata11;
           /* Age Dummy */
  if age_group = "ag1" then age_grp_1_dummy = 1; else age_grp_1_dummy = 0;
  if age_group = "ag2" then age_grp_2_dummy = 1; else age_grp_2_dummy = 0;
  if age_group = "ag3" then age_grp_3_dummy = 1; else age_grp_3_dummy = 0;
  if age_group = "ag4" then age_grp_4_dummy = 1; else age_grp_4_dummy = 0;
  if age_group = "ag5" then age_grp_5_dummy = 1; else age_grp_5_dummy = 0;
  if age_group = "ag6" then age_grp_6_dummy= 1; else age_grp_6_dummy = 0;

                 /*Nationality Dummy*/
  if CVM_Nationality_group = "Local" then Local_nat_dummy = 1; else Local_nat_dummy = 0;
  if CVM_Nationality_group = "Expat Arab" then Expat_Arab_nat_dummy = 1; else Expat_Arab_nat_dummy = 0;
  if CVM_Nationality_group = "ISC" then  ISC_nat_dummy = 1; else ISC_nat_dummy = 0;
    
                 /*Gender Dummy */
  if SEX_MF_NAME = "M" then Gender_M_dummy = 1; else Gender_M_dummy = 0;

  				/*language dummy */
  if lang_name = "Arabic" then lang_Arabic_dummy = 1; else lang_Arabic_dummy = 0;

       /* Lsegmnt dummy */
  Lstg_sgmnt_1 = (Lstage_Sgmnt = "1. Singles");
  Lstg_sgmnt_2 = (Lstage_Sgmnt = "2. Couples");
  Lstg_sgmnt_3 = (Lstage_Sgmnt = "3. Family w. Baby");
  Lstg_sgmnt_4 = (Lstage_Sgmnt = "4. Family w. Kids");
  Lstg_sgmnt_5 = (Lstage_Sgmnt = "5. Family w. Teen");
  Lstg_sgmnt_6 = (Lstage_Sgmnt = "6. Small Family");
 
       
run;
