*Do file for 0007 
*Only include Ethiopia*
drop if country == 108
drop if country ==800

*make variables on the admin 2 level*
collapse (mean) wealthqhh_mean=wealthqhh edyears20wm_mean =
edyears20wm edyears20mn_mean=edyears20mn , by (admin2name)

*rename admin2*
rename admin2name admin2

*merge to ACLED data*
 merge m:1 admin2 using "C:\Users\alx11\OneDrive\Documents\Grad School\Research-G
> V\current files\ACLED_112016to12312017_admin2level_3_31_22.dta"

*change no events from * to 0*
replace event = 0 if event == .
replace eventprevyear = 0 if eventprevyear == .

*run logit models for:
*women education (over age 20)
logit event edyears20wm eventprevyear

*difference in male and female education (over age 20)
gen edyears20mmwndiff = edyears20mn- edyears20wm
logit event edyears20mmwndiff eventprevyear