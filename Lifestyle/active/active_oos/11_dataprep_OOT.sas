




  /*Getting LMG transactions between the given dates. A formatted date variable is also added*/
  

  data SPDTMP30.VB_ALL_TN_ITM_REV_AE (Compress=yes);
      set sascrm.TN_ITM_REV_AE ;
		where TXN_DT_WID >= 20150201 and TXN_DT_WID<= 20160131 and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;

	    date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
		format date ddmmyys10.;
  run;

/*data crosscheck1;*/
/*set SPDTMP30.VB_ALL_TN_ITM_REV_AE;*/
/*where TXN_DT_WID >= 20160201 and TXN_DT_WID<= 20170131 and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 */
/*		and lmg_mem_card_number = "1800000006365362";*/
/*	    date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); */
/*		format date ddmmyys10.;*/
/**/
/*run;*/
/**/
/*data crosscheck;*/
/*set SPDTMP30.VB_CUS_TN_ITM_REV_AE_7;*/
/*where LMG_MEM_CARD_NUMBER = "1800000006365362";*/
/*run;*/
 

/*Getting Lifestyle transactions between the given dates and creating a Visit_flag as a categorical  variable to 
  give a time component to visits. A formatted date variable is also added*/

data SPDTMP30.VB_LS_TN_ITM_REV_AE_ (Compress=yes);
      set sascrm.TN_ITM_REV_AE ;
		where TXN_DT_WID >= 20150201 and TXN_DT_WID<= 20160131 and LMG_CONCEPT_NAME = "Lifestyle" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;

	   if TXN_DT_WID>= 20150201 and TXN_DT_WID<= 20150430 then visit_flag = 4 ;
	   else if TXN_DT_WID> 20150430 and TXN_DT_WID<= 20150731 then visit_flag = 3 ;
	   else if TXN_DT_WID> 20150731 and TXN_DT_WID<= 20151031 then visit_flag = 2; 
	   else if TXN_DT_WID> 20151031 and TXN_DT_WID<= 20160131 then visit_flag = 1; 
	   date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
	   format date ddmmyys10.;
  run;

   
  data SPDTMP30.VB_SH_TN_ITM_REV_AE_ (Compress=yes);
      set sascrm.TN_ITM_REV_AE ;
		where TXN_DT_WID >= 20150201 and TXN_DT_WID<= 20160131 and LMG_CONCEPT_NAME = "Splash" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;

	   if TXN_DT_WID>= 20150201 and TXN_DT_WID<= 20150430 then visit_flag = 4 ;
	   else if TXN_DT_WID> 20150430 and TXN_DT_WID<= 20150731 then visit_flag = 3 ;
	   else if TXN_DT_WID> 20150731 and TXN_DT_WID<= 20151031 then visit_flag = 2; 
	   else if TXN_DT_WID> 20151031 and TXN_DT_WID<= 20160131 then visit_flag = 1; 
	   date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
	   format date ddmmyys10.;
  run;


data SPDTMP30.VB_HC_TN_ITM_REV_AE_ (Compress=yes);
      set sascrm.TN_ITM_REV_AE ;
		where TXN_DT_WID >= 20150201 and TXN_DT_WID<= 20160131 and LMG_CONCEPT_NAME = "Home center" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;

	   if TXN_DT_WID>= 20150201 and TXN_DT_WID<= 20150430 then visit_flag = 4 ;
	   else if TXN_DT_WID> 20150430 and TXN_DT_WID<= 20150731 then visit_flag = 3 ;
	   else if TXN_DT_WID> 20150731 and TXN_DT_WID<= 20151031 then visit_flag = 2; 
	   else if TXN_DT_WID> 20151031 and TXN_DT_WID<= 20160131 then visit_flag = 1; 
	   date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
	   format date ddmmyys10.;
  run;

data SPDTMP30.VB_HB_TN_ITM_REV_AE_ (Compress=yes);
      set sascrm.TN_ITM_REV_AE ;
		where TXN_DT_WID >= 20150201 and TXN_DT_WID<= 20160131 and LMG_CONCEPT_NAME = "Home Box" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;

	   if TXN_DT_WID>= 20150201 and TXN_DT_WID<= 20150430 then visit_flag = 4 ;
	   else if TXN_DT_WID> 20150430 and TXN_DT_WID<= 20150731 then visit_flag = 3 ;
	   else if TXN_DT_WID> 20150731 and TXN_DT_WID<= 20151031 then visit_flag = 2; 
	   else if TXN_DT_WID> 20151031 and TXN_DT_WID<= 20160131 then visit_flag = 1; 
	   date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
	   format date ddmmyys10.;
  run;

  

data SPDTMP30.VB_BS_TN_ITM_REV_AE_ (Compress=yes);
      set sascrm.TN_ITM_REV_AE ;
		where TXN_DT_WID >= 20150201 and TXN_DT_WID<= 20160131 and LMG_CONCEPT_NAME = "Babyshop" and TRANSACTION_TYPE = "Purchase" and units >= 0 and revenue_aed >= 0 and Retail_cost_1_AED >= 0 and Retail_cost_2_AED>= 0 ;

	   if TXN_DT_WID>= 20150201 and TXN_DT_WID<= 20150430 then visit_flag = 4 ;
	   else if TXN_DT_WID> 20150430 and TXN_DT_WID<= 20150731 then visit_flag = 3 ;
	   else if TXN_DT_WID> 20150731 and TXN_DT_WID<= 20151031 then visit_flag = 2; 
	   else if TXN_DT_WID> 20151031 and TXN_DT_WID<= 20160131 then visit_flag = 1; 
	   date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
	   format date ddmmyys10.;
  run;



  /*
data SPDTMP30.VB_LS_TN_ITM_REV_AE;
set SPDTMP30.VB_LS_TN_ITM_REV_AE ; 
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
format date ddmmyys10.;
run;

data SPDTMP30.VB_ALL_TN_ITM_REV_AE;
set SPDTMP30.VB_ALL_TN_ITM_REV_AE ; 
date = INPUT(PUT(TXN_DT_WID,8.),YYMMDD8.); 
format date ddmmyys10.;
run;
*/

data SPDTMP30.VB_LS_CUST_DETL_LMG_AE (Compress=yes);
      set sascrm.CUST_DETL_LMG_AE ;
run;
