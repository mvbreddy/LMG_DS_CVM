
/*data spdtmp7.sd_hc_txn_ac(compress=yes drop= recency_ls recency_hb recency_bs recency_em);*/
/*set spdtmp7.sd_hc_txn_ac;*/
/*run;*/


/*ls*/


data spdtmp7.sd_hc_txn_acls(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_ac_all;
where txn_Dt_wid>=20160301 and txn_dt_wid<=20170228 and lmg_concept_name="Lifestyle"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_acls (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_ls, 
           count(distinct date) as no_of_visits_ls, 
         count(distinct invoice_number) as no_of_txn_ls, 
           max(date) as end_date_ls, 
           min(date) as start_date_ls,
         count(distinct item_code) as distinct_prod_ls, 
           sum(units) as total_unit_ls, 
           sum(base_points_accrued) as total_points_ls,
		   sum(retail_cost_1_Aed) as sum_cost_1_ls,
sum(retail_cost_2_Aed) as sum_cost_2_ls
from spdtmp7.sd_hc_txn_acls

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_acls(compress=yes);
set spdtmp7.sd_hc_txn_acls;
format start_date_ls ddmmyys10.;
format end_date_ls ddmmyys10.;
recency_ls=intck('day',end_date_ls,'28Feb2017'd);
active_time_ls=intck('day',start_date_ls,end_date_ls);
avg_units_per_txn_ls = total_unit_ls/no_of_txn_ls;
avg_units_per_visit_ls =  total_unit_ls/no_of_visits_ls;
run;

/*hb*/





data spdtmp7.sd_hc_txn_achb(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_ac_all;
where txn_Dt_wid>=20160301 and txn_dt_wid<=20170228 and lmg_concept_name="Home Box"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_achb (compress=yes) as
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
           sum(base_points_accrued) as total_points_hb 
from spdtmp7.sd_hc_txn_achb

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_achb(compress=yes);
set spdtmp7.sd_hc_txn_achb;
format start_date_hb ddmmyys10.;
format end_date_hb ddmmyys10.;
recency_hb=intck('day',end_date_hb,'28Feb2017'd);
active_time_hb=intck('day',start_date_hb,end_date_hb);
avg_units_per_txn_hb = total_unit_hb/no_of_txn_hb;
avg_units_per_visit_hb =  total_unit_hb/no_of_visits_hb;
run;

/*emax*/
data spdtmp7.sd_hc_txn_acem(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_ac_all;
where txn_Dt_wid>=20160301 and txn_dt_wid<=20170228 and lmg_concept_name="Emax"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_acem(compress=yes) as
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
           sum(base_points_accrued) as total_points_em 
from spdtmp7.sd_hc_txn_acem

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_acem(compress=yes);
set spdtmp7.sd_hc_txn_acem;
format start_date_em ddmmyys10.;
format end_date_em ddmmyys10.;
recency_em=intck('day',end_date_em,'28Feb2017'd);
active_time_em=intck('day',start_date_em,end_date_em);
avg_units_per_txn_em = total_unit_em/no_of_txn_em;
avg_units_per_visit_em =  total_unit_em/no_of_visits_em;
run;
/*bs*/

data spdtmp7.sd_hc_txn_acbs(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_ac_all;
where txn_Dt_wid>=20160301 and txn_dt_wid<=20170228 and lmg_concept_name="Babyshop"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_acbs (compress=yes) as
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
           sum(base_points_accrued) as total_points_bs 
from spdtmp7.sd_hc_txn_acbs

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_acbs(compress=yes);
set spdtmp7.sd_hc_txn_acbs;
format start_date_bs ddmmyys10.;
format end_date_bs ddmmyys10.;
recency_bs=intck('day',end_date_bs,'28Feb2017'd);
active_time_bs=intck('day',start_date_bs,end_date_bs);
avg_units_per_txn_bs = total_unit_bs/no_of_txn_bs;
avg_units_per_visit_bs =  total_unit_bs/no_of_visits_bs;
run;


/*join all tables*/


proc sql;
create table spdtmp7.sd_hc_txn_ac (compress=yes) as
select a.*,b.*,c.*,d.*,e.* from spdtmp7.sd_hc_txn_ac a left join spdtmp7.sd_hc_txn_acls b on a.LMG_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.sd_hc_txn_achb c on a.LMG_mem_card_number=c.LMG_mem_card_number left join spdtmp7.sd_hc_txn_acem d on a.LMG_mem_card_number=d.LMG_mem_card_number
left join spdtmp7.sd_hc_txn_acbs e
on a.LMG_mem_Card_number=e.LMG_mem_card_number;
quit;

proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_final1;
quit;


proc sql;
create table spdtmp7.sd_hc_txn_ac(compress=yes) as 
select *, ((sum_revenue_aed_ls)/(sum_revenue_Aed))*100 as perc_revenue_ls,
((sum_revenue_aed_bs)/(sum_revenue_Aed))*100 as perc_revenue_bs,
((sum_revenue_aed_em)/(sum_revenue_Aed))*100 as perc_revenue_em,
((sum_revenue_aed_hb)/(sum_revenue_Aed))*100 as perc_revenue_hb,
((total_unit_ls)/(total_unit))*100 as perc_unit_ls,
((total_unit_bs)/(total_unit))*100 as perc_unit_bs,
((total_unit_em)/(total_unit))*100 as perc_unit_em,
((total_unit_hb)/(total_unit))*100 as perc_unit_hb

from spdtmp7.sd_hc_txn_ac;
quit;

proc means data=spdtmp7.sd_hc_txn_ac;
run;

proc delete data=spdtmp7.sd_hc_txn_acls;run;
proc delete data= spdtmp7.sd_hc_txn_achb;run;
proc delete data=spdtmp7.sd_hc_txn_acem;run;
proc delete data=spdtmp7.sd_hc_txn_acbs;run;
