/*LMG_ALL*/

data spdtmp7.sd_hc_txn_wbmaycy0(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbmay_all;
where txn_Dt_wid>=20160501 and txn_dt_wid<=20170430  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbmaycy0 (compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmgcy, 
           count(distinct date) as no_of_visits_lmgcy, 
         count(distinct invoice_number) as no_of_txn_lmgcy, 
           max(date) as end_date_lmgcy, 
           min(date) as start_date_lmgcy,
         count(distinct item_code) as distinct_prod_lmgcy, 
           sum(units) as total_unit_lmgcy, 
          sum(base_points_accrued) as total_points_lmgcy ,
		   sum(retail_cost_1_aed) as sum_cost_1_lmgcy,
		   sum(retail_cost_2_aed) as sum_cost_2_lmgcy,
		   count(distinct LMG_concept_name) as distinct_concept
from spdtmp7.sd_hc_txn_wbmaycy0

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_wbmaycy0(compress=yes);
set spdtmp7.sd_hc_txn_wbmaycy0;
format start_date_lmgcy ddmmyys10.;
format end_date_lmgcy ddmmyys10.;
recency_lmgcy=intck('day',end_date_lmgcy,'30Apr2017'd);
active_time_lmgcy=intck('day',start_date_lmgcy,end_date_lmgcy);
avg_units_per_txn_lmgcy = total_unit_lmgcy/no_of_txn_lmgcy;
avg_units_per_visit_lmgcy =  total_unit_lmgcy/no_of_visits_lmgcy;
run;


/*3months*/

data spdtmp7.sd_hc_txn_wbmaycy1(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbmay_all;
where txn_Dt_wid>=20170201 and txn_dt_wid<=20170430  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbmaycy1(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmgcy3, 
           count(distinct date) as no_of_visits_lmgcy3, 
         count(distinct invoice_number) as no_of_txn_lmgcy3, 
           max(date) as end_date_lmgcy3, 
           min(date) as start_date_lmgcy3,
         count(distinct item_code) as distinct_prod_lmgcy3, 
           sum(units) as total_unit_lmgcy3, 
           sum(base_points_accrued) as total_points_lmgcy3 ,
		   sum(retail_cost_1_aed) as sum_cost_1_lmgcy3,
		   sum(retail_cost_2_aed) as sum_cost_2_lmgcy3,
		   count(distinct Lmg_concept_name) as distinct_concept_lmgcy3
from spdtmp7.sd_hc_txn_wbmaycy1

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_wbmaycy1(compress=yes);
set spdtmp7.sd_hc_txn_wbmaycy1;
format start_date_lmgcy3 ddmmyys10.;
format end_date_lmgcy3 ddmmyys10.;
recency_lmgcy3=intck('day',end_date_lmgcy3,'30Apr2017'd);
active_time_lmgcy3=intck('day',start_date_lmgcy3,end_date_lmgcy3);
avg_units_per_txn_lmgcy3 = total_unit_lmgcy3/no_of_txn_lmgcy3;
avg_units_per_visit_lmgcy3 =  total_unit_lmgcy3/no_of_visits_lmgcy3;
run;

/*6months*/

data spdtmp7.sd_hc_txn_wbmaycy2(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbmay_all;
where txn_Dt_wid>=20161101 and txn_dt_wid<=20170430  and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbmaycy2(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmgcy6, 
           count(distinct date) as no_of_visits_lmgcy6, 
         count(distinct invoice_number) as no_of_txn_lmgcy6, 
           max(date) as end_date_lmgcy6, 
           min(date) as start_date_lmgcy6,
         count(distinct item_code) as distinct_prod_lmgcy6, 
           sum(units) as total_unit_lmgcy6, 
           sum(base_points_accrued) as total_points_lmgcy6 ,
		   sum(retail_cost_1_aed) as sum_cost_1_lmgcy6,
		   sum(retail_cost_2_aed) as sum_cost_2_lmgcy6,
		   count(distinct lmg_concept_name) as distinct_concept_lmgcy6
from spdtmp7.sd_hc_txn_wbmaycy2

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_wbmaycy2(compress=yes);
set spdtmp7.sd_hc_txn_wbmaycy2;
format start_date_lmgcy6 ddmmyys10.;
format end_date_lmgcy6 ddmmyys10.;
recency_lmgcy6=intck('day',end_date_lmgcy6,'30Apr2017'd);
active_time_lmgcy6=intck('day',start_date_lmgcy6,end_date_lmgcy6);
avg_units_per_txn_lmgcy6 = total_unit_lmgcy6/no_of_txn_lmgcy6;
avg_units_per_visit_lmgcy6 =  total_unit_lmgcy6/no_of_visits_lmgcy6;
run;


/*9 months*/


data spdtmp7.sd_hc_txn_wbmaycy3(compress=yes keep=lmg_mem_card_number lmg_concept_name txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wbmay_all;
where txn_Dt_wid>=20160801 and txn_dt_wid<=20170430 and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;



proc sql;
create table spdtmp7.sd_hc_txn_wbmaycy3(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_lmgcy9, 
           count(distinct date) as no_of_visits_lmgcy9, 
         count(distinct invoice_number) as no_of_txn_lmgcy9, 
           max(date) as end_date_lmgcy9, 
           min(date) as start_date_lmgcy9,
         count(distinct item_code) as distinct_prod_lmgcy9, 
           sum(units) as total_unit_lmgcy9, 
           sum(base_points_accrued) as total_points_lmgcy9 ,
		   sum(retail_cost_1_aed) as sum_cost_1_lmgcy9,
		   sum(retail_Cost_2_aed) as sum_cost_2_lmgcy9,
		   count(distinct Lmg_concept_name) as distinct_concept_lmgcy9

from spdtmp7.sd_hc_txn_wbmaycy3

group by LMG_MEM_CARD_Number;

quit;




/*create rfm*/

data spdtmp7.sd_hc_txn_wbmaycy3(compress=yes);
set spdtmp7.sd_hc_txn_wbmaycy3;
format start_date_lmgcy9 ddmmyys10.;
format end_date_lmgcy9 ddmmyys10.;
recency_lmgcy9=intck('day',end_date_lmgcy9,'30Apr2017'd);
active_time_lmgcy9=intck('day',start_date_lmgcy9,end_date_lmgcy9);
avg_units_per_txn_lmgcy9 = total_unit_lmgcy9/no_of_txn_lmgcy9;
avg_units_per_visit_lmgcy9 =  total_unit_lmgcy9/no_of_visits_lmgcy9;
run;

/*join all tables*/

proc sql;
create table spdtmp7.sd_hc_txn_wbmay (compress=yes) as
select a.*,b.*,c.*,d.*,e.* from spdtmp7.sd_hc_txn_wbmay a left join spdtmp7.sd_hc_txn_wbmaycy0 b on a.LMG_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.sd_hc_txn_wbmaycy1 c on a.LMG_mem_card_number=c.LMG_mem_card_number left join spdtmp7.sd_hc_txn_wbmaycy2 d
on a.LMG_mem_card_number=d.LMG_mem_card_number left join spdtmp7.sd_hc_txn_wbmaycy3 e on a.LMG_mem_card_number=e.LMG_mem_card_number;
quit;
proc sql;
create table spdtmp7.sd_hc_txn_wbmay(compress=yes) as 
select *, ((sum_revenue_aed_lscy)/(sum_revenue_Aed_lmgcy))*100 as perc_revenue_lscy,
((sum_revenue_aed_bscy)/(sum_revenue_Aed_lmgcy))*100 as perc_revenue_bscy,
((sum_revenue_aed_emcy)/(sum_revenue_Aed_lmgcy))*100 as perc_revenue_emcy,
((sum_revenue_aed_hbcy)/(sum_revenue_Aed_lmgcy))*100 as perc_revenue_hbcy,
((total_unit_lscy)/(total_unit_lmgcy))*100 as perc_unit_lscy,
((total_unit_bscy)/(total_unit_lmgcy))*100 as perc_unit_bscy,
((total_unit_emcy)/(total_unit_lmgcy))*100 as perc_unit_emcy,
((total_unit_hbcy)/(total_unit_lmgcy))*100 as perc_unit_hbcy

from spdtmp7.sd_hc_txn_wbmay;
quit;



proc sql;
select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_wbmay ;
quit;

proc delete data=spdtmp7.sd_hc_txn_wbmaycy0;
proc delete data=spdtmp7.sd_hc_txn_wbmaycy1;
proc delete data=spdtmp7.sd_hc_txn_wbmaycy2;
proc delete data=spdtmp7.sd_hc_txn_wbmaycy3;





data spdtmp7.sd_hc_txn_wbmay(compress=yes);
   set spdtmp7.sd_hc_txn_wbmay;
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



proc means data=spdtmp7.sd_hc_txn_wbmay;
run;



data spdtmp7.sd_hc_txn_wbmay(compress=yes);
set spdtmp7.sd_hc_txn_wbmay;

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


