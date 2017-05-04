

proc sql;
create table SPDTMP30.VB_LS_SHHB_TN_ITM_REV_AE_1_1 (Compress = yes) as 
    select * from SPDTMP30.VB_LS_TN_ITM_REV_AE_1_1 as ls
	          left join (select * from SPDTMP30.VB_SH_TN_ITM_REV_AE_1_1 as sh
								 left join  (select * from SPDTMP30.VB_HC_TN_ITM_REV_AE_1_1 as hc
			  							                    left join (select * from SPDTMP30.VB_HB_TN_ITM_REV_AE_1_1 as hb
													 					left join SPDTMP30.VB_BS_TN_ITM_REV_AE_1_1 as bs
																		on hb.LMG_MEM_CARD_NUMBER = bs.LMG_MEM_CARD_NUMBER )as hbbs
															on hc.LMG_MEM_CARD_NUMBER = hbbs.LMG_MEM_CARD_NUMBER)as hchbbs
                                                     
									on sh.LMG_MEM_CARD_NUMBER = hchbbs.LMG_MEM_CARD_NUMBER)as shhchbbs
				on ls.LMG_MEM_CARD_NUMBER = shhchbbs.LMG_MEM_CARD_NUMBER ;
													
quit;


proc sql;
Create Table SPDTMP30.VB_ALL_LS_LMG_TN_ITM_REV_AE (compress=yes) as 
select * from SPDTMP30.VB_LS_SHHB_TN_ITM_REV_AE_1_1 as a
left join SPDTMP30.VB_ALL_TN_ITM_REV_AE_1_newer as b
on a.LMG_MEM_CARD_NUMBER  = b.LMG_MEM_CARD_NUMBER;
Quit;


/* proc contents data=SPDTMP30.VB_ALL_LS_LMG_TN_ITM_REV_AE;
run;   */

/*Creating a dataset of final Variables from VB_ALL_CUST_DETL_LMG_AE Customer Details Table*/

data SPDTMP30.VB_LS_CUST_DETL_LMG_AE_1  (compress = yes);
set SPDTMP30.VB_LS_CUST_DETL_LMG_AE (Keep= LMG_MEM_CARD_NUMBER SEX_MF_NAME  
		 LANG_NAME  AGE LMG_EFFECTIVE_POINTS CVM_Nationality_group ); 

run;

/* proc freq data= SPDTMP30.VB_LS_CUST_DETL_LMG_AE ; */
/*   tables Income_range_name Job_title Marital_stat_name  lang_name active_flg active_lang CVM_Nationality_group/missing;  */
/*   run;  */

/* Excluded variables due to missing data/skewed categories : ENROLLMENT_SOURCE,ACTIVE_FLG,INCOME_RANGE, JOB_TITLE, ACTIVE_FLG, ACTIVE_LANG, MARITAL_STAT_NAME   */

/* joining the Final Transaction Table with the final Customer Details Table */

proc sql;
Create Table SPDTMP30.VB_CUS_TN_ITM_REV_AE (compress=yes) as 
select * from SPDTMP30.VB_ALL_LS_LMG_TN_ITM_REV_AE as a
left join SPDTMP30.VB_LS_CUST_DETL_LMG_AE_1 as b
on a.LMG_MEM_CARD_NUMBER  = b.LMG_MEM_CARD_NUMBER;
Quit;

/* Getting the RFM segmentation data for Lifestyle */


data SPDTMP30.VB_RFM_SGMT_LS_AE (compress=yes) ;
set spddata.RFM_SGMNT_LS_AE ;
by LMG_MEM_CARD_NUMBER seg_yr_end_d  ;
if last.LMG_MEM_CARD_NUMBER then output  ;
run;


data SPDTMP30.VB_RFM_SGMT_LS_AE_1(compress= yes);
set SPDTMP30.VB_RFM_SGMT_LS_AE (drop= Lstage_Sgmnt) ;
if rfm_sgmnt_n = "0_Not Segmented" then rfm_sgmnt_n = "0 - Not Segmented"  ;
run;


/* Getting the Lifestage segmentation data for Lifestyle */

data SPDTMP30.VB_LSTG_SGMT_AE (compress= yes);
set spddata.LSTG_SGMNT_AE;
run;




/* Adding the RFM and Lifestage segmentation data */;
proc sql;
create table SPDTMP30.VB_CUS_TN_ITM_REV_AE_0 (compress = yes) as
select * from SPDTMP30.VB_CUS_TN_ITM_REV_AE as a 
left join SPDTMP30.VB_RFM_SGMT_LS_AE_1 as b
on a.LMG_MEM_CARD_NUMBER = b.LMG_MEM_CARD_NUMBER
left join SPDTMP30.VB_LSTG_SGMT_AE as c
on a.LMG_MEM_CARD_NUMBER = c.LMG_MEM_CARD_NUMBER;
quit;