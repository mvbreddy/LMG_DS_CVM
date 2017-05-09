data spdtmp7.sd_hc_activemay(compress=yes);
   set spdtmp7.sd_hc_activemay;
   array change _numeric_;
        do over change;
            if change=. then change=0;
        end;
		array _nums {*} _numeric_;
do i = 1 to dim(_nums);
  _nums{i} = round(_nums{i},.001);
end;
drop i;
run;



proc logistic  
     inmodel = spdtmp7.sd_hc_scoring;
     score data = spdtmp7.sd_hc_activemay
     Out  = spdtmp7.sd_hc_score_activemay(compress=yes);
run;  

 

data spdtmp30.sd_hc_score_activemay (compress=yes);
set spdtmp7.sd_hc_score_activemay;
run;


proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp30.sd_hc_score_activemay ;
quit;

data spdtmp7.sd_hc_score_activemay(compress=yes);
set  spdtmp7.sd_hc_score_activemay;
prob=-4.085841181+
active_time_9*-0.005591743+
avg_units_per_txn*-0.012217055+
no_of_txn_307*0.0523387925+
no_of_visits_furniture*0.0077801817+
perc_revenue_ls*0.0001825399+
recency_3*-0.004833602+
recency_9*-0.002606942+
recency_lmg*-0.006716825+
LMG_EFFECTIVE_POINTS*0.0000618228+
active_time_hb*0.0006925564+
avg_days_dif*-0.002266629+
avg_points*-0.001164571+
avg_units_per_txn_bs*-0.006490292+
recency_6*-0.001711156+
Expat_Arab_nat_dummy*0.0916617559+
ISC_nat_dummy*0.1818028284+
Local_nat_dummy*0.119580652+
RFM_2*2.4595198408+
RFM_4*4.0658934833+
RFM_5*3.7048807255+
RFM_6*4.6314257919+
MC_L3m_return_revenue_aed*-0.000117728+
revenue_AED_Beauty*-0.000069071
;

p=exp(prob);
score=p/(1+p);

run;

proc sql;
create table x as
select sum(P_1),sum(score) from spdtmp7.sd_hc_score_activemay;
run;


data spdtmp7.sd_hc_model_confusionwbapr1;
set spdtmp7.sd_hc_test_scorewbapr1;

if P_1 >= 0.0395 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.sd_hc_model_confusionwbapr1;
        table purchase_flag * prediction ;
run;