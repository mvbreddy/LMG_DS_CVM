
data spdtmp7.sd_hc_txn_wbmay1(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbmay_all;
where txn_dt_wid >=20150501 and txn_dt_wid<=20160430 and LMG_concept_name="Babyshop" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbmay1 as
select a.*,b.grp_nm from spdtmp7.sd_hc_txn_wbmay1 a inner join saser.dim_itm_bs b on a.item_code=b.itm_cd;
quit; 


proc freq data=spdtmp7.sd_hc_txn_wbmay1;
tables grp_nm;
run;


proc sql;
create table spdtmp7.sd_hc_txn_wbmay2(compress=yes) as
select LMG_mem_card_number,

sum(case when grp_nm="Basics Apparels" then revenue_aed else . end) as revenue_AED_ba,
sum(case when grp_nm="Basics Non Apparels" then revenue_aed else . end) as revenue_Aed_bna,
sum(case when grp_nm="Clothing Boys" then revenue_aed else . end) as revenue_Aed_cb,
sum(case when grp_nm="Clothing Girls" then revenue_aed else . end) as revenue_Aed_cg,
sum(case when grp_nm="Clothing Essentials" then revenue_aed else . end) as revenue_Aed_ce,

sum(case when grp_nm in ("BS-Non Trading","Charity","Nursery","Toys Accessories","Toys Back to School","Toys Boys & Girls","Toys Educational") then revenue_aed else . end) as revenue_Aed_others,

sum(case when grp_nm="Basics Apparels" then units else . end) as total_units_ba,
sum(case when grp_nm="Basics Non Apparels" then units else . end) as total_units_bna,
sum(case when grp_nm="Clothing Boys" then units else . end) as total_units_cb,
sum(case when grp_nm="Clothing Girls" then units else . end) as total_units_cg,
sum(case when grp_nm="Clothing Essentials" then units else . end) as total_units_ce,

sum(case when grp_nm in ("BS-Non Trading","Charity","Nursery","Toys Accessories","Toys Back to School","Toys Boys & Girls","Toys Educational") then units else . end) as total_units_others,



count(distinct (case when grp_nm="Basics Apparels"   then invoice_number else '' end)) as no_of_txn_ba,
count(distinct (case when grp_nm="Basics Non Apparels"   then invoice_number else '' end)) as no_of_txn_bna,
count(distinct (case when grp_nm="Clothing Boys"   then invoice_number else '' end)) as no_of_txn_cb,
count(distinct (case when grp_nm="Clothing Girls"   then invoice_number else '' end)) as no_of_txn_cg,

count(distinct (case when grp_nm="Clothing Essentials"   then invoice_number else '' end)) as no_of_txn_ce,
count(distinct (case when grp_nm in ("BS-Non Trading","Charity","Nursery","Toys Accessories","Toys Back to School","Toys Boys & Girls","Toys Educational")   then invoice_number else '' end)) as no_of_txn_others,



count(distinct (case when grp_nm="Basics Apparels"   then txn_dt_wid else . end)) as no_of_visits_ba,
count(distinct (case when grp_nm="Basics Non Apparels"   then txn_dt_wid else . end)) as no_of_visits_bna,
count(distinct (case when grp_nm="Clothing Boys"   then txn_dt_wid else . end)) as no_of_visits_cb,
count(distinct (case when grp_nm="Clothing Girls"   then txn_dt_wid else . end)) as no_of_visits_cg,

count(distinct (case when grp_nm="Clothing Essentials"   then txn_dt_wid else . end)) as no_of_visits_ce,
count(distinct (case when grp_nm in ("BS-Non Trading","Charity","Nursery","Toys Accessories","Toys Back to School","Toys Boys & Girls","Toys Educational")   then txn_dt_wid else . end)) as no_of_visits_others

from spdtmp7.sd_hc_txn_wbmay1 group by LMG_mem_card_number;
quit;



proc sql;
create table spdtmp7.sd_hc_txn_wbmay(compress=yes) as
select a.*,b.* from spdtmp7.sd_hc_txn_wbmay a left join  spdtmp7.sd_hc_txn_wbmay2 b on a.LMG_mem_card_number=b.LMG_mem_card_number
;
quit; 