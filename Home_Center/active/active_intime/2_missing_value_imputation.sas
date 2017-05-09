/*Missing Value imputation*/



data spdtmp3.sd_hc_txn_cust_1 (compress=yes);
set spdtmp7.sd_hc_txn_cust  ;
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




data spdtmp3.sd_hc_txn_cust_11 (compress= yes);
set spdtmp3.sd_hc_txn_cust_1;
where age_group<> "NA";
run;

proc freq data=spdtmp3.sd_hc_txn_cust_11;
table age_group;
run;


data spdtmp3.sd_hc_txn_cust_12 (compress= yes);
set spdtmp3.sd_hc_txn_cust_1;
Rand_no = ranuni(123);

if age_group = "NA" and Rand_no <=0.0043 then age_group = "ag1";
else if age_group = "NA" and Rand_no > 0.0043 and Rand_no <= 0.0109 then age_group = "ag2";
else if age_group = "NA" and Rand_no > 0.0109 and Rand_no <= 0.0690 then age_group = "ag3";
else if age_group = "NA" and Rand_no > 0.0690 and Rand_no <= 0.4469 then age_group = "ag4";
else if age_group = "NA" and Rand_no > 0.4469 and Rand_no <= 0.8946 then age_group = "ag5";
else if age_group = "NA" and Rand_no > 0.8946 and Rand_no <= 0.9985 then age_group = "ag6";
else if age_group = "NA" and Rand_no > 0.9985 and Rand_no <= 1.00 then age_group = "ag7";
else age_group=age_group;

run;
proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp3.sd_hc_txn_cust_12;
quit;



proc freq data=spdtmp3.sd_hc_txn_cust_12;
table age_group;
run;


data spdtmp3.sd_hc_txn_cust_13;
set spdtmp3.sd_hc_txn_cust_12;
if sex_mf_name="" or sex_mf_name="Unspecified"
then sex_mf_name="NA";
else sex_mf_name=sex_mf_name;
run;


data spdtmp3.sd_hc_txn_cust_14;
set spdtmp3.sd_hc_txn_cust_13;
where sex_mf_name<>"NA";
run;


proc freq data=spdtmp3.sd_hc_txn_cust_14;
tables sex_mf_name;
run;


data spdtmp3.sd_hc_txn_cust_15 (compress= yes);
set spdtmp3.sd_hc_txn_cust_13;
Rand_no = ranuni(123);
if sex_mf_name = "NA" and Rand_no <=0.5112 then sex_mf_name = "F";
else if sex_mf_name = "NA" and Rand_no > 0.5112 and Rand_no <= 1 then sex_mf_name = "M";
else sex_mf_name=sex_mf_name;
run;

proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp3.sd_hc_txn_cust_15;
quit;

proc freq data=spdtmp3.sd_hc_txn_cust_15;
table sex_mf_name;
run;

data spdtmp3.sd_hc_txn_cust_16;
set spdtmp3.sd_hc_txn_cust_15;
if lang_name="" or lang_name="Unspecified"
then lang_name="NA";
else lang_name=lang_name;
run;

data spdtmp3.sd_hc_txn_cust_17;
set spdtmp3.sd_hc_txn_cust_16;
where lang_name<>"NA";
run;

proc freq data=spdtmp3.sd_hc_txn_cust_17;
table lang_name;
run;


data spdtmp3.sd_hc_txn_cust_18 (compress= yes);
set spdtmp3.sd_hc_txn_cust_16;
Rand_no = ranuni(123);

if lang_name="NA" and Rand_no <=0.2429 then lang_name = "Arabic";
else if lang_name="NA" and Rand_no > 0.2429 and Rand_no <= 1 then lang_name = "English";
else lang_name=lang_name;

run;


proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp3.sd_hc_txn_cust_18;
quit;

proc freq data=spdtmp3.sd_hc_txn_cust_18;
table lang_name;
run;

proc freq data=spdtmp3.sd_hc_txn_cust_1;
table cvm_nationality_group;
run;

data spdtmp3.sd_hc_txn_cust_19;
set spdtmp3.sd_hc_txn_cust_18;
if cvm_nationality_group="" or cvm_nationality_group="Unspecified"
then cvm_nationality_group="NA";
else cvm_nationality_group=cvm_nationality_group;
run;


data spdtmp3.sd_hc_txn_cust_20;
set spdtmp3.sd_hc_txn_cust_19;
where cvm_nationality_group<>"NA";
run;

proc freq data=spdtmp3.sd_hc_txn_cust_20;
table cvm_nationality_group;
run;



data spdtmp3.sd_hc_txn_cust_21 (compress= yes);
set spdtmp3.sd_hc_txn_cust_19;
Rand_no = ranuni(123);

if cvm_nationality_group="NA" and Rand_no <=0.2148 then cvm_nationality_group = "Expat Arab";
else if cvm_nationality_group="NA" and Rand_no > 0.2148 and Rand_no <= .4344 then cvm_nationality_group = "ISC";
else if cvm_nationality_group="NA" and Rand_no > 0.4344 and Rand_no <= .6701 then cvm_nationality_group = "Local";
else if cvm_nationality_group="NA" and Rand_no > 0.6701 and Rand_no <= 1 then cvm_nationality_group = "Others";
else cvm_nationality_group=cvm_nationality_group;

run;

proc freq data=spdtmp3.sd_hc_txn_cust_21;
table cvm_nationality_group;
run;
proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp3.sd_hc_txn_cust_21;
quit;

data spdtmp7.sd_hc_txn_cust_22;
set spdtmp3.sd_hc_txn_cust_21;
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

  /*Lang_name_dummy*/
  if lang_name = "English" then lang_name_dummy = 1; else lang_name_dummy = 0;
       
run;

proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_cust_22;
quit;