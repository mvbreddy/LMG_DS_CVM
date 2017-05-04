



data SPDTMP7.VB_CUS_TN_ITM_REV_AE_1 (compress=yes);
set SPDTMP7.VB_CUS_TN_ITM_REV_AE_0 ;
Format age_group $50.0;
Format age_group $50.0;
if age>0 and age <=10 then age_group = "0-10";
else if age>10 and age <=18 then age_group = "11-18";
else if age>19 and age <=25 then age_group = "19-25";
else if age>25 and age<=35 then age_group = "26-35";
else if age>35 and age <=50 then age_group = "36-50";
else if age>50 and age<=75 then age_group = "51-75";
else if age>75 then age_group = ">75";
else age_group = "NA";

run;

/*Imputing age_group*/

data SPDTMP7.VB_CUS_TN_ITM_REV_AE_2 (compress= yes);
set SPDTMP7.VB_CUS_TN_ITM_REV_AE_1;
where age_group<> "NA";
run;

proc freq data= SPDTMP7.VB_CUS_TN_ITM_REV_AE_2;
tables age_group ;
run;


data SPDTMP7.VB_CUS_TN_ITM_REV_AE_2 (compress= yes);
set SPDTMP7.VB_CUS_TN_ITM_REV_AE_1;
Rand_no = ranuni(123);
if age_group = "NA" and Rand_no <=0.0048 then age_group = "0-10";
else if age_group = "NA" and Rand_no > 0.0048 and Rand_no <= 0.0161 then age_group = "11-18";
else if age_group = "NA" and Rand_no > 0.0161 and Rand_no <= 0.1064 then age_group = "19-25";
else if age_group = "NA" and Rand_no > 0.1064 and Rand_no <= 0.5119 then age_group = "26-35";
else if age_group = "NA" and Rand_no > 0.5119 and Rand_no <= 0.9170 then age_group = "36-50";
else if age_group = "NA" and Rand_no > 0.9170 and Rand_no <= 0.9986 then age_group = "51-75";
else if age_group = "NA" and Rand_no > 0.9986 and Rand_no <= 1.00 then age_group = ">75";

run;
