# stata4ds

> ⚠️Underwriting!

这是我最近正在写的一本开源书，写作思路是这样的，先按照 [R for Data Science](https://r4ds.had.co.nz/) 的组织结构写，中间再插入自己想加入的东西，然后全部写完之后再梳理梳理，所以现在这本书是没什么逻辑的，不要见怪。

这本书是模仿 [R for Data Science](https://r4ds.had.co.nz/) 一书的结构进行编排的。这本书的编写旨在帮助你学习如何使用 Stata 进行数据整理和建模。虽然这本书的名字是 《Stata for Data Science》，但是这本书的重点是如何使用 Stata 进行数据整理、分析和简单建模，这是因为本书的作者实际对数据科学一无所知。

在这本书中，你可以学习如何将数据导入 Stata、如何对数据进行清洗和转形、如何使用统计图表对数据进行展示（我向来不敢使用`可视化`这个词，因为我也觉得我对可视化一无所知）。除此之外，还有如何使用整理好的数据进行建模。

我的统计软件学习顺序是 Stata 到 R的。我第一次接触 [Stata](https://www.stata.com/) 是在 2016年我上大二的时候，那个学期我去蹭了[张宁老师](https://ec.jnu.edu.cn/news/view/id/4156)的计量经济学。Stata 并非我学习的第一门编程语言（我的第一门编程语言应该是Java，不过我并没有继续学下去），但却是我第一门认真学习的编程语言，或者更具体地说，第一门统计编程语言。在随后的两年时间里，我先后学习了 Stata 在计量经济学中的使用、Stata 数据处理、Stata 网页数据爬取以及Stata 图表绘制。除此之外，还学习了一些 Mata 方面的东西，尽管在 Stata 方面花费了如此之大的功夫，我依然感觉自己对 Stata 的掌握不够系统。因此写这本开源书有四个目的：

1. 学习 [bookdown](https://bookdown.org/) 包的使用，这个包可以非常方便的用于书籍排版；
2. 整理过去两年的 Stata 笔记；
3. 复习 [R for Data Science](https://r4ds.had.co.nz/) 一书。
4. 帮助我的好朋友们学习 Stata。

我的 Stata学习大致到大三下学期就结束了，之后我又努力地学习了一段时间的 R 和 Python。在比较熟练的掌握了 R 数据分析技能之后，我便很少再使用 Stata 了，但是我依然觉得 Stata 是一门非常优秀且强大的编程语言。在 Stata 的诸多优点之中，我尤其喜欢 Stata 的帮助文档，非常详细。

我用 Stata 完成了我大学除了毕业论文之外的所有论文，这些使用经验告诉我，Stata 是一门可以信赖的统计软件。

## 本书内容

由于本书是按照 *R for Data Science* 一书的结构组织的，因此本书的结构与之类似：

第一部分：探索。主要是介绍 Stata 的基本操作，比如如何安装和更新 Stata、如何导入 Stata 的系统数据集并进行简要的整理分析和画图。

第二部分：深入。本部分将会更加深入地介绍使用 Stata 处理数据的一些技巧。包括日期、字符串、数值变量的处理、数据长宽转换等。

第三部分：编程。由于作者对 mata 的了解几乎没有，所以这一部分的编程当然是指 ado 的编程，通过学习 ado 编程，你可以创建自己的 Stata 命令。在这部分还会介绍 Stata 中的 local 和 global 变量以及循环的使用。

第四部分：模型。由于本书的重点不在于计量经济学，因此这一部分仅以最简单的 OLS 模型为例介绍。

第五部分：汇报。Stata15 引入了一些新东西，例如 **putdocx**, 这个命令可以让你直接使用 Stata 创建 Word 文档。这可能有些类似于 RMarkdown。除此之外，我还会介绍一些用于在 Stata 工作流程中使用 Markdown 的外部命令。

## 阅读本书之前的准备工作

首先你需要在你的 Windows 上或者 Mac 上安装 Stata15，由于作者的电脑是 Mac 系统，所以本书的内容尚未在 Windows 上测试。如果你运行出错，请联系作者。

另外，我再向你推荐一个非常好用的代码编辑器：[**Sublime Text 3**](http://www.sublimetext.com/)，Stata 的安装和 Sublime Text3 的配置教程网上有很多，作者的个人网站上也有一些：[Stata安装与Sublime Text3配置教程](https://www.czxa.top/posts/59313/)，因此这里不再赘述。

为了方便本书的阅读，作者正在编写一个 Stata 的命令包，你可以运行下面的命令安装：

```stata 
* 首先需要安装 github 命令，这个命令可以用来安装 GitHub 上的 Stata 命令。
net install github, from("https://haghish.github.io/github/")
* 然后使用 github 命令安装 stata4ds
github install czxa/stata4ds, replace
```

这个命令包会随着本书的更新而更新。因此在学习本书前，请确保先更新 stata4ds 命令包。

## 目标读者

本书的目标读者是闲着没事干的人。

## 排版约定

在本书中，你会发现一些不同的文本样式，用以区别不同种类的信息，这里举例说明一些样式，以及它们的含义：

代码的输入和输出格式如下：

```stata 
* 导入系统数据集
clear all
sysuse auto, clear
*> (1978 Automobile Data)
```

`*` 开头的行为注释。`*> `开头的行为运行结果。

**新术语** 和 **重要的词** 用黑体表示。

## 下载示例代码

本书的代码开源在 GitHub 上，你可以从这里下载：[stata4ds](https://github.com/czxa/stata4ds)。

## 许可证

本书是一本开源书籍，使用 [Creative Commons Attribution-NonCommercial-NoDerivs 3.0](http://creativecommons.org/licenses/by-nc-nd/3.0/us/) 许可证。这意味着：

![](/assets/license.png)

如果你想支持作者的工作，欢迎前往[作者的网站](https://www.czxa.top)对作者进行打赏。你的支持将会促使作者更加及时地更新这本书。

## 读者反馈

欢迎读者的反馈。你对本书有任何想法，喜欢或者不喜欢什么，请告知我。你可以在下面的评论区里评论，如果你阅读的是 PDF 版本，你可以前往 [Stata for Data Science](https://wwww.czxa.top/stata4ds) 创建 issues。
