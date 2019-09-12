*=================================================================*
* 							  准备工作
*=================================================================*

net install gr0070, from(http://www.stata-journal.com/software/sj17-3) replace
* 设定工作目录
cd ~/Documents/我的项目/stata4ds/
use mpg, clear
twoway scatter hwy displ
gr export ./assets/hwydispl.png, replace

sum 
count 
ds 
di wordcount("`r(varlist)'")

sum drv
sum drv, detail

sc hwy cyl
gr export ./assets/hwycyl.png, replace

sc class drv
encode class, gen(classnum) label(class)
encode drv, gen(drvnum) label(drv)
sc classnum drvnum
gr export ./assets/classnumdrvnum.png, replace

sc classnum drvnum, xlab(1 2 3, val) ylab(, val)
gr export ./assets/classnumdrvnum2.png, replace

tw ///
sc hwy displ if displ < 5 | hwy < 22 || ///
sc hwy displ if displ > 5 & hwy > 22, mc(red) ||, ///
leg(off)
gr export ./assets/hwydispl2.png, replace


* 查看 class 有哪些值
levelsof class
* 可以使用 local() 选项将这些值存储为一个 local 变量
levelsof class, local(class)
* 我们可以针对 class 的每一个值绘制一个图层：
tw ///
sc hwy displ if class == "2seater" || ///
sc hwy displ if class == "compact" || ///
sc hwy displ if class == "midsize" || ///
sc hwy displ if class == "minivan" || ///
sc hwy displ if class == "pickup" || ///
sc hwy displ if class == "subcompact" || ///
sc hwy displ if class == "suv" ||, ///
leg(order(1 "2seater" ///
		  2 "compact" ///
		  3 "midsize" ///
		  4 "minivan" ///
		  5 "pickup" ///
		  6 "subcompact" ///
		  7 "suv") title(class))
gr export ./assets/hwydispl3.png, replace

colorscheme 12, palette(Paired) display
return list

colorscheme 7, palette(Paired)
tw ///
sc hwy displ if class == "2seater", mc("`r(color1)'") ms(o) || ///
sc hwy displ if class == "compact", mc("`r(color2)'") ms(o) || ///
sc hwy displ if class == "midsize", mc("`r(color3)'") ms(o) || ///
sc hwy displ if class == "minivan", mc("`r(color4)'") ms(o) || ///
sc hwy displ if class == "pickup", mc("`r(color5)'") ms(o) || ///
sc hwy displ if class == "subcompact", mc("`r(color6)'") ms(o) || ///
sc hwy displ if class == "suv", mc("`r(color7)'") ms(o) ||, ///
leg(order(1 "2seater" ///
		  2 "compact" ///
		  3 "midsize" ///
		  4 "minivan" ///
		  5 "pickup" ///
		  6 "subcompact" ///
		  7 "suv") title(class))
gr export ./assets/hwydispl4.png, replace


colorscheme 7, palette(Set2)
tw ///
sc hwy displ if class == "2seater", mc("`r(color1)'") ms(o) msize(*1) || ///
sc hwy displ if class == "compact", mc("`r(color2)'") ms(o) msize(*1.5) || ///
sc hwy displ if class == "midsize", mc("`r(color3)'") ms(o) msize(*2) || ///
sc hwy displ if class == "minivan", mc("`r(color4)'") ms(o) msize(*2.5) || ///
sc hwy displ if class == "pickup", mc("`r(color5)'") ms(o) msize(*3) || ///
sc hwy displ if class == "subcompact", mc("`r(color6)'") ms(o) msize(*3.5) || ///
sc hwy displ if class == "suv", mc("`r(color7)'") ms(o) msize(*4) ||, ///
leg(order(1 "2seater" ///
		  2 "compact" ///
		  3 "midsize" ///
		  4 "minivan" ///
		  5 "pickup" ///
		  6 "subcompact" ///
		  7 "suv") title(class))
gr export ./assets/hwydispl5.png, replace


/* 左图 */
tw ///
sc hwy displ if class == "2seater" || ///
sc hwy displ if class == "compact" || ///
sc hwy displ if class == "midsize" || ///
sc hwy displ if class == "minivan" || ///
sc hwy displ if class == "pickup" || ///
sc hwy displ if class == "subcompact" || ///
sc hwy displ if class == "suv" ||, ///
leg(order(1 "2seater" ///
		  2 "compact" ///
		  3 "midsize" ///
		  4 "minivan" ///
		  5 "pickup" ///
		  6 "subcompact" ///
		  7 "suv") title(class)) name(p1) nodraw
/* 右图 */
tw ///
sc hwy displ if class == "2seater", mc(%90) ms(o) || ///
sc hwy displ if class == "compact", mc(%80) ms(o) || ///
sc hwy displ if class == "midsize", mc(%70) ms(o) || ///
sc hwy displ if class == "minivan", mc(%60) ms(o) || ///
sc hwy displ if class == "pickup", mc(%50) ms(o) || ///
sc hwy displ if class == "subcompact", mc(%40) ms(o) || ///
sc hwy displ if class == "suv", mc(%30) ms(o) ||, ///
leg(order(1 "2seater" ///
		  2 "compact" ///
		  3 "midsize" ///
		  4 "minivan" ///
		  5 "pickup" ///
		  6 "subcompact" ///
		  7 "suv") title(class)) name(p2) nodraw
/* 合并 */
gr combine p1 p2
gr export ./assets/hwydispl6.png, replace

/* 散点样式 */
palette symbolpalette
gr export ./assets/symbolpalette.png, replace

/* 分面 */
sc hwy displ, by(class)
gr export ./assets/hwydisplbyclass.png, replace

sc hwy displ, by(drv cyl)
gr export ./assets/hwydisplbyfrvcyl.png, replace

sc hwy displ, by(class, row(1))
gr export ./assets/hwydisplbyclass2.png, replace

sc hwy displ, by(class, note(""))
gr export ./assets/hwydisplbyclass3.png, replace

tw ///
sc hwy displ || ///
lpolyci hwy disp
gr export ./assets/lpolychwydisp.png, replace

tw ///
lpolyci hwy displ if drv == "4", lp(solid) || ///
lpolyci hwy displ if drv == "f", lp(dash) || ///
lpolyci hwy displ if drv == "r", lp(shortdash) ||, ///
leg(order(2 "4" 4 "f" 6 "r") title(drv))
gr export ./assets/lpolycibydrv.png, replace

palette linepalette
gr export ./assets/linepalette.png, replace

colorscheme 3, palette("Set2")
return list
tw ///
lpolyci hwy displ if drv == "4", lc("`r(color1)'") || ///
lpolyci hwy displ if drv == "f", lc("`r(color2)'") || ///
lpolyci hwy displ if drv == "r", lc("`r(color3)'") || ///
sc hwy displ if drv == "4", mc("`r(color1)'") || ///
sc hwy displ if drv == "f", mc("`r(color2)'") || ///
sc hwy displ if drv == "r", mc("`r(color3)'") ||, ///
leg(order(2 "4" 4 "f" 6 "r") title(drv))
gr export ./assets/lpolycibydrv2.png, replace

colorscheme 8, palette(Set2)
tw ///
sc hwy displ if class == "2seater", mc("`r(color1)'") ms(o) || ///
sc hwy displ if class == "compact", mc("`r(color2)'") ms(o) || ///
sc hwy displ if class == "midsize", mc("`r(color3)'") ms(o) || ///
sc hwy displ if class == "minivan", mc("`r(color4)'") ms(o) || ///
sc hwy displ if class == "pickup", mc("`r(color5)'") ms(o) || ///
sc hwy displ if class == "subcompact", mc("`r(color6)'") ms(o) || ///
sc hwy displ if class == "suv", mc("`r(color7)'") ms(o) || ///
lpolyci hwy displ, lc("`r(color8)'") ||, ///
leg(order(1 "2seater" ///
		  2 "compact" ///
		  3 "midsize" ///
		  4 "minivan" ///
		  5 "pickup" ///
		  6 "subcompact" ///
		  7 "suv") title(class))
gr export ./assets/lpolycihwydispl.png, replace

colorscheme 8, palette(Set2)
tw ///
sc hwy displ if class == "2seater", mc("`r(color1)'") ms(o) || ///
sc hwy displ if class == "compact", mc("`r(color2)'") ms(o) || ///
sc hwy displ if class == "midsize", mc("`r(color3)'") ms(o) || ///
sc hwy displ if class == "minivan", mc("`r(color4)'") ms(o) || ///
sc hwy displ if class == "pickup", mc("`r(color5)'") ms(o) || ///
sc hwy displ if class == "subcompact", mc("`r(color6)'") ms(o) || ///
sc hwy displ if class == "suv", mc("`r(color7)'") ms(o) || ///
lpolyci hwy displ if class == "subcompact", lc("`r(color8)'") ||, ///
leg(order(1 "2seater" ///
		  2 "compact" ///
		  3 "midsize" ///
		  4 "minivan" ///
		  5 "pickup" ///
		  6 "subcompact" ///
		  7 "suv") title(class))
gr export ./assets/lpolycihwydispl2.png, replace

use diamonds, clear
hist cut, barwidth(0.8) xlab(, val) freq
gr export ./assets/histcut.png, replace

contract cut
tw bar _freq cut, barwidth(0.8) xlab(, val)
gr export ./assets/barcut.png, replace

use diamonds, clear
hist cut, barwidth(0.8) xlab(, val)
gr export ./assets/histcut2.png, replace

use diamonds, clear
collapse 	(min) depthmin = depth ///
			(median) depthmedian = depth ///
			(max) depthmax = depth, by(cut)

tw ///
rspike depthmax depthmin cut, || ///
sc depthmedian cut, xlab(, val) ms(O) mc(black) ||, ///
leg(off)
gr export ./assets/depth3m.png, replace

use diamonds, clear
contract cut
colorscheme 5, palette(Set2)
tw ///
bar _freq cut if cut == 1, fc("`r(color1)'") barwidth(0.8) || ///
bar _freq cut if cut == 2, fc("`r(color2)'") barwidth(0.8) || ///
bar _freq cut if cut == 3, fc("`r(color3)'") barwidth(0.8) || ///
bar _freq cut if cut == 4, fc("`r(color4)'") barwidth(0.8) || ///
bar _freq cut if cut == 5, fc("`r(color5)'") ///
barwidth(0.8) xlab(, val) leg(off)
gr export ./assets/barcutmulticolor.png, replace

use diamonds, clear
contract cut
colorscheme 5, palette(Set1)
tw ///
bar _freq cut if cut == 1, lc("`r(color1)'") barwidth(0.8) || ///
bar _freq cut if cut == 2, lc("`r(color2)'") barwidth(0.8) || ///
bar _freq cut if cut == 3, lc("`r(color3)'") barwidth(0.8) || ///
bar _freq cut if cut == 4, lc("`r(color4)'") barwidth(0.8) || ///
bar _freq cut if cut == 5, lc("`r(color5)'") ///
barwidth(0.8) xlab(, val) leg(off)
gr export ./assets/barcutmulticolor2.png, replace

use diamonds, clear
colorscheme 8, palette(Paired)
gr bar, over(clarity) over(cut) ///
	stack asyvars yti(count) ///
	leg(ti(clarity)) ///
	bar(1, color("`r(color1)'")) ///
	bar(2, color("`r(color2)'")) ///
	bar(3, color("`r(color3)'")) ///
	bar(4, color("`r(color4)'")) ///
	bar(5, color("`r(color5)'")) ///
	bar(6, color("`r(color6)'")) ///
	bar(7, color("`r(color7)'")) ///
	bar(8, color("`r(color8)'"))
gr export ./assets/stackcutclarity.png, replace



sysuse auto, clear
tw ///
hist price if for || ///
hist price if !for
gr export ./assets/histautoprice.png, replace

tw ///
hist price if for, fc(red) || ///
hist price if !for, fc(green%50) ///
	leg(order(1 "进口车" 2 "国产车"))
gr export ./assets/histautoprice2.png, replace

tw ///
hist price if for, fc(red) lc(red) || ///
hist price if !for, color(none) lc(green) ///
	leg(order(1 "进口车" 2 "国产车"))
gr export ./assets/histautoprice3.png, replace


use diamonds, clear
gen id = _n
colorscheme 8, palette(Paired)
gr bar (count) id, over(clarity) over(cut) ///
	stack asyvars yti(count) ///
	leg(ti(clarity)) ///
	bar(1, color("`r(color1)'")) ///
	bar(2, color("`r(color2)'")) ///
	bar(3, color("`r(color3)'")) ///
	bar(4, color("`r(color4)'")) ///
	bar(5, color("`r(color5)'")) ///
	bar(6, color("`r(color6)'")) ///
	bar(7, color("`r(color7)'")) ///
	bar(8, color("`r(color8)'")) ///
	percent
gr export ./assets/percentcutclarity.png, replace

use diamonds, clear
gen id = _n
colorscheme 8, palette(Paired)
gr bar (count) id, over(clarity) over(cut) ///
	asyvars yti(count) ///
	leg(ti(clarity)) ///
	bar(1, color("`r(color1)'")) ///
	bar(2, color("`r(color2)'")) ///
	bar(3, color("`r(color3)'")) ///
	bar(4, color("`r(color4)'")) ///
	bar(5, color("`r(color5)'")) ///
	bar(6, color("`r(color6)'")) ///
	bar(7, color("`r(color7)'")) ///
	bar(8, color("`r(color8)'"))
gr export ./assets/dodgecutclarity.png, replace

use mpg, clear
sc hwy displ, name(p1, replace) ti(没有添加散点扰动)
sc hwy displ, name(p2, replace) jitter(3)  ti(添加了散点扰动)
gr combine p1 p2
gr export ./assets/scjitter.png, replace

sc hwy displ, mc(red%30)
gr export ./assets/scopc.png, replace

/* help flower
ssc install flower */
flower hwy displ
gr export ./assets/flower.png, replace

h tw sunflower
sunflower hwy displ
gr export ./assets/sunflower.png, replace


github install haghish/neat
use mpg, clear
neat hwy displ
sc hwy displ
gr export ./assets/neatscatter.png, replace

/* 坐标系调整 */
use mpg, clear
gr box hwy, over(class) ti("绘图命令：gr box hwy, over(class)") ///
	name(p1, replace)
gr hbox hwy, over(class)  ti("绘图命令：gr hbox hwy, over(class)") ///
	name(p2, replace)
gr combine p1 p2
gr export ./assets/boxcombine.png, replace


use mpg, clear
sc hwy displ, aspect(0.5)
gr export ./assets/aspscatter.png, replace

use diamonds, clear
contract cut
colorscheme 5, palette(Paired)
tw ///
bar _freq cut if cut == 1, horizontal fc("`r(color1)'") lc("`r(color1)'") || ///
bar _freq cut if cut == 2, horizontal fc("`r(color2)'") lc("`r(color2)'") || ///
bar _freq cut if cut == 3, horizontal fc("`r(color3)'") lc("`r(color3)'") || ///
bar _freq cut if cut == 4, horizontal fc("`r(color4)'") lc("`r(color4)'") || ///
bar _freq cut if cut == 5, horizontal fc("`r(color5)'") lc("`r(color5)'") ylab(, val) name(p1, replace) nodraw leg(off)
use diamonds, clear
colorscheme 5, palette(Paired)
gr pie, over(cut) ///
	pie(1, color("`r(color1)'")) ///
	pie(2, color("`r(color2)'")) ///
	pie(3, color("`r(color3)'")) ///
	pie(4, color("`r(color4)'")) ///
	pie(5, color("`r(color5)'")) ///
	name(p2, replace) leg(off) ///
	pl(1 name) ///
	pl(2 name) ///
	pl(3 name) ///
	pl(4 name) ///
	pl(5 name) nodraw
gr combine p1 p2
gr export ./assets/barpluspie.png, replace

qnorm depth, aspect(1) xlab(40(10)80) ylab(40(10)80)
gr export ./assets/qnorm.png, replace


