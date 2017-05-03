data spdtmp7.sd_hc_txn_grp_apr;
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20160401 and txn_dt_wid<=20170331 and Lmg_concept_name="Home center";
run;

data spdtmp7.sd_hc_txn_grp1_apr;
set spdtmp7.sd_hc_txn_grp_apr;
if lmg_x_dept_cd = 300 or lmg_x_dept_cd=301 or lmg_x_dept_cd=302 or lmg_x_dept_cd=303 or lmg_x_dept_cd=304 or lmg_x_dept_cd=305 or lmg_x_dept_cd=316 or lmg_x_dept_cd=317 then hc_group="Furniture";
else if lmg_x_dept_cd = 306 or lmg_x_dept_cd=307 or lmg_x_dept_cd=308 or lmg_x_dept_cd=309 or lmg_x_dept_cd=310 or lmg_x_dept_cd=311 or lmg_x_dept_cd=312 or lmg_x_dept_cd=313 or lmg_x_dept_cd=314 or lmg_x_dept_cd=315 or lmg_x_dept_cd=318 then hc_group="Household";
else if lmg_x_dept_cd = 319 or lmg_x_dept_cd=320 or lmg_x_dept_cd=321 or lmg_x_dept_cd=322 or lmg_x_dept_cd=323 or lmg_x_dept_cd=324 or lmg_x_dept_cd=325 or lmg_x_dept_cd=326 or lmg_x_dept_cd=327 or lmg_x_dept_cd=328 then hc_group="kids";
else hc_group="NA";
run;

data spdtmp7.sd_hc_txn_grp2_apr;
set spdtmp7.sd_hc_txn_grp1_apr;
where hc_group="Furniture" or hc_group="kids" or hc_group="Household";
run;


proc sql;
create table spdtmp7.sd_hc_txn_grp3_apr as
select LMG_mem_card_number,
sum(case when hc_group="Furniture" then revenue_aed else . end) as revenue_AED_furniture,
sum(case when hc_group="Household" then revenue_aed else . end) as revenue_Aed_Household,
sum(case when hc_group="kids" then revenue_aed else . end) as revenue_Aed_kids,
sum(case when hc_group="Furniture" then units else . end) as total_units_furniture,
sum(case when hc_group="Household" then units else . end) as total_units_household,
sum(case when hc_group="kids" then units else . end) as total_units_kids,
count(distinct (case when hc_group="Furniture"   then invoice_number else '' end)) as no_of_txn_furniture,
count(distinct (case when hc_group="Household"   then invoice_number else '' end)) as no_of_txn_household,
count(distinct (case when hc_group="kids"   then invoice_number else '' end)) as no_of_txn_kids,
count(distinct (case when hc_group="Furniture"   then txn_dt_wid else . end)) as no_of_visits_furniture,
count(distinct (case when hc_group="Household"   then txn_dt_wid else . end)) as no_of_visits_household,
count(distinct (case when hc_group="kids"   then txn_dt_wid else . end)) as no_of_visits_kids
from spdtmp7.sd_hc_txn_grp2_apr group by LMG_mem_card_number;
quit;

data spdtmp7.sd_hc_txn_grp4_apr;
set spdtmp7.sd_hc_txn_grp3;
run;

proc sql;
create table spdtmp7.sd_hc_txn_final3_apr(compress=yes) as
select a.*,b.*,c.* from spdtmp7.sd_hc_txn_final1_apr a left join  spdtmp7.sd_hc_txn_grp3_Apr b on
a.LMG_mem_card_number=b.LMG_mem_card_number  ;
quit; 


proc sql;
create table spdtmp7.sd_hc_txn_grp4_apr(compress=yes) as 
select LMG_mem_card_number,
sum(case when lmg_x_dept_cd = '300' then revenue_aed else . end) as revenue_AED_300,
sum(case when lmg_x_dept_cd = '301' then revenue_aed else . end) as revenue_AED_301,
sum(case when lmg_x_dept_cd = '302' then revenue_aed else . end) as revenue_AED_302,
sum(case when lmg_x_dept_cd = '303' then revenue_aed else . end) as revenue_AED_303,
sum(case when lmg_x_dept_cd = '304' then revenue_aed else . end) as revenue_AED_304,
sum(case when lmg_x_dept_cd = '305' then revenue_aed else . end) as revenue_AED_305,
sum(case when lmg_x_dept_cd = '306' then revenue_aed else . end) as revenue_AED_306,
sum(case when lmg_x_dept_cd = '307' then revenue_aed else . end) as revenue_AED_307,
sum(case when lmg_x_dept_cd = '308' then revenue_aed else . end) as revenue_AED_308,
sum(case when lmg_x_dept_cd = '309' then revenue_aed else . end) as revenue_AED_309,
sum(case when lmg_x_dept_cd = '310' then revenue_aed else . end) as revenue_AED_310,
sum(case when lmg_x_dept_cd = '311' then revenue_aed else . end) as revenue_AED_311,
sum(case when lmg_x_dept_cd = '312' then revenue_aed else . end) as revenue_AED_312,
sum(case when lmg_x_dept_cd = '300' then units else . end) as units_300,
sum(case when lmg_x_dept_cd = '301' then units else . end) as units_301,
sum(case when lmg_x_dept_cd = '302' then units else . end) as units_302,
sum(case when lmg_x_dept_cd = '303' then units else . end) as units_303,
sum(case when lmg_x_dept_cd = '304' then units else . end) as units_304,
sum(case when lmg_x_dept_cd = '305' then units else . end) as units_305,
sum(case when lmg_x_dept_cd = '306' then units else . end) as units_306,
sum(case when lmg_x_dept_cd = '307' then units else . end) as units_307,
sum(case when lmg_x_dept_cd = '308' then units else . end) as units_308,
sum(case when lmg_x_dept_cd = '309' then units else . end) as units_309,
sum(case when lmg_x_dept_cd = '310' then units else . end) as units_310,
sum(case when lmg_x_dept_cd = '311' then units else . end) as units_311,
sum(case when lmg_x_dept_cd = '312' then units else . end) as units_312,
count(distinct (case when lmg_x_dept_cd = '300'   then invoice_number else '' end)) as no_of_txn_300,
count(distinct (case when lmg_x_dept_cd = '301'   then invoice_number else '' end)) as no_of_txn_301,
count(distinct (case when lmg_x_dept_cd = '302'   then invoice_number else '' end)) as no_of_txn_302,
count(distinct (case when lmg_x_dept_cd = '303'   then invoice_number else '' end)) as no_of_txn_303,
count(distinct (case when lmg_x_dept_cd = '304'   then invoice_number else '' end)) as no_of_txn_304,
count(distinct (case when lmg_x_dept_cd = '305'   then invoice_number else '' end)) as no_of_txn_305,
count(distinct (case when lmg_x_dept_cd = '306'   then invoice_number else '' end)) as no_of_txn_306,
count(distinct (case when lmg_x_dept_cd = '307'   then invoice_number else '' end)) as no_of_txn_307,
count(distinct (case when lmg_x_dept_cd = '308'   then invoice_number else '' end)) as no_of_txn_308,
count(distinct (case when lmg_x_dept_cd = '309'   then invoice_number else '' end)) as no_of_txn_309,
count(distinct (case when lmg_x_dept_cd = '310'   then invoice_number else '' end)) as no_of_txn_310,
count(distinct (case when lmg_x_dept_cd = '311'   then invoice_number else '' end)) as no_of_txn_311,
count(distinct (case when lmg_x_dept_cd = '312'   then invoice_number else '' end)) as no_of_txn_312
from spdtmp7.sd_hc_txn_grp2_apr group by LMG_mem_card_number;
quit;


proc sql;
create table spdtmp7.sd_hc_txn_final6_apr(compress=yes) as
select a.*,b.* from spdtmp7.sd_hc_txn_final6_apr a left join  spdtmp7.sd_hc_txn_grp4_Apr b on
a.LMG_mem_card_number=b.LMG_mem_card_number  ;
quit; 
