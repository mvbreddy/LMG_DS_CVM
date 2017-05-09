data spdtmp7.sd_hc_activemay;
set spdtmp7.sd_hc_activemay;
if cvm_nationality_group="" or cvm_nationality_group="Unspecified"
then cvm_nationality_group="missing";
else cvm_nationality_group=cvm_nationality_group;
run;


data spdtmp7.sd_hc_activemay_1;
set spdtmp7.sd_hc_activemay;
where cvm_nationality_group <> "missing";
run;

proc freq data=spdtmp7.sd_hc_activemay_1;
table cvm_nationality_group;
run;

data spdtmp7.sd_hc_activemay(drop=cvm_nationality_group);
set spdtmp7.sd_hc_activemay;
run;


data spdtmp7.sd_hc_activemay(compress= yes);
set spdtmp7.sd_hc_activemay;
Rand_no = ranuni(123);

if cvm_nationality_group="missing" and Rand_no <=0.2133 then lang_name = "Expat Arab";
else if cvm_nationality_group="missing" and Rand_no > 0.2133 and Rand_no <= 0.4393 then cvm_nationality_group = "ISC";
else if cvm_nationality_group="missing" and Rand_no > 0.4393 and Rand_no <= 0.6818 then cvm_nationality_group = "Local";
else if cvm_nationality_group="missing" and Rand_no > 0.6818 and Rand_no <= 1 then cvm_nationality_group = "Others";
else cvm_nationality_group=cvm_nationality_group;

run;




data spdtmp7.sd_hc_activemay;
set spdtmp7.sd_hc_activemay;
           
  
      /*Nationality Dummy*/
  if CVM_Nationality_group = "Local" then Local_nat_dummy = 1; else Local_nat_dummy = 0;
  if CVM_Nationality_group = "Expat Arab" then Expat_Arab_nat_dummy = 1; else Expat_Arab_nat_dummy = 0;
  if CVM_Nationality_group = "ISC" then  ISC_nat_dummy = 1; else ISC_nat_dummy = 0;
    
       
run;

proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_activemay;
quit;
