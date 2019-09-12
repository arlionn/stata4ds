cd ~/Documents/我的项目/stata4ds/

di 1 / 200 * 30
di (59 + 73 + 2) / 3
di sin(c(pi) / 2)

use mpg, clear
* 查看当前日期
di c(current_date)
* 查看当前时间
di c(current_time)
* 查看 PLUS 文件夹的位置
di c(sysdir_plus)
* 查看当前工作目录的位置
di c(pwd)
* 查看当前数据集的观测值个数
di c(N)
* 查看当前数据集的变量个数
di c(k)
* 查看当前数据集的文件路径
di c(filename)
* 查看当前绘图主题
di c(scheme)
* 查看小写字母表
di c(alpha)
* 查看大写字母表
di c(ALPHA)
* 查看简写月份表
di c(Mons)
* 查看全称月份表
di c(Months)
* 查看简写星期表
di c(Wdays)
* 查看全称星期表
di c(Weekdays)

local Aa = "Aa"
local alphanum = wordcount("`c(alpha)'")
forval i = 1/`alphanum'{
	local temp = word("`c(ALPHA)'", `i') + word("`c(alpha)'", `i')
	local Aa = "`Aa' `temp'"
}
di "`Aa'"
*> Aa Aa Bb Cc Dd Ee Ff Gg Hh Ii Jj Kk Ll Mm Nn Oo Pp Qq Rr Ss Tt Uu Vv Ww Xx Yy Zz

local x = 3 * 4
di `x'

global x = 3 * 4
di $x

clear all
set obs 10
gen a = _n
egen b = fill(1 2 3)
egen c = seq(), from(1) to(10)
list
*>    +--------------+
*>    |  a    b    c |
*>    |--------------|
*> 1. |  1    1    1 |
*> 2. |  2    2    2 |
*> 3. |  3    3    3 |
*> 4. |  4    4    4 |
*> 5. |  5    5    5 |
*>    |--------------|
*> 6. |  6    6    6 |
*> 7. |  7    7    7 |
*> 8. |  8    8    8 |
*> 9. |  9    9    9 |
*>10. | 10   10   10 |
*>    +--------------+

clear all
set obs 5
egen a = fill(1 3.25)
list a
*>    +------+
*>    |    a |
*>    |------|
*> 1. |    1 |
*> 2. | 3.25 |
*> 3. |  5.5 |
*> 4. | 7.75 |
*> 5. |   10 |
*>    +------+

cuse fincome, clear web
save fincome, replace
tostring fid, gen(provcd)
replace provcd = substr(provcd, 1, 2)
destring provcd, replace 
list in 1/10
*>    +--------------------------------+
*>    |    fid   fnum   year   fincome |
*>    |--------------------------------|
*> 1. | 110003      3   2012    100000 |
*> 2. | 110006      3   2012     77180 |
*> 3. | 110009      7   2012     98200 |
*> 4. | 110011      5   2012     76000 |
*> 5. | 110013      3   2012    116000 |
*>    |--------------------------------|
*> 6. | 110015      3   2012     30000 |
*> 7. | 110020      6   2012     92000 |
*> 8. | 110021      2   2012     64800 |
*> 9. | 110022      4   2012    130000 |
*>10. | 110023      2   2012    127640 |
*>    +--------------------------------+

egen rmd = inequal(fincome), index(rmd) weight(fnum) by(provcd)
egen cov = inequal(fincome), index(cov) weight(fnum) by(provcd)
egen sdl = inequal(fincome), index(sdl) weight(fnum) by(provcd)
egen mehran = inequal(fincome), index(mehran) weight(fnum) by(provcd)
egen piesch = inequal(fincome), index(piesch) weight(fnum) by(provcd)
egen kakwani = inequal(fincome), index(kakwani) weight(fnum) by(provcd)
egen theil = inequal(fincome), index(theil) weight(fnum) by(provcd)
egen mld = inequal(fincome), index(mld) weight(fnum) by(provcd)
egen entropy = inequal(fincome), index(entropy) weight(fnum) by(provcd)
egen half = inequal(fincome), index(half) weight(fnum) by(provcd)
egen gini = inequal(fincome), index(gini) weight(fnum) by(provcd)

duplicates drop provcd, force
keep provcd rmd-gini












