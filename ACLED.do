*ACLED EVENT*
*create variable for event in previous year (confounder)*
gen eventprevyear =1 if year ==2016
*create even variable (outcome)*
gen event = 1 if year==2017

*collapse to get data on the admin 2 unit of analysis*
collapse (sum) eventprevyear= eventprevyear event=event, by(admin2)

*make binary variables*
replace eventprevyear=1 if eventprevyear>1
replace event=1 if event>1