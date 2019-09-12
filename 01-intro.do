*=================================================================*
* 							  准备工作
*=================================================================*


* 清空内存
clear all
* 导入系统数据集 auto.dta
sysuse auto, clear
* 查看 price 变量详细的描述性统计
sum price, detail

*=================================================================*
* 							stata4ds 命令包
*=================================================================*

* 首先需要安装 github 命令，这个命令可以用来安装 GitHub 上的 Stata 命令。
net install github, from("https://haghish.github.io/github/")
* 然后使用 github 命令安装 stata4ds
github install stata4ds, replace

* cuse 数据库
github install czxa/cuse, replace
* 安装 tidy 命令包
ssc install tidy, replace
* 安装 superscatter 命令
net install superscatter, from(http://digital.cgdev.org/doc/stata/MO/Misc) replace


*=================================================================*
* 							运行 Stata 代码
*=================================================================*

display 1 + 2

*=================================================================*
* 								获取帮助
*=================================================================*
help clear
findit egen
search egen











