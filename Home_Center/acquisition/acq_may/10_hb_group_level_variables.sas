
data spdtmp7.sd_hc_txn_acmay1(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_acmay_all;
where txn_dt_wid >=20160501 and txn_dt_wid<=20170430 and LMG_concept_name="Home Box" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_acmay1 as
select a.*,b.grp_nm from spdtmp7.sd_hc_txn_acmay1 a inner join saser.dim_itm_hb b on a.item_code=b.itm_cd;
run; 


proc freq data=spdtmp7.sd_hc_txn_acmay1;
tables grp_nm;
run;


proc sql;
create table spdtmp7.sd_hc_txn_acmay2(compress=yes) as
select LMG_mem_card_number,

sum(case when grp_nm="Furniture" then revenue_aed else . end) as revenue_AED_furhb,
sum(case when grp_nm="Homeware" then revenue_aed else . end) as revenue_Aed_hwhb,
sum(case when grp_nm="Kids" then revenue_aed else . end) as revenue_Aed_kidshb,
sum(case when grp_nm="MH - Non Trading" then revenue_aed else . end) as revenue_Aed_mhnthb,

sum(case when grp_nm="Furniture" then units else . end) as total_units_furhb,
sum(case when grp_nm="Homeware" then units else . end) as total_units_hwhb,
sum(case when grp_nm="Kids" then units else . end) as total_units_kidshb,
sum(case when grp_nm="MH - Non Trading" then units else . end) as total_units_mhnthb,


count(distinct (case when grp_nm="Furniture"   then invoice_number else '' end)) as no_of_txn_furhb,
count(distinct (case when grp_nm="Homeware"   then invoice_number else '' end)) as no_of_txn_hwhb,
count(distinct (case when grp_nm="Kids"   then invoice_number else '' end)) as no_of_txn_kidshb,
count(distinct (case when grp_nm="MH - Non Trading"   then invoice_number else '' end)) as no_of_txn_mhnthb,



count(distinct (case when grp_nm="Furniture"   then txn_dt_wid else . end)) as no_of_visits_furhb,
count(distinct (case when grp_nm="Homeware"   then txn_dt_wid else . end)) as no_of_visits_hwhb,
count(distinct (case when grp_nm="Kids"   then txn_dt_wid else . end)) as no_of_visits_kidshb,
count(distinct (case when grp_nm="MH - Non Trading"   then txn_dt_wid else . end)) as no_of_visits_mhnthb

from spdtmp7.sd_hc_txn_acmay1 group by LMG_mem_card_number;
quit;



proc sql;
create table spdtmp7.sd_hc_txn_acmay(compress=yes) as
select a.*,b.* from spdtmp7.sd_hc_txn_acmay a left join  spdtmp7.sd_hc_txn_acmay2 b on a.LMG_mem_card_number=b.LMG_mem_card_number
;
quit; 

data spdtmp7.sd_hc_txn_acmay(compress=yes drop=revenue_AED_furhb 
revenue_Aed_hwhb 
revenue_Aed_kidshb 
revenue_Aed_mhnthb 
total_units_furhb 
total_units_hwhb 
total_units_kidshb 
total_units_mhnthb 
no_of_txn_furhb 
no_of_txn_hwhb 
no_of_txn_kidshb 
no_of_txn_mhnthb 
no_of_visits_furhb 
no_of_visits_hwhb 
no_of_visits_kidshb 
no_of_visits_mhnthb 
);
set spdtmp7.sd_hc_txn_acmay;
run;



proc means data=spdtmp7.sd_hc_txn_acmay;
run;