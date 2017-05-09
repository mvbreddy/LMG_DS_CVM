



data x;

set saser.dim_itm_bs;
run;


data spdtmp7.sd_hc_txn_wboos1(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wboos_all;
where txn_dt_wid >=20140301 and txn_dt_wid<=20150228 and LMG_concept_name="Lifestyle" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

data spdtmp7.sd_hc_txn_wboos1(compress=yes);

set spdtmp7.sd_hc_txn_wboos1;
where units >0 and revenue_aed >0;
if LMG_X_DEPT_CD in ('400','402','403','401') then dept = 'Beauty';
if LMG_X_DEPT_CD = '405' then dept = 'TG';
if LMG_X_DEPT_CD in ('410','418','404','419','406') then dept = 'Fshn';
if LMG_X_DEPT_CD in ('415','407','413','417','411','412','409','416') then dept = 'HF';
if LMG_X_DEPT_CD =  '408' then dept = 'HFrag';
run;


proc freq data=spdtmp7.sd_hc_txn_wboos1;
tables lmg_x_dept_cd;
run;

data spdtmp7.sd_hc_txn_wboos1(compress=yes);
set spdtmp7.sd_hc_txn_wboos1;
where dept="Beauty" or dept="TG" or dept="Fshn" or dept="HF" or "HFrag";
run;


proc sql;
create table spdtmp7.sd_hc_txn_wboos2(compress=yes) as
select LMG_mem_card_number,

sum(case when dept="Beauty" then revenue_aed else . end) as revenue_AED_Beauty,
sum(case when dept="TG" then revenue_aed else . end) as revenue_Aed_TG,
sum(case when dept="Fshn" then revenue_aed else . end) as revenue_Aed_Fas,
sum(case when dept="HF" then revenue_aed else . end) as revenue_Aed_HF,
sum(case when dept="HFrag" then revenue_aed else . end) as revenue_Aed_HFrag,


sum(case when dept="Beauty" then units else . end) as total_units_Beauty,
sum(case when dept="TG" then units else . end) as total_units_TG,
sum(case when dept="Fshn" then units else . end) as total_units_Fas,
sum(case when dept="HF" then units else . end) as total_units_HF,
sum(case when dept="HFrag" then units else . end) as total_units_HFrag,

count(distinct (case when dept="Beauty"   then invoice_number else '' end)) as no_of_txn_Beauty,
count(distinct (case when dept="TG"   then invoice_number else '' end)) as no_of_txn_TG,
count(distinct (case when dept="Fshn"   then invoice_number else '' end)) as no_of_txn_Fas,
count(distinct (case when dept="HF"   then invoice_number else '' end)) as no_of_txn_HF,
count(distinct (case when dept="HFrag"   then invoice_number else '' end)) as no_of_txn_HFrag,


count(distinct (case when dept="Beauty"   then txn_dt_wid else . end)) as no_of_visits_Beauty,
count(distinct (case when dept="TG"   then txn_dt_wid else . end)) as no_of_visits_TG,
count(distinct (case when dept="Fshn"   then txn_dt_wid else . end)) as no_of_visits_Fas,
count(distinct (case when dept="HF"   then txn_dt_wid else . end)) as no_of_visits_HF,
count(distinct (case when dept="HFrag"   then txn_dt_wid else . end)) as no_of_visits_HFrag

from spdtmp7.sd_hc_txn_wboos1 group by LMG_mem_card_number;
quit;

proc sql;
create table spdtmp7.sd_hc_txn_wboos(compress=yes) as
select a.*,b.* from spdtmp7.sd_hc_txn_wboos a left join  spdtmp7.sd_hc_txn_wboos2 b on a.LMG_mem_card_number=b.LMG_mem_card_number
;
quit; 