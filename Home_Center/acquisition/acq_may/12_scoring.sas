data spdtmp7.sd_hc_txn_acmay(compress=yes );
   set spdtmp7.sd_hc_txn_acmay;
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
data spdtmp7.sd_hc_txn_acmay (compress=yes);
set spdtmp7.sd_hc_txn_acmay;
run;

proc logistic  
     inmodel = spdtmp7.sd_hc_scoringac;
     score data = spdtmp7.sd_hc_txn_acmay
     Out  = spdtmp7.sd_hc_scoreacmay;
run;    

data spdtmp30.sd_hc_scoreacmay (compress=yes);
set spdtmp7.sd_hc_test_scoreacmay2;
run;


proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp30.sd_hc_scoreacmay ;
quit;

data spdtmp7.sd_hc_test_scoreacmay2(compress=yes);
set  spdtmp7.sd_hc_scoreacmay;
prob=-4.148621295+
Expat_Arab_nat_dummy*0.4526136054+
Gender_M_dummy*-0.398457421+
ISC_nat_dummy*0.2195361647+
LMG_EFFECTIVE_POINTS*0.0001909488+
Local_nat_dummy*0.7574638906+
Lstg_sgmnt_1*-1.122347782+
Lstg_sgmnt_2*-0.602894976+
Lstg_sgmnt_3*-0.586175495+
Lstg_sgmnt_4*-0.40149709+
Lstg_sgmnt_5*-0.622453445+
age_grp_5_dummy*0.1772890156+
age_grp_6_dummy*0.3155686501+
avg_units_per_visit_lmg6*-0.017933606+
perc_unit_hb*0.0116470822+
perc_unit_ls*0.0098498137+
recency*-0.007390237+
recency_hb*0.0018800765+
sum_revenue_aed_hb*-0.000405451+
sum_revenue_aed_ls*-0.000359814+
FAMILY_REV_AED*0.000376222+
no_of_txn_HF*0.1852027057+
no_of_txn_others*0.067529736
;

p=exp(prob);
score=p/(1+p);

run;

proc sql;
create table x as
select sum(P_1),sum(score) from spdtmp7.sd_hc_test_scoreacmay2;
run;


