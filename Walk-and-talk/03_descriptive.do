*******************************************************************************
***                                                                         ***
***                         Women's Rights –                                ***
***      				  Walking and talking 								***
***																			***
***																			***
*******************************************************************************
* 		Liz Boyle and Nir Rotem
* 07.16.2021

******************** For paper 1  ********************

*** Descriptive statistics


cd "C:\Users\Nir\Documents\Projects\2020\Grounded decoupling\IPUMS DHS data"

clear

** Here we limit the file in memory to married or were married women. So in fact, we can remove all the if never_married==0 from the models below
use 02_women.dta 

keep if ever_married==1

drop if age<25

* We need a model so we can get the relevant descriptive statistics
mlogit decoupling i.educlvl i.media_access i.urban i.wealthq_5 i.currwork_d ib1.edugap c.age c.de2pc c.muslimpc i.waves2 i.country [pw=popwt], base(0)
generate model_sample=e(sample)
estimates store mo1

keep if model_sample==1


*summary table
*install baselinetable
putdocx begin
baselinetable educlvl(cat countformat(%15.0gc)) ///
radio(cat value(1) novaluelabel countformat(%15.0gc)) ///
urban(cat value(1) novaluelabel countformat(%15.0gc)) ///
age(cts novarlabel afterheading("Age, mean (sd)")) ///
religion_cf(cat countformat(%15.0gc)) ///
wealthq(cat countformat(%15.0gc)) ///
currwork_d(cat value(1) novaluelabel countformat(%15.0gc)) ///
edugap(cat countformat(%15.0gc)) ///
de2pc(cts novarlabel afterheading("% Walk not talk, mean (sd)")) ///
mar18pc(cts novarlabel afterheading("% Under age 18 when married, mean (sd)")) ///
muslimmaj(cat countformat(%15.0gc)) ///
waves2(cat value(2) novarlabel countformat(%15.0gc)) ///
if model_sample==1, ///
by(decoupling) putdocxtab(summery_table)
putdocx save summery_table, replace
*exportexcel(summery_table, replace)

set scheme cleanplots

* hist of the % categories in a cluster
hist de1pc if model_sample==1, name(hist1)
hist de2pc if model_sample==1, name(hist2)
hist de3pc if model_sample==1, name(hist3)
hist de4pc if model_sample==1, name(hist4)
graph combine hist1 hist2 hist3 hist4



***Change of decoupling over time

tab decoupling waves2 [iweight=popwt] if model_sample==1, co // Here we use the native POPWT

*** Religion over time
tab decoupling religion_4c if model_sample==1 & waves2==1, co
tab decoupling religion_4c if model_sample==1 & waves2==2, co

xtable decoupling religion_4c if model_sample==1 & waves2==1, filename(religion_wave1.xlsx)
xtable decoupling religion_4c if model_sample==1 & waves2==2, filename(religion_wave2.xlsx)


************ A figure with the 4 categories of discordance, by country and wave

* ssc install splitvallabels
* findit grc1leg
set scheme plotplain

splitvallabels waves2, length(6) 
catplot decoupling waves2 [iweight=popwt] if country==50 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Bangladesh" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(bangladesh)


splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==108 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Burundi" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(burundi)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==120 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Cameroon" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(cameroon)


splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==180 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Congo Democratoc Republic" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(congo)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==204 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Benin" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(benin)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==231 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Ethiopia" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(ethiopia)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==288 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Ghana" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(ghana)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==324 & model_s==1, ///
percent(waves2) /// 
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Guinea" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(guinea)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==356 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("India" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(india)

*splitvallabels waves2, length(6)  
*catplot decoupling waves2 if country==400, ///
*percent(waves2) ///
*var1opts(label(labsize(small))) ///
*var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
*ytitle("Level of support", size(small)) ///
*title("Jordan" ///
*, span size(medium)) ///
*intensity(25) ///
*asyvars stack ///
*bar(1, color(maroon) fintensity(inten80)) ///
*bar(2, color(maroon) fintensity(inten60)) ///
*bar(3, color(gray) fintensity(inten40)) ///
*bar(4, color(navy) fintensity(inten60)) ///
*legend(rows(2) stack size(small) ///
*order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
*3 "Supports gender equity/Not empowered in household" ///
*4 "Rejects gender equity/Not empowered in household") ///
*symplacement(center) ///
*title(Discordance , size(small))) name(jordan)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==404 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Kenya" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(kenya)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==426 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Lesotho" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(lesotho)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==450 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Madagascar" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(madagascar)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==454 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Malawi" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(malawi)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==466 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Mali" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(mali)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==508 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Mozambique" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(mozambique)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==516 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Namibia" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(namibia)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==524 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Nepal" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(nepal)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==562 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Niger" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(niger)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==566 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Nigeria" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(nigeria)

*splitvallabels waves2, length(6)  
*catplot decoupling waves2 if country==586, ///
*percent(waves2) ///
*var1opts(label(labsize(small))) ///
*var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
*ytitle("Level of support", size(small)) ///
*title("Pakistan" ///
*, span size(medium)) ///
*intensity(25) ///
*asyvars stack ///
*bar(1, color(maroon) fintensity(inten80)) ///
*bar(2, color(maroon) fintensity(inten60)) ///
*bar(3, color(gray) fintensity(inten40)) ///
*bar(4, color(navy) fintensity(inten60)) ///
*legend(rows(2) stack size(small) ///
*order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
*3 "Supports gender equity/Not empowered in household" ///
*4 "Rejects gender equity/Not empowered in household") ///
*symplacement(center) ///
*title(Discordance , size(small))) name(pakistan)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==646 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Rwanda" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(rwanda)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==686 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Senegal" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(senegal)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==716 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Zimbabwe" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(zimbabwe)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==800 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Uganda" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(uganda)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==818 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Egypt" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(egypt)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==834 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Tanzania" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(tanzania)

splitvallabels waves2, length(6)  
catplot decoupling waves2 [iweight=popwt] if country==854 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
ytitle("Level of support", size(small)) ///
title("Burkina Faso" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(burkina)


splitvallabels waves2, length(6) 
catplot decoupling waves2 [iweight=popwt] if country==894 & model_s==1, ///
percent(waves2) ///
var1opts(label(labsize(small))) ///
var2opts(label(labsize(small)) relabel(`r(relabel)') ) ///
ytitle("Level of support", size(small)) ///
title("Zambia" ///
, span size(medium)) ///
intensity(25) ///
asyvars stack ///
bar(1, color(maroon) fintensity(inten80)) ///
bar(2, color(maroon) fintensity(inten60)) ///
bar(3, color(gray) fintensity(inten40)) ///
bar(4, color(navy) fintensity(inten60)) ///
legend(rows(2) stack size(small) ///
order(1 "Supports gender equity/Empowered in household" 2 "Rejects gender equity/Empowered in household" ///
3 "Supports gender equity/Not empowered in household" ///
4 "Rejects gender equity/Not empowered in household") ///
symplacement(center) ///
title(Discordance , size(small))) name(zambia)

grc1leg bangladesh benin burkina burundi cameroon congo egypt ethiopia ghana guinea india kenya lesotho madagascar malawi mali mozambique namibia nepal niger nigeria rwanda senegal tanzania uganda zambia zimbabwe, cols(7)
