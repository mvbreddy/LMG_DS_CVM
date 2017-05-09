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
run;




 
data spdtmp30.sd_hc_scorewbmay (compress=yes drop=P_1 P_0);
set spdtmp7.sd_hc_test_scorewbmay2;
run;

proc sql;
create table abc as
select count(distinct LMG_mem_card_number) from spdtmp30.sd_hc_scorewbmay;
quit;

data spdtmp7.sd_hc_test_scorewbmay2(compress=yes);
set  spdtmp7.sd_hc_test_scorewbmay1;
prob=-3.627224043+
MC_return_revenue_aed*0.0006734819+
MC_L9m_return_units*-1.308035753+
recency_lmgcy*-0.005223286+
Expat_Arab_nat_dummy*0.2023597606+
ISC_nat_dummy*0.3518567925+
LMG_EFFECTIVE_POINTS*0.0001115807+
Local_nat_dummy*0.2787258858+
Lstg_sgmnt_4*0.1423025742+
Lstg_sgmnt_7*0.172435429+
RFM_2*0.2273241981+
RFM_4*0.9345685033+
RFM_5*0.9138433375+
age_grp_5_dummy*0.1160112007+
age_grp_6_dummy*0.1390352708+
no_of_txn_3*-0.07808395+
no_of_txn_310*0.0724457567+
active_time_3_sq*0.0001172038+
no_of_visits_lmgcy6_sq*0.0004151275+
perc_unit_lscy_log*0.0810766979+
no_of_txn_306_log*-0.142603587+
no_of_visits_furniture*-0.253158315+
perc_unit_hbcy_srt*0.0540711311+
active_time_srt*0.0365317946+
FAMILY_REV_AED*0.0000525246+
no_of_txn_Fas*-0.030734731+
revenue_AED_furhb*-0.000097597;

p=exp(prob);
score=p/(1+p);

run;

proc sql;
create table x as
select sum(P_1),sum(score) from spdtmp7.sd_hc_test_scorewbmay2;
run;


data spdtmp7.sd_hc_model_confusionwbapr1;
set spdtmp7.sd_hc_test_scorewbapr1;

if P_1 >= 0.0395 then prediction = 1;
else prediction = 0;
run;

proc freq data= spdtmp7.sd_hc_model_confusionwbapr1;
        table purchase_flag * prediction ;
run;