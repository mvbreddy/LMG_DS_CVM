

%include'/home/unxsrv/code/Automated_Solutions/Libnames/LIBNAMES.sas';


/*data spdtmp7.sd_txn_wb(compress=yes);*/
/*set sascrm.tn_itm_rev_ae;*/
/*where txn_dt_wid>=20150101 and txn_dt_wid<=20170415;*/
/*run;*/

/*2015 custs*/

proc sql;
create table spdtmp7.VB_WB_LS_TXN_Cust2015 (compress=yes) as 
select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where Lmg_concept_name="Lifestyle" and txn_dt_wid<=20160131 and txn_dt_wid >= 20150201
group by LMG_mem_card_number;
quit;



/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number) from spdtmp7.sd_txn_custhc2016;*/
/*quit;*/


/*2016 custs*/

proc sql;
create table spdtmp7.VB_WB_LS_TXN_Cust2016 (compress=yes) as 
select distinct LMG_mem_Card_number from spdtmp7.sd_txn_wb
where Lmg_concept_name="Lifestyle" and txn_dt_wid>=20160201 and  txn_dt_wid<=20170131
group by LMG_mem_card_number;
quit;


/*winback cust base*/

data spdtmp7.VB_WB_LS_Cust(compress=yes);
merge spdtmp7.VB_WB_LS_TXN_Cust2015(in=a) spdtmp7.VB_WB_LS_TXN_Cust2016(in=b);
if a=1 and b=0 ;
by LMG_mem_card_number;
run;

/*proc sql;*/
/*create table abc(compress=yes) as */
/*select count(distinct LMG_mem_Card_number) from spdtmp7.sd_txn_wb*/
/*where LMG_concept_name="Lifestyle" and txn_dt_wid<=20161231;*/
/*quit;*/


/*proc delete data=spdtmp7.VB_WB_LS_TXN_Cust2015;run;*/
/**/
/*proc delete data=spdtmp7.VB_WB_LS_TXN_Cust2016;run;*/

/*Table for wb cust base all obs*/

proc sql;
create table spdtmp7.VB_WB_LS_TXN(compress=yes) as
select a.*,b.* from spdtmp7.VB_WB_LS_Cust a 
left join (select * from spdtmp7.sd_txn_wb where 20150201 <= txn_dt_wid <= 20160131)as b
on a.LMG_mem_Card_number=b.LMG_mem_card_number
;
quit;

/*Lifestyle winback customers*/

data spdtmp7.VB_WB_LS_ALL_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_LS_TXN;
where txn_dt_wid<=20160131 and txn_dt_wid>=20150201 and LMG_concept_name="Lifestyle" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

/*all metrices ls all customers*/


proc sql;
create table spdtmp7.VB_WB_LS_ALL_TXN (compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed, 
           count(distinct date) as no_of_visits, 
           count(distinct invoice_number) as no_of_txn, 
           max(date) as end_date, 
           min(date) as start_date,
           count(distinct item_code) as distinct_prod, 
           sum(units) as total_unit, 
           sum(base_points_accrued) as total_points ,
           sum(retail_cost_1_aed) as sum_cost_1,
           sum(retail_cost_2_aed) as sum_cost_2
		   
from spdtmp7.VB_WB_LS_ALL_TXN
group by LMG_MEM_CARD_Number;
quit;

data spdtmp7.VB_WB_LS_ALL_TXN(compress=yes);
set spdtmp7.VB_WB_LS_ALL_TXN;
format start_date ddmmyys10.;
format end_date ddmmyys10.;
recency=intck('day',end_date,'31Jan2016'd);
active_time=intck('day',start_date,end_date);
avg_units_per_txn = total_unit/no_of_txn;
avg_units_per_visit =  total_unit/no_of_visits;
run;


/* Making 3,6,9 month aggregates for potential Lifestyle winback customer base*/

data spdtmp7.VB_WB_LS_3_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_LS_TXN;
where txn_Dt_wid>=20151101 and txn_dt_wid<=20160131 and LMG_concept_name="Lifestyle" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_LS_3_TXN(compress=yes) as
select  LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_3, 
           count(distinct date) as no_of_visits_3, 
           count(distinct invoice_number) as no_of_txn_3, 
           max(date) as end_date_3, 
           min(date) as start_date_3,
           count(distinct item_code) as distinct_prod_3, 
           sum(units) as total_unit_3, 
           sum(base_points_accrued) as total_points_3 ,
           sum(retail_cost_1_aed) as sum_cost_1_3,
           sum(retail_cost_2_aed) as sum_cost_2_3

from spdtmp7.VB_WB_LS_3_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.VB_WB_LS_3_TXN;*/
/*quit;*/



data spdtmp7.VB_WB_LS_3_TXN(compress=yes);
set spdtmp7.VB_WB_LS_3_TXN;
format start_date_3 ddmmyys10.;
format end_date_3 ddmmyys10.;
recency_3=intck('day',end_date_3,'31Jan2016'd);
active_time_3=intck('day',start_date_3,end_date_3);
avg_units_per_txn_3 = total_unit_3/no_of_txn_3;
avg_units_per_visit_3 =  total_unit_3/no_of_visits_3;
run;

/*6months*/


data spdtmp7.VB_WB_LS_6_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_LS_TXN;
where txn_Dt_wid>=20150801 and txn_dt_wid<=20160131 and LMG_concept_name="Lifestyle" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;


proc sql;
create table spdtmp7.VB_WB_LS_6_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_6, 
           count(distinct date) as no_of_visits_6, 
           count(distinct invoice_number) as no_of_txn_6, 
           max(date) as end_date_6, 
           min(date) as start_date_6,
           count(distinct item_code) as distinct_prod_6, 
           sum(units) as total_unit_6, 
           sum(base_points_accrued) as total_points_6,
		   sum(retail_cost_1_aed) as sum_cost_1_6,
		   sum(retail_cost_2_aed) as sum_cost_2_6 
from spdtmp7.VB_WB_LS_6_TXN

group by LMG_MEM_CARD_Number;

quit;



data spdtmp7.VB_WB_LS_6_TXN(compress=yes);
set spdtmp7.VB_WB_LS_6_TXN;
format start_date_6 ddmmyys10.;
format end_date_6 ddmmyys10.;
recency_6=intck('day',end_date_6,'31Jan2016'd);
active_time_6=intck('day',start_date_6,end_date_6);
avg_units_per_txn_6 = total_unit_6/no_of_txn_6;
avg_units_per_visit_6 =  total_unit_6/no_of_visits_6;
run;

/*9months*/

data spdtmp7.VB_WB_LS_9_TXN(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.VB_WB_LS_TXN;
where txn_Dt_wid>=20150501 and txn_dt_wid<=20160131 and LMG_concept_name="Lifestyle" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;

proc sql;
create table spdtmp7.VB_WB_LS_9_TXN(compress=yes) as
select distinct LMG_mem_card_number, 
           sum(revenue_aed) as sum_revenue_aed_9, 
           count(distinct date) as no_of_visits_9, 
           count(distinct invoice_number) as no_of_txn_9, 
           max(date) as end_date_9, 
           min(date) as start_date_9,
           count(distinct item_code) as distinct_prod_9, 
           sum(units) as total_unit_9, 
           sum(base_points_accrued) as total_points_9 ,
           sum(retail_cost_1_aed) as sum_cost_1_9,
           sum(retail_cost_2_aed) as sum_cost_2_9

from spdtmp7.VB_WB_LS_9_TXN

group by LMG_MEM_CARD_Number;

quit;


/*proc sql;*/
/*select count(distinct LMG_mem_card_number) from spdtmp7.sd_hc_txn_31 ;*/
/*quit;*/


data spdtmp7.VB_WB_LS_9_TXN(compress=yes);
set spdtmp7.VB_WB_LS_9_TXN;
format start_date_9 ddmmyys10.;
format end_date_9 ddmmyys10.;
recency_9=intck('day',end_date_9,'31Jan2016'd);
active_time_9=intck('day',start_date_9,end_date_9);
avg_units_per_txn_9 = total_unit_9/no_of_txn_9;
avg_units_per_visit_9 =  total_unit_9/no_of_visits_9;
run;


/*join all tables*/

proc sql; 
create table spdtmp7.VB_WB_LS_TXN_Overall (compress=yes) as
select a.*,b.*,c.*,d.* from spdtmp7.VB_WB_LS_ALL_TXN a 
left join  spdtmp7.VB_WB_LS_3_TXN b on a.Lmg_mem_card_number=b.LMG_mem_card_number
left join spdtmp7.VB_WB_LS_6_TXN c on a.LMG_mem_card_number=c.LMG_mem_card_number
left join spdtmp7.VB_WB_LS_9_TXN d on a.LMG_mem_card_number=d.LMG_mem_card_number;
quit;



proc delete data=spdtmp7.VB_WB_LS_3_TXN;
proc delete data=spdtmp7.VB_WB_LS_6_TXN;
proc delete data=spdtmp7.VB_WB_LS_9_TXN;




data spdtmp7.VB_WB_LS_TXN_1(compress=yes keep=lmg_mem_card_number txn_dt_wid lmg_x_dept_cd revenue_aed invoice_number units item_code base_points_accrued retail_cost_1_aed retail_cost_2_aed date);
set spdtmp7.sd_txn_wb;
where 20150201<=txn_dt_wid<=20160131 and LMG_concept_name="Lifestyle" and revenue_aed>0 and units>0 and base_points_accrued >0 ;
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
           format date ddmmyys10.;
run;
 


data spdtmp7.VB_WB_LS_TXN_2(compress=yes);
length dept $ 20;
set spdtmp7.VB_WB_LS_TXN_1;

if LMG_X_DEPT_CD in ('400','402','403','401') then dept = "Beauty";
else if LMG_X_DEPT_CD = '405' then dept = "TeenGifts";
else if LMG_X_DEPT_CD in ('410','418','404','419','406') then dept = "Fashion";
else if LMG_X_DEPT_CD in ('415','407','413','417','411','412','409','416') then dept = "HomeFurnishing";
else if LMG_X_DEPT_CD =  '408' then dept = "HomeFragrance";
else dept =  "NA";

run;


proc sql;
create table spdtmp7.VB_WB_LS_TXN_3(compress=yes) as
select LMG_mem_card_number,
sum(case when dept="Beauty" then revenue_aed else . end) as revenue_AED_Beauty,
sum(case when dept="TeenGifts" then revenue_aed else . end) as revenue_Aed_TG,
sum(case when dept="Fashion" then revenue_aed else . end) as revenue_Aed_Fas,
sum(case when dept="HomeFurnishing" then revenue_aed else . end) as revenue_Aed_HF,
sum(case when dept="NA" then revenue_aed else . end) as revenue_Aed_Others,

sum(case when dept="Beauty" then units else . end) as total_units_Beauty,
sum(case when dept="TeenGifts" then units else . end) as total_units_TG,
sum(case when dept="Fashion" then units else . end) as total_units_Fas,
sum(case when dept="HomeFurnishing" then units else . end) as total_units_HF,
sum(case when dept="NA" then units else . end) as total_units_Others,

count(distinct (case when dept="Beauty"   then invoice_number else '' end)) as no_of_txn_Beauty,
count(distinct (case when dept="TeenGifts"   then invoice_number else '' end)) as no_of_txn_TG,
count(distinct (case when dept="Fashion"   then invoice_number else '' end)) as no_of_txn_Fas,
count(distinct (case when dept="HomeFurnishing"   then invoice_number else '' end)) as no_of_txn_HF,
count(distinct (case when dept="NA"   then invoice_number else '' end)) as no_of_txn_Others,

count(distinct (case when dept="Beauty"   then txn_dt_wid else . end)) as no_of_visits_Beauty,
count(distinct (case when dept="TeenGifts"   then txn_dt_wid else . end)) as no_of_visits_TG,
count(distinct (case when dept="Fashion"   then txn_dt_wid else . end)) as no_of_visits_Fas,
count(distinct (case when dept="HomeFurnishing"   then txn_dt_wid else . end)) as no_of_visits_HF,
count(distinct (case when dept="NA"   then txn_dt_wid else . end)) as no_of_visits_Others

from spdtmp7.VB_WB_LS_TXN_2
group by LMG_mem_card_number;
quit;



proc sql;
create table spdtmp7.VB_WB_LS_TXN_4(compress=yes) as 
select LMG_mem_card_number,
sum(case when lmg_x_dept_cd = '400' then revenue_aed else . end) as revenue_AED_400,
sum(case when lmg_x_dept_cd = '401' then revenue_aed else . end) as revenue_AED_401,
sum(case when lmg_x_dept_cd = '402' then revenue_aed else . end) as revenue_AED_402,
sum(case when lmg_x_dept_cd = '403' then revenue_aed else . end) as revenue_AED_403,
sum(case when lmg_x_dept_cd = '404' then revenue_aed else . end) as revenue_AED_404,
sum(case when lmg_x_dept_cd = '405' then revenue_aed else . end) as revenue_AED_405,
sum(case when lmg_x_dept_cd = '406' then revenue_aed else . end) as revenue_AED_406,
sum(case when lmg_x_dept_cd = '407' then revenue_aed else . end) as revenue_AED_407,
sum(case when lmg_x_dept_cd = '408' then revenue_aed else . end) as revenue_AED_408,
sum(case when lmg_x_dept_cd = '409' then revenue_aed else . end) as revenue_AED_409,
sum(case when lmg_x_dept_cd = '410' then revenue_aed else . end) as revenue_AED_410,
sum(case when lmg_x_dept_cd = '411' then revenue_aed else . end) as revenue_AED_411,
sum(case when lmg_x_dept_cd = '412' then revenue_aed else . end) as revenue_AED_412,
sum(case when lmg_x_dept_cd = '413' then revenue_aed else . end) as revenue_AED_413,
sum(case when lmg_x_dept_cd = '415' then revenue_aed else . end) as revenue_AED_415,
sum(case when lmg_x_dept_cd = '416' then revenue_aed else . end) as revenue_AED_416,
sum(case when lmg_x_dept_cd = '417' then revenue_aed else . end) as revenue_AED_417,
sum(case when lmg_x_dept_cd = '418' then revenue_aed else . end) as revenue_AED_418,
sum(case when lmg_x_dept_cd = '419' then revenue_aed else . end) as revenue_AED_419,

sum(case when lmg_x_dept_cd = '400' then units else . end) as units_400,
sum(case when lmg_x_dept_cd = '401' then units else . end) as units_401,
sum(case when lmg_x_dept_cd = '402' then units else . end) as units_402,
sum(case when lmg_x_dept_cd = '403' then units else . end) as units_403,
sum(case when lmg_x_dept_cd = '404' then units else . end) as units_404,
sum(case when lmg_x_dept_cd = '405' then units else . end) as units_405,
sum(case when lmg_x_dept_cd = '406' then units else . end) as units_406,
sum(case when lmg_x_dept_cd = '407' then units else . end) as units_407,
sum(case when lmg_x_dept_cd = '408' then units else . end) as units_408,
sum(case when lmg_x_dept_cd = '409' then units else . end) as units_409,
sum(case when lmg_x_dept_cd = '410' then units else . end) as units_410,
sum(case when lmg_x_dept_cd = '411' then units else . end) as units_411,
sum(case when lmg_x_dept_cd = '412' then units else . end) as units_412,
sum(case when lmg_x_dept_cd = '413' then units else . end) as units_413,
sum(case when lmg_x_dept_cd = '415' then units else . end) as units_415,
sum(case when lmg_x_dept_cd = '416' then units else . end) as units_416,
sum(case when lmg_x_dept_cd = '417' then units else . end) as units_417,
sum(case when lmg_x_dept_cd = '418' then units else . end) as units_418,
sum(case when lmg_x_dept_cd = '419' then units else . end) as units_419,


count(distinct (case when lmg_x_dept_cd = '400'   then invoice_number else '' end)) as no_of_txn_400,
count(distinct (case when lmg_x_dept_cd = '401'   then invoice_number else '' end)) as no_of_txn_401,
count(distinct (case when lmg_x_dept_cd = '402'   then invoice_number else '' end)) as no_of_txn_402,
count(distinct (case when lmg_x_dept_cd = '403'   then invoice_number else '' end)) as no_of_txn_403,
count(distinct (case when lmg_x_dept_cd = '404'   then invoice_number else '' end)) as no_of_txn_404,
count(distinct (case when lmg_x_dept_cd = '405'   then invoice_number else '' end)) as no_of_txn_405,
count(distinct (case when lmg_x_dept_cd = '406'   then invoice_number else '' end)) as no_of_txn_406,
count(distinct (case when lmg_x_dept_cd = '407'   then invoice_number else '' end)) as no_of_txn_407,
count(distinct (case when lmg_x_dept_cd = '408'   then invoice_number else '' end)) as no_of_txn_408,
count(distinct (case when lmg_x_dept_cd = '409'   then invoice_number else '' end)) as no_of_txn_409,
count(distinct (case when lmg_x_dept_cd = '410'   then invoice_number else '' end)) as no_of_txn_410,
count(distinct (case when lmg_x_dept_cd = '411'   then invoice_number else '' end)) as no_of_txn_411,
count(distinct (case when lmg_x_dept_cd = '412'   then invoice_number else '' end)) as no_of_txn_412,
count(distinct (case when lmg_x_dept_cd = '413'   then invoice_number else '' end)) as no_of_txn_413,
count(distinct (case when lmg_x_dept_cd = '415'   then invoice_number else '' end)) as no_of_txn_415,
count(distinct (case when lmg_x_dept_cd = '416'   then invoice_number else '' end)) as no_of_txn_416,
count(distinct (case when lmg_x_dept_cd = '417'   then invoice_number else '' end)) as no_of_txn_417,
count(distinct (case when lmg_x_dept_cd = '418'   then invoice_number else '' end)) as no_of_txn_418,
count(distinct (case when lmg_x_dept_cd = '419'   then invoice_number else '' end)) as no_of_txn_419


from spdtmp7.VB_WB_LS_TXN_2 
group by LMG_mem_card_number;
quit;




proc sql;
create table spdtmp7.VB_WB_LS_TXN_5(compress=yes) as
select a.*,b.*,c.* from spdtmp7.VB_WB_LS_TXN_Overall a 
left join  spdtmp7.VB_WB_LS_TXN_3 b on a.LMG_mem_card_number=b.LMG_mem_card_number
left join  spdtmp7.VB_WB_LS_TXN_4 c on a.LMG_mem_card_number=c.LMG_mem_card_number
;
quit; 


proc means data=spdtmp7.VB_WB_LS_TXN_5;
run;



proc delete data=spdtmp7.VB_WB_LS_TXN_1;run;
proc delete data=spdtmp7.VB_WB_LS_TXN_2;run;
proc delete data=spdtmp7.VB_WB_LS_TXN_3;run;
proc delete data=spdtmp7.VB_WB_LS_TXN_4;run;
