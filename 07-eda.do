cd ~/Documents/我的项目/stata4ds/
use diamonds, clear
histogram cut, freq barwidth(0.8)

gr export ./assets/histogramcut.png, replace

use diamonds, clear
contract cut
tw bar _freq cut
gr export ./assets/histogramcut2.png, replace

use diamonds, clear
hist carat, freq
gr export ./assets/histcarat.png, replace

hist carat, freq width(0.5)
gr export ./assets/histcarat2.png, replace

use diamonds, clear
keep if carat < 3
hist carat, width(0.1)
gr export ./assets/histsmallercarat.png, replace

use diamonds, clear
keep carat cut
colorscheme 5, palette(Paired)
tw ///
kdensity carat if cut == 1, lc("`r(color1)'") lp(solid) || ///
kdensity carat if cut == 2, lc("`r(color2)'") lp(solid) || ///
kdensity carat if cut == 3, lc("`r(color3)'") lp(solid) || ///
kdensity carat if cut == 4, lc("`r(color4)'") lp(solid) || ///
kdensity carat if cut == 5, lc("`r(color5)'") lp(solid) ||, ///
leg(order(1 "Fair" 2 "Good" 3 "Very Good" 4 "Premium" 5 "Ideal")) ///
xti("carat") yti("density") ylab(, format(%6.2f))

gr export ./assets/kdensitycarat.png, replace








