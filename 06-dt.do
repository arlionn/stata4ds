cd ~/Documents/我的项目/stata4ds/

use nycflights13, clear
des

clear all
set obs 10
gen x = .
gen y = ""
gen a = missing(x)
gen b = missing(y)
list

clear all
set obs 3
gen a = .
replace a = 1 in 1
replace a = 3 in 3
keep if missing(a) | a > 1
list

use nycflights13, clear
order year month day
gsort dep_time
gsort -dep_time

use nycflights13, clear
keep a*

use nycflights13, clear
keep *y

use nycflights13, clear
keep *a*

use nycflights13, clear
gen tempdate = string(year) + "-" + string(month) + "-" + string(day)
gen date = date(tempdate, "YMD")
order date
format date %tdCY-N-D
drop tempdate


use nycflights13, clear
keep year - day *delay distance air_time
gen gain = dep_delay - arr_delay
gen speed = distance / air_time * 60
gen hours = air_time / 60
gen gain_per_hour = gain / hours


use nycflights13, clear
keep dep_time
gen hour = int(dep_time / 100)
gen minute = mod(dep_time, 100)


use nycflights13, clear
gen tempdate = string(year) + "-" + string(month) + "-" + string(day)
gen date = date(tempdate, "YMD")
order date
format date %tdCY-N-D
drop tempdate

duplicates drop date, force
tsset date
keep date dep_time
gen lag = l.dep_time
gen lead = f.dep_time


clear all
set obs 10
gen x = _n
gen cumsum = sum(x)
gen cummean = sum(x) / x
list

clear all
set obs 6
gen x = 2
replace x = 1 in 1
replace x = . in 4
replace x = 3 in 5
replace x = 4 in 6
egen rank1 = rank(x), field
egen rank2 = rank(x), track
egen rank3 = rank(x), unique
list

use nycflights13, clear
sum dep_delay

gen tempdate = string(year) + "-" + string(month) + "-" + string(day)
gen date = date(tempdate, "YMD")
order date
format date %tdCY-N-D
drop tempdate

tabstat dep_delay, by(date) stat(mean) nototal save


* ssc install sumup
use nycflights13, clear
sumup dep_delay, by(year month day) statistics(mean) save(temp.dta) replace
use temp, clear
list in 1/10

use nycflights13, clear
bysort dest: gen count = _N 
bysort dest: egen dist = mean(dist)
bysort dest: egen delay = mean(arr_delay)
keep if count > 20 & dest != "HNL"
duplicates drop dest, force

tw ///
sc delay dist [fw = count], msize(*0.3) || ///
lpoly delay dist, lc(blue) bw(300) ||, ///
leg(pos(6) order(1 "局部多项式拟合")) ///
note(散点半径表示该天的航班数)

gr export ./assets/delaydist.png, replace

use nycflights13, clear
drop if missing(dep_delay) | missing(arr_delay)
bysort year month day: egen mean = mean(dep_delay)
duplicates drop year month day, force
list year month day mean in 1/5

use nycflights13, clear
drop if missing(dep_delay) | missing(arr_delay)
bysort tailnum: egen delay = mean(arr_delay)
duplicates drop tailnum, force
kdensity delay

gr export ./assets/kdensitydelay.png, replace

use nycflights13, clear
drop if missing(dep_delay) | missing(arr_delay)
bysort tailnum: egen delay = mean(arr_delay)
bysort tailnum: gen n = _N
duplicates drop tailnum, force
tw sc delay n, mc(%30)

gr export ./assets/scdelayn.png, replace


use nycflights13, clear
drop if missing(dep_delay) | missing(arr_delay)
bysort tailnum: egen delay = mean(arr_delay)
bysort tailnum: gen n = _N
duplicates drop tailnum, force
tw sc delay n if n > 25, mc(%30)

gr export ./assets/scdelayn2.png, replace

use batting, clear
bysort playerID: egen temp1 = sum(H)
bysort playerID: egen temp2 = sum(AB)
gen ba = temp1 / temp2
bysort playerID: egen ab = sum(AB)
drop temp*
keep if ab > 100
duplicates drop playerID, force
tw ///
sc ba ab, mc(%30) || ///
lpoly ba ab, lc(blue) ||, ///
leg(pos(6) rows(1))

gr export ./assets/scbaab.png, replace





