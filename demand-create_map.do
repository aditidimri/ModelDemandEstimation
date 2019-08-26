*Source code:
*http://mseshasairam.wordpress.com/2013/03/13/how-to-draw-maps-in-stata/
*http://www.statsilk.com/maps/download-free-shapefile-maps


clear
set mem 1200M
set more off

**path
if c(username) == "" global path 	""




****************************************************************************
		************Prepare data***************
****************************************************************************

*******import price vector
local goodnames "cereal veg fuel clothing"
global goods "4"
di $goods

{

gen m=0
foreach good in `goodnames' {
replace m= m + v_`good'
}

**transform
tabstat m , stat(count mean median max min) 
gen lnm=ln(m)

local i=0
foreach good in `goodnames' {
local i=`i'+1
di `i'
gen p`i'= p_`good'
gen lnp`i'= lnp_`good'
}

****generate relative price terms wrt p1
gen p11=p1/p1
gen p21=p2/p1
gen p31=p3/p1
gen p41=p4/p1

***********************************************************

matrix stats=(1\2\3\4\5\6\7\8\9\10\11\12\13\14\15\16\17\18\19\20\21\22\23\24\25\26\27\28\29\30\31\32\33\34\35)
matrix rownames stats = 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35
matrix colnames stats = State_no
matrix list stats 


tabstat p21, by(state) save
return list
matrix c=r(Stat1)\r(Stat2)\r(Stat3)\r(Stat4)\r(Stat5)\r(Stat6)\r(Stat7)\r(Stat8)\r(Stat9)\r(Stat10)\r(Stat11)\r(Stat12)\r(Stat13)\r(Stat14)\r(Stat15)\r(Stat16)\r(Stat17)\r(Stat18)\r(Stat19)\r(Stat20)\r(Stat21)\r(Stat22)\ r(Stat23)\ r(Stat24)\ r(Stat25)\ r(Stat26)\ r(Stat27)\ r(Stat28)\ r(Stat29)\ r(Stat30)\ r(Stat31)\ r(Stat32)\ r(Stat33)\ r(Stat34)\ r(Stat35)
matrix colnames c = p_21
matrix stats= stats, c
matrix list stats

tabstat p31, by(state) save
return list
matrix c=r(Stat1)\r(Stat2)\r(Stat3)\r(Stat4)\r(Stat5)\r(Stat6)\r(Stat7)\r(Stat8)\r(Stat9)\r(Stat10)\r(Stat11)\r(Stat12)\r(Stat13)\r(Stat14)\r(Stat15)\r(Stat16)\r(Stat17)\r(Stat18)\r(Stat19)\r(Stat20)\r(Stat21)\r(Stat22)\ r(Stat23)\ r(Stat24)\ r(Stat25)\ r(Stat26)\ r(Stat27)\ r(Stat28)\ r(Stat29)\ r(Stat30)\ r(Stat31)\ r(Stat32)\ r(Stat33)\ r(Stat34)\ r(Stat35)
matrix colnames c = p_31
matrix stats= stats, c
matrix list stats

tabstat p41, by(state) save
return list
matrix c=r(Stat1)\r(Stat2)\r(Stat3)\r(Stat4)\r(Stat5)\r(Stat6)\r(Stat7)\r(Stat8)\r(Stat9)\r(Stat10)\r(Stat11)\r(Stat12)\r(Stat13)\r(Stat14)\r(Stat15)\r(Stat16)\r(Stat17)\r(Stat18)\r(Stat19)\r(Stat20)\r(Stat21)\r(Stat22)\ r(Stat23)\ r(Stat24)\ r(Stat25)\ r(Stat26)\ r(Stat27)\ r(Stat28)\ r(Stat29)\ r(Stat30)\ r(Stat31)\ r(Stat32)\ r(Stat33)\ r(Stat34)\ r(Stat35)
matrix colnames c = p_41
matrix stats= stats, c
matrix list stats

svmat stats, names(col) 
keep State_no p_21 p_31 p_41
keep if State_no !=.

format p_21 %9.3g
format p_31 %9.3g
format p_41 %9.3g

save prices.dta, replace

****************************************************************************
****************************************************************************
clear

use india_data.dta,clear

*combine datasets
merge 1:1 State_no using prices.dta 
tab _merge
drop _merge	
save map_data.dta,replace

*shp2dta using map, data(india_data) coor(india_coordinates) genid(id)

grmap p_21 using india_coordinates.dta, id(id)  legtitle(Relative Price- Vegetable)    legenda(on) legend(position(2)) legend(size(normal))
graph export p_21.pdf, replace

grmap p_31 using india_coordinates.dta, id(id)  legtitle(Relative Price- Fuel)    legenda(on) legend(position(2)) legend(size(normal))
graph export p_31.pdf, replace

grmap p_41 using india_coordinates.dta, id(id)  legtitle(Relative Price- Clothing)    legenda(on) legend(position(2)) legend(size(normal))
graph export p_41.pdf, replace







