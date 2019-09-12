* 安装 neat 命令
github install haghish/neat, replace force
* 安装主题包
net install gr0070, from("http://www.stata-journal.com/software/sj17-3") replace force
* 安装 cuse 命令包
github install czxa/cuse, replace force
* finance 命令包
github install czxa/finance, replace force
* 安装 tidy 命令包
ssc install tidy, replace force
* 安装 superscatter 命令
net install superscatter, from("http://digital.cgdev.org/doc/stata/MO/Misc") replace force
* 安装 colorscheme
net install colorscheme.pkg, from("https://github.com/matthieugomez/stata-colorscheme/raw/master/") replace force
* 安装 flower
ssc install flower

* 设置 plotplain 主题为默认主题
set scheme plotplain, permanently

* 安装计算不平等度的命令包
net install egen_inequal.pkg, from("http://fmwww.bc.edu/RePEc/bocode/e/")
