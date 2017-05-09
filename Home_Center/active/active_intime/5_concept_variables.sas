
/*ls*/

data spdtmp7.sd_hc_txn_ls(compress=yes);
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20160301 and txn_dt_wid<=20170228 and Lmg_concept_name="Lifestyle";
run;


data spdtmp7.sd_hc_txn_ls1(compress=yes);
set spdtmp7.sd_hc_txn_ls (keep= lmg_mem_card_number retail_cost_1_AED retail_cost_2_AED  txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued);
where units >0 and revenue_aed >0 and base_points_accrued >0;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;

run;



proc sql;
create table spdtmp7.sd_hc_txn_ls2 (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_ls, 
           count(distinct date) as no_of_visits_ls, 
         count(distinct invoice_number) as no_of_txn_ls, 
           max(date) as end_date_ls, 
           min(date) as start_date_ls,
         count(distinct item_code) as distinct_prod_ls, 
           sum(units) as total_unit_ls, 
           avg(base_points_accrued) as avg_points_ls,
		   sum(retail_cost_1_Aed) as sum_cost_1_ls,
sum(retail_cost_2_Aed) as sum_cost_2_ls
from spdtmp7.sd_hc_txn_ls1

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_ls3(compress=yes);
set spdtmp7.sd_hc_txn_ls2;
format start_date_ls ddmmyys10.;
format end_date_ls ddmmyys10.;
recency_ls=intck('day',end_date_ls,'28Feb2017'd);
active_time_ls=intck('day',start_date_ls,end_date_ls);
avg_units_per_txn_ls = total_unit_ls/no_of_txn_ls;
avg_units_per_visit_ls =  total_unit_ls/no_of_visits_ls;
run;

/*hb*/




data spdtmp7.sd_hc_txn_hb(compress=yes);
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20160301 and txn_dt_wid<=20170228 and Lmg_concept_name="Home Box";
run;

data spdtmp7.sd_hc_txn_hb1(compress=yes);
set spdtmp7.sd_hc_txn_hb (keep= lmg_mem_card_number retail_cost_1_aed retail_cost_2_aed txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued);
where units >0 and revenue_aed >0 and base_points_accrued >0;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;

run;



proc sql;
create table spdtmp7.sd_hc_txn_hb2 (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_hb, 
           count(distinct date) as no_of_visits_hb, 
         count(distinct invoice_number) as no_of_txn_hb, 
           max(date) as end_date_hb, 
           min(date) as start_date_hb,
         count(distinct item_code) as distinct_prod_hb, 
           sum(units) as total_unit_hb, 
		   sum(retail_cost_1_aed) as sum_cost_1_hb,
		   sum(retail_cost_2_aed) as sum_cost_2_hb,
           avg(base_points_accrued) as avg_points_hb 
from spdtmp7.sd_hc_txn_hb1

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_hb3(compress=yes);
set spdtmp7.sd_hc_txn_hb2;
format start_date_hb ddmmyys10.;
format end_date_hb ddmmyys10.;
recency_hb=intck('day',end_date_hb,'28Feb2017'd);
active_time_hb=intck('day',start_date_hb,end_date_hb);
avg_units_per_txn_hb = total_unit_hb/no_of_txn_hb;
avg_units_per_visit_hb =  total_unit_hb/no_of_visits_hb;
run;

/*emax*/

data spdtmp7.sd_hc_txn_em(compress=yes);
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20160301 and txn_dt_wid<=20170228 and Lmg_concept_name="Emax";
run;



data spdtmp7.sd_hc_txn_em1(compress=yes);
set spdtmp7.sd_hc_txn_em (keep= lmg_mem_card_number retail_cost_1_aed retail_cost_2_aed txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued);
where units >0 and revenue_aed >0 and base_points_accrued >0;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;

run;



proc sql;
create table spdtmp7.sd_hc_txn_em2 (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_em, 
           count(distinct date) as no_of_visits_em, 
         count(distinct invoice_number) as no_of_txn_em, 
           max(date) as end_date_em, 
           min(date) as start_date_em,
         count(distinct item_code) as distinct_prod_em, 
           sum(units) as total_unit_em, 
		   sum(retail_cost_1_aed) as sum_cost_1_em,
		   sum(retail_cost_2_aed) as sum_cost_2_em,
           avg(base_points_accrued) as avg_points_em 
from spdtmp7.sd_hc_txn_em1

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_em3(compress=yes);
set spdtmp7.sd_hc_txn_em2;
format start_date_em ddmmyys10.;
format end_date_em ddmmyys10.;
recency_em=intck('day',end_date_em,'28Feb2017'd);
active_time_em=intck('day',start_date_em,end_date_em);
avg_units_per_txn_em = total_unit_em/no_of_txn_em;
avg_units_per_visit_em =  total_unit_em/no_of_visits_em;
run;
/*bs*/

data spdtmp7.sd_hc_txn_bs(compress=yes);
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20160301 and txn_dt_wid<=20170228 and Lmg_concept_name="Babyshop";
run;




data spdtmp7.sd_hc_txn_bs1(compress=yes);
set spdtmp7.sd_hc_txn_bs (keep= lmg_mem_card_number txn_dt_wid retail_cost_1_aed retail_cost_2_Aed revenue_aed invoice_number units item_code base_points_accrued);
where units >0 and revenue_aed >0 and base_points_accrued >0;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;

run;



proc sql;
create table spdtmp7.sd_hc_txn_bs2 (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_bs, 
           count(distinct date) as no_of_visits_bs, 
         count(distinct invoice_number) as no_of_txn_bs, 
           max(date) as end_date_bs, 
           min(date) as start_date_bs,
         count(distinct item_code) as distinct_prod_bs, 
           sum(units) as total_unit_bs, 
		   sum(retail_cost_1_aed) as sum_cost_1_bs,
		   sum(retail_cost_2_aed) as sum_cost_2_bs,
           avg(base_points_accrued) as avg_points_bs 
from spdtmp7.sd_hc_txn_bs1

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_bs3(compress=yes);
set spdtmp7.sd_hc_txn_bs2;
format start_date_bs ddmmyys10.;
format end_date_bs ddmmyys10.;
recency_bs=intck('day',end_date_bs,'28Feb2017'd);
active_time_bs=intck('day',start_date_bs,end_date_bs);
avg_units_per_txn_bs = total_unit_bs/no_of_txn_bs;
avg_units_per_visit_bs =  total_unit_bs/no_of_visits_bs;
run;


/*join all tables*/


proc sql;
create table spdtmp7.sd_hc_txn_final1 (compress=yes) as
select a.*,b.*,c.*,d.*,e.* from spdtmp7.sd_hc_txn_final a left join spdtmp7.sd_hc_txn_ls3 b on a.LMG_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.sd_hc_txn_hb3 c on a.LMG_mem_card_number=c.LMG_mem_card_number left join spdtmp7.sd_hc_txn_em3 d on a.LMG_mem_card_number=d.LMG_mem_card_number
left join spdtmp7.sd_hc_txn_bs3 e
on a.LMG_mem_Card_number=e.LMG_mem_card_number;
quit;

proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_final1;
quit;


proc sql;
create table spdtmp7.sd_hc_txn_final11 (compress=yes) as 
select *, ((sum_revenue_aed_ls)/(sum_revenue_Aed))*100 as perc_revenue_ls,
((sum_revenue_aed_bs)/(sum_revenue_Aed_lmg))*100 as perc_revenue_bs,
((sum_revenue_aed_em)/(sum_revenue_Aed_lmg))*100 as perc_revenue_em,
((sum_revenue_aed_hb)/(sum_revenue_Aed_lmg))*100 as perc_revenue_hb,
((total_unit_ls)/(total_unit_lmg))*100 as perc_unit_ls,
((total_unit_bs)/(total_unit_lmg))*100 as perc_unit_bs,
((total_unit_em)/(total_unit_lmg))*100 as perc_unit_em,
((total_unit_hb)/(total_unit_lmg))*100 as perc_unit_hb

from spdtmp7.sd_hc_txn_final1;
quit;
