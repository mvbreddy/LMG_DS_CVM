/*ls*/

data spdtmp7.sd_hc_txn_ls_oos(compress=yes);
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20150301 and txn_dt_wid<=20160229 and Lmg_concept_name="Lifestyle";
run;


data spdtmp7.sd_hc_txn_ls1_oos(compress=yes);
set spdtmp7.sd_hc_txn_ls_oos (keep= lmg_mem_card_number txn_dt_wid retail_cost_1_aed retail_cost_2_aed revenue_aed invoice_number units item_code base_points_accrued);
where units >0 and revenue_aed >0 and base_points_accrued >0;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;

run;



proc sql;
create table spdtmp7.sd_hc_txn_ls2_oos (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_ls, 
           count(distinct date) as no_of_visits_ls, 
         count(distinct invoice_number) as no_of_txn_ls, 
           max(date) as end_date_ls, 
           min(date) as start_date_ls,
         count(distinct item_code) as distinct_prod_ls, 
           sum(units) as total_unit_ls, 
		   sum(retail_cost_1_aed) as sum_cost_1_ls,
		   sum(retail_cost_2_Aed) as sum_cost_2_ls,
           avg(base_points_accrued) as avg_points_ls 
from spdtmp7.sd_hc_txn_ls1_oos

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_ls3_oos(compress=yes);
set spdtmp7.sd_hc_txn_ls2_oos;
format start_date_ls ddmmyys10.;
format end_date_ls ddmmyys10.;
recency_ls=intck('day',end_date_ls,'29Feb2016'd);
active_time_ls=intck('day',start_date_ls,end_date_ls);
avg_units_per_txn_ls = total_unit_ls/no_of_txn_ls;
avg_units_per_visit_ls =  total_unit_ls/no_of_visits_ls;
run;

/*hb*/




data spdtmp7.sd_hc_txn_hb_oos(compress=yes);
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20150301 and txn_dt_wid<=20160229 and Lmg_concept_name="Home Box";
run;

data spdtmp7.sd_hc_txn_hb1_oos(compress=yes);
set spdtmp7.sd_hc_txn_hb_oos (keep= lmg_mem_card_number retail_cost_1_Aed retail_Cost_2_aed txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued);
where units >0 and revenue_aed >0 and base_points_accrued >0;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;

run;



proc sql;
create table spdtmp7.sd_hc_txn_hb2_oos (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_hb, 
           count(distinct date) as no_of_visits_hb, 
         count(distinct invoice_number) as no_of_txn_hb, 
           max(date) as end_date_hb, 
           min(date) as start_date_hb,
         count(distinct item_code) as distinct_prod_hb, 
           sum(units) as total_unit_hb, 
		   sum(retail_cost_1_aed) as sum_cost_1_hb,
		   sum(retail_cost_2_Aed) as sum_cost_2_hb,
           avg(base_points_accrued) as avg_points_hb 
from spdtmp7.sd_hc_txn_hb1_oos

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_hb3_oos(compress=yes);
set spdtmp7.sd_hc_txn_hb2_oos;
format start_date_hb ddmmyys10.;
format end_date_hb ddmmyys10.;
recency_hb=intck('day',end_date_hb,'29Feb2016'd);
active_time_hb=intck('day',start_date_hb,end_date_hb);
avg_units_per_txn_hb = total_unit_hb/no_of_txn_hb;
avg_units_per_visit_hb =  total_unit_hb/no_of_visits_hb;
run;

/*emax*/

data spdtmp7.sd_hc_txn_em_oos(compress=yes);
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20150301 and txn_dt_wid<=20160229 and Lmg_concept_name="Emax";
run;



data spdtmp7.sd_hc_txn_em1_oos(compress=yes);
set spdtmp7.sd_hc_txn_em_oos (keep= lmg_mem_card_number retail_Cost_1_Aed retail_Cost_2_aed txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued);
where units >0 and revenue_aed >0 and base_points_accrued >0;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;

run;



proc sql;
create table spdtmp7.sd_hc_txn_em2_oos (compress=yes) as
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
from spdtmp7.sd_hc_txn_em1_oos

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_em3_oos(compress=yes);
set spdtmp7.sd_hc_txn_em2_oos;
format start_date_em ddmmyys10.;
format end_date_em ddmmyys10.;
recency_em=intck('day',end_date_em,'29Feb2016'd);
active_time_em=intck('day',start_date_em,end_date_em);
avg_units_per_txn_em = total_unit_em/no_of_txn_em;
avg_units_per_visit_em =  total_unit_em/no_of_visits_em;
run;
/*bs*/

data spdtmp7.sd_hc_txn_bs_oos(compress=yes);
set sascrm.tn_itm_rev_ae ;
where txn_dt_wid>=20150301 and txn_dt_wid<=20160229 and Lmg_concept_name="Babyshop";
run;




data spdtmp7.sd_hc_txn_bs1_oos(compress=yes);
set spdtmp7.sd_hc_txn_bs_oos (keep= lmg_mem_card_number retail_cost_1_aed retail_cost_2_aed txn_dt_wid revenue_aed invoice_number units item_code base_points_accrued);
where units >0 and revenue_aed >0 and base_points_accrued >0;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;

run;



proc sql;
create table spdtmp7.sd_hc_txn_bs2_oos (compress=yes) as
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
from spdtmp7.sd_hc_txn_bs1_oos

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_bs3_oos(compress=yes);
set spdtmp7.sd_hc_txn_bs2_oos;
format start_date_bs ddmmyys10.;
format end_date_bs ddmmyys10.;
recency_bs=intck('day',end_date_bs,'29Feb2016'd);
active_time_bs=intck('day',start_date_bs,end_date_bs);
avg_units_per_txn_bs = total_unit_bs/no_of_txn_bs;
avg_units_per_visit_bs =  total_unit_bs/no_of_visits_bs;
run;


/*join all tables*/


proc sql;
create table spdtmp7.sd_hc_txn_final1_oos(compress=yes) as
select a.*,b.*,c.*,d.*,e.* from spdtmp7.sd_hc_txn_final_oos a left join spdtmp7.sd_hc_txn_ls3_oos b on a.LMG_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.sd_hc_txn_hb3_oos c on a.LMG_mem_card_number=c.LMG_mem_card_number left join spdtmp7.sd_hc_txn_em3_oos d on a.LMG_mem_card_number=d.LMG_mem_card_number
left join spdtmp7.sd_hc_txn_bs3_oos e
on a.LMG_mem_Card_number=e.LMG_mem_card_number;
quit;

proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_final1;
quit;



proc sql;
create table spdtmp7.sd_hc_txn_final11_oos (compress=yes) as 
select *, ((sum_revenue_aed_ls)/(sum_revenue_Aed))*100 as perc_revenue_ls,
((sum_revenue_aed_bs)/(sum_revenue_Aed_lmg))*100 as perc_revenue_bs,
((sum_revenue_aed_em)/(sum_revenue_Aed_lmg))*100 as perc_revenue_em,
((sum_revenue_aed_hb)/(sum_revenue_Aed_lmg))*100 as perc_revenue_hb,
((total_unit_ls)/(total_unit_lmg))*100 as perc_unit_ls,
((total_unit_bs)/(total_unit_lmg))*100 as perc_unit_bs,
((total_unit_em)/(total_unit_lmg))*100 as perc_unit_em,
((total_unit_hb)/(total_unit_lmg))*100 as perc_unit_hb
from spdtmp7.sd_hc_txn_final1_oos;
quit;

proc means data=spdtmp7.sd_hc_txn_final11_oos;
run;
