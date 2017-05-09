
data spdtmp7.sd_hc_txn_wb(compress=yes drop= perc_revenue_ls
perc_revenue_bs
perc_revenue_em 
perc_revenue_hb 
perc_unit_ls
perc_unit_bs
perc_unit_em 
perc_unit_hb );

set spdtmp7.sd_hc_txn_wb;
run;


/*ls*/


data spdtmp7.sd_hc_txn_wblscy(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wb_all;
where txn_Dt_wid>=20160301 and txn_dt_wid<=20170228 and lmg_concept_name="Lifestyle"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wblscy (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lscy, 
           count(distinct date) as no_of_visits_lscy, 
         count(distinct invoice_number) as no_of_txn_lscy, 
           max(date) as end_date_lscy, 
           min(date) as start_date_lscy,
         count(distinct item_code) as distinct_prod_lscy, 
           sum(units) as total_unit_lscy, 
           sum(base_points_accrued) as total_points_lscy,
		   sum(retail_cost_1_Aed) as sum_cost_1_lscy,
sum(retail_cost_2_Aed) as sum_cost_2_lscy
from spdtmp7.sd_hc_txn_wblscy

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_wblscy(compress=yes);
set spdtmp7.sd_hc_txn_wblscy;
format start_date_lscy ddmmyys10.;
format end_date_lscy ddmmyys10.;
recency_lscy=intck('day',end_date_lscy,'28Feb2017'd);
active_time_lscy=intck('day',start_date_lscy,end_date_lscy);
avg_units_per_txn_lscy = total_unit_lscy/no_of_txn_lscy;
avg_units_per_visit_lscy =  total_unit_lscy/no_of_visits_lscy;
run;

/*hb*/





data spdtmp7.sd_hc_txn_wbhbcy(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wb_all;
where txn_Dt_wid>=20160301 and txn_dt_wid<=20170228 and lmg_concept_name="Home Box"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbhbcy (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_hbcy, 
           count(distinct date) as no_of_visits_hbcy, 
         count(distinct invoice_number) as no_of_txn_hbcy, 
           max(date) as end_date_hbcy, 
           min(date) as start_date_hbcy,
         count(distinct item_code) as distinct_prod_hbcy, 
           sum(units) as total_unit_hbcy, 
		   sum(retail_cost_1_aed) as sum_cost_1_hbcy,
		   sum(retail_cost_2_aed) as sum_cost_2_hbcy,
           sum(base_points_accrued) as total_points_hbcy 
from spdtmp7.sd_hc_txn_wbhbcy

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_wbhbcy(compress=yes);
set spdtmp7.sd_hc_txn_wbhbcy;
format start_date_hbcy ddmmyys10.;
format end_date_hbcy ddmmyys10.;
recency_hbcy=intck('day',end_date_hbcy,'28Feb2017'd);
active_time_hbcy=intck('day',start_date_hbcy,end_date_hbcy);
avg_units_per_txn_hbcy = total_unit_hbcy/no_of_txn_hbcy;
avg_units_per_visit_hbcy =  total_unit_hbcy/no_of_visits_hbcy;
run;

/*emax*/
data spdtmp7.sd_hc_txn_wbemcy(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wb_all;
where txn_Dt_wid>=20160301 and txn_dt_wid<=20170228 and lmg_concept_name="Emax"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbemcy(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_emcy, 
           count(distinct date) as no_of_visits_emcy, 
         count(distinct invoice_number) as no_of_txn_emcy, 
           max(date) as end_date_emcy, 
           min(date) as start_date_emcy,
         count(distinct item_code) as distinct_prod_emcy, 
           sum(units) as total_unit_emcy, 
		   sum(retail_cost_1_aed) as sum_cost_1_emcy,
		   sum(retail_cost_2_aed) as sum_cost_2_emcy,
           sum(base_points_accrued) as total_points_emcy 
from spdtmp7.sd_hc_txn_wbemcy

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_wbemcy(compress=yes);
set spdtmp7.sd_hc_txn_wbemcy;
format start_date_emcy ddmmyys10.;
format end_date_emcy ddmmyys10.;
recency_emcy=intck('day',end_date_emcy,'28Feb2017'd);
active_time_emcy=intck('day',start_date_emcy,end_date_emcy);
avg_units_per_txn_emcy = total_unit_emcy/no_of_txn_emcy;
avg_units_per_visit_emcy =  total_unit_emcy/no_of_visits_emcy;
run;
/*bs*/

data spdtmp7.sd_hc_txn_wbbscy(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wb_all;
where txn_Dt_wid>=20160301 and txn_dt_wid<=20170228 and lmg_concept_name="Babyshop"  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbbscy (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_bscy, 
           count(distinct date) as no_of_visits_bscy, 
         count(distinct invoice_number) as no_of_txn_bscy, 
           max(date) as end_date_bscy, 
           min(date) as start_date_bscy,
         count(distinct item_code) as distinct_prod_bscy, 
           sum(units) as total_unit_bscy, 
		   sum(retail_cost_1_aed) as sum_cost_1_bscy,
		   sum(retail_cost_2_aed) as sum_cost_2_bscy,
           sum(base_points_accrued) as total_points_bscy 
from spdtmp7.sd_hc_txn_wbbscy

group by LMG_MEM_CARD_Number;

quit;


proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_all2 ;
quit;

/*create rfm*/

data spdtmp7.sd_hc_txn_wbbscy(compress=yes);
set spdtmp7.sd_hc_txn_wbbscy;
format start_date_bscy ddmmyys10.;
format end_date_bscy ddmmyys10.;
recency_bscy=intck('day',end_date_bscy,'28Feb2017'd);
active_time_bscy=intck('day',start_date_bscy,end_date_bscy);
avg_units_per_txn_bscy = total_unit_bscy/no_of_txn_bscy;
avg_units_per_visit_bscy =  total_unit_bscy/no_of_visits_bscy;
run;


/*join all tables*/


proc sql;
create table spdtmp7.sd_hc_txn_wb (compress=yes) as
select a.*,b.*,c.*,d.*,e.* from spdtmp7.sd_hc_txn_wb a left join spdtmp7.sd_hc_txn_wblscy b on a.LMG_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.sd_hc_txn_wbhbcy c on a.LMG_mem_card_number=c.LMG_mem_card_number left join spdtmp7.sd_hc_txn_wbemcy d on a.LMG_mem_card_number=d.LMG_mem_card_number
left join spdtmp7.sd_hc_txn_wbbscy e
on a.LMG_mem_Card_number=e.LMG_mem_card_number;
quit;

proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_final1;
quit;


proc sql;
create table spdtmp7.sd_hc_txn_wb(compress=yes) as 
select *, ((sum_revenue_aed_lscy)/(sum_revenue_Aed_lmgcy))*100 as perc_revenue_lscy,
((sum_revenue_aed_bscy)/(sum_revenue_Aed_lmgcy))*100 as perc_revenue_bscy,
((sum_revenue_aed_emcy)/(sum_revenue_Aed_lmgcy))*100 as perc_revenue_emcy,
((sum_revenue_aed_hbcy)/(sum_revenue_Aed_lmgcy))*100 as perc_revenue_hbcy,
((total_unit_lscy)/(total_unit_lmgcy))*100 as perc_unit_lscy,
((total_unit_bscy)/(total_unit_lmgcy))*100 as perc_unit_bscy,
((total_unit_emcy)/(total_unit_lmgcy))*100 as perc_unit_emcy,
((total_unit_hbcy)/(total_unit_lmgcy))*100 as perc_unit_hbcy

from spdtmp7.sd_hc_txn_wb;
quit;

proc means data=spdtmp7.sd_hc_txn_wb;
run;

proc delete data=spdtmp7.sd_hc_txn_wblscy;run;
proc delete data= spdtmp7.sd_hc_txn_wbhbcy;run;
proc delete data=spdtmp7.sd_hc_txn_wbemcy;run;
proc delete data=spdtmp7.sd_hc_txn_wbbscy;run;


data spdtmp7.sd_hc_txn_wb(compress=yes);
   set spdtmp7.sd_hc_txn_wb;
   array change _numeric_;
        do over change;
            if change=. then change=0;
        end;
		array _nums {*} _numeric_;
do i = 1 to dim(_nums);
  _nums{i} = round(_nums{i},.001);
end;
drop i;



if no_of_txn_lmgcy=0 then atv_lmgcy=0;
else if no_of_txn_lmgcy<>0 then
atv_lmgcy=sum_revenue_Aed_lmgcy/no_of_txn_lmgcy;

if no_of_txn_lmgcy3=0 then atv_lmgcy3=0;
else if no_of_txn_lmgcy3<>0 then
atv_lmgcy3=sum_revenue_Aed_lmgcy3/no_of_txn_lmgcy3;

if no_of_txn_lmgcy6=0 then atv_lmgcy6=0;
else if no_of_txn_lmgcy6<>0 then
atv_lmgcy6=sum_revenue_Aed_lmgcy6/no_of_txn_lmgcy6;

if no_of_txn_lmgcy9=0 then atv_lmgcy9=0;
else if no_of_txn_lmgcy9<>0 then
atv_lmgcy9=sum_revenue_Aed_lmgcy9/no_of_txn_lmgcy9;

if no_of_txn_lscy=0 then atv_lscy=0;
else if no_of_txn_lscy<>0 then
atv_lscy=sum_revenue_aed_lscy/no_of_txn_lscy;

if no_of_txn_hbcy=0 then atv_hbcy=0;
else if no_of_txn_hbcy<>0 then
atv_hbcy=sum_revenue_aed_hbcy/no_of_txn_hbcy;

if no_of_txn_bscy=0 then atv_bscy=0;
else if no_of_txn_bscy<>0 then
atv_bscy=sum_revenue_aed_bscy/no_of_txn_bscy;

if no_of_txn_emcy=0 then atv_emcy=0;
else if no_of_txn_emcy<>0 then
atv_emcy=sum_revenue_aed_emcy/no_of_txn_emcy;

run;



proc means data=spdtmp7.sd_hc_txn_wb;
run;



data spdtmp7.sd_hc_txn_wb(compress=yes);
set spdtmp7.sd_hc_txn_wb;

recency_lmgcy_cube=recency_lmgcy**3;
no_of_visits_lmgcy6_cube=no_of_visits_lmgcy6**3;
perc_unit_lscy_cube=perc_unit_lscy**3;
perc_unit_hbcy_cube=perc_unit_hbcy**3;
active_time_cube=active_time**3;
active_time_3_cube=active_time_3**3;
avg_units_per_visit_lmg6_cube=avg_units_per_visit_lmg6**3;
no_of_txn_3_cube=no_of_txn_3**3;
no_of_txn_306_cube=no_of_txn_306**3;
no_of_txn_310_cube=no_of_txn_310**3;
no_of_visits_furniture_cube=no_of_visits_furniture**3;
sum_cost_1_bs_cube=sum_cost_1_bs**3;
recency_lmgcy_srt=sqrt(recency_lmgcy);
no_of_visits_lmgcy6_srt=sqrt(no_of_visits_lmgcy6);
perc_unit_lscy_srt=sqrt(perc_unit_lscy);
perc_unit_hbcy_srt=sqrt(perc_unit_hbcy);
active_time_srt=sqrt(active_time);
active_time_3_srt=sqrt(active_time_3);
avg_units_per_visit_lmg6_srt=sqrt(avg_units_per_visit_lmg6);
no_of_txn_3_srt=sqrt(no_of_txn_3);
no_of_txn_306_srt=sqrt(no_of_txn_306);
no_of_txn_310_srt=sqrt(no_of_txn_310);
no_of_visits_furniture_srt=sqrt(no_of_visits_furniture);
sum_cost_1_bs_srt=sqrt(sum_cost_1_bs);
recency_lmgcy_log=log(recency_lmgcy+1);
no_of_visits_lmgcy6_log=log(no_of_visits_lmgcy6+1);
perc_unit_lscy_log=log(perc_unit_lscy+1);
perc_unit_hbcy_log=log(perc_unit_hbcy+1);
active_time_log=log(active_time+1);
active_time_3_log=log(active_time_3+1);
avg_units_per_visit_lmg6_log=log(avg_units_per_visit_lmg6+1);
no_of_txn_3_log=log(no_of_txn_3+1);
no_of_txn_306_log=log(no_of_txn_306+1);
no_of_txn_310_log=log(no_of_txn_310+1);
no_of_visits_furniture_log=log(no_of_visits_furniture+1);
sum_cost_1_bs_log=log(sum_cost_1_bs+1);
recency_lmgcy_sq=recency_lmgcy**2;
no_of_visits_lmgcy6_sq=no_of_visits_lmgcy6**2;
perc_unit_lscy_sq=perc_unit_lscy**2;
perc_unit_hbcy_sq=perc_unit_hbcy**2;
active_time_sq=active_time**2;
active_time_3_sq=active_time_3**2;
avg_units_per_visit_lmg6_sq=avg_units_per_visit_lmg6**2;
no_of_txn_3_sq=no_of_txn_3**2;
no_of_txn_306_sq=no_of_txn_306**2;
no_of_txn_310_sq=no_of_txn_310**2;
no_of_visits_furniture_sq=no_of_visits_furniture**2;
sum_cost_1_bs_sq=sum_cost_1_bs**2;

;
run;

