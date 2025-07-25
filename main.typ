#import "package/lib.typ": NUEDC-report
#import "package/components/scripts.typ": *

#show: doc => NUEDC-report(
  year: "2024",
  problem-id: "A",
  problem-name: "信号处理实验",
  team-id: "2023211113",
  school: "某大学",
  team-members: ("张三", "李四"),
  teachers: "王老师",
  abstract: [这是实验报告的摘要部分，简要介绍实验目的、方法和结果。],
  keywords: ("实验", "信号处理", "数据分析"),
  // show-teachers: true,
  doc,
)

= 问题重述
定日镜场是由多台定日镜组成用于聚集太阳辐射到一个焦点的聚光场，是荒漠中造就能源利用奇迹的光之塔，其惊人的发电量使其拥有着不可替代的应用价值。

定日镜由配有转轴的底座和平面反射镜构成，转轴共有两个方向，分别是水平方向转轴和竖直方向转轴，前者用来控制反射镜的俯仰角，其轴线与地面保持水平，后者用来控制反射镜的方位角，轴线方向与地面保持垂直。两转轴的交叉点与平面镜的中心重合，该点距地面的高度为定日镜的安装高度。

由多个定日镜组成的阵列使得太阳光在镜场吸收塔上的集热器处得以汇集，镜场系统会自动利用转轴调整平面镜的朝向，使得经过太阳中心发出的光线经平面镜中心反射后可以指向集热器中心，但太阳光在严格意义上不是平行光，而是具有一定锥形角的锥形一束锥形光线，因此经平面镜反射后的光线也是锥形光线。

定日镜场的具体建设要求如下：

- 定日镜场建设位置的中心位于东经$98.5°$，北纬$39.4°$，海拔$3000m$处；
- 吸收塔的高度为$86m$，位于其顶部的集热器呈圆柱形，高$8m$，直径$8m$，中心高度$86m$；
- 以吸收塔为中心的$100m$圆形范围内不安装定日镜；
- 平面反射镜的上下两条边始终与地面平行，其之间的距离称为镜面高度，左右两边的距离称为镜面宽度，镜面宽度不小于镜面高度，宽度与高度要求在$2m$到$8m$之间；
- 定日镜的安装高度要求在$2m$至$6m$之间，且需要保证相邻两定日镜底座中心之间的距离需要比镜面宽度多$5m$以上；
- 整个镜场呈圆形，半径为$350m$

以镜场中心为原点，正东方向为$x$轴正向，正北方向为$y$轴正向，垂直地面向上为$z$轴正向建立镜场坐标系。

为简化计算，下述问题中所提到的所有“年均”指标的计算时间点均为每月21日的9:00，10:30，12:00，13:30，15:00，根据上述要求与信息，需要回答下列问题：

问题1：已知吸收塔位于该圆形定日镜场的中心，定日镜的尺寸均为$6m times 6m$，安装高度均为$4m$，且给定所有$1745$块定日镜中心的位置（以下简称定日镜位置）如附表所示，计算该定日镜场的每月21日平均的以及年平均的光学效率、输出热功率以及单位镜面面积的输出热功率；

问题2：按设计要求，定日镜场额定的年平均输出热功率为$48M W$，所有定日镜尺寸与安装高度均一致。确定以下参数：吸收塔的位置坐标、定日镜数目、各个定日镜的尺寸、安装高度和位置坐标，使得定日镜场在达到额定功率的条件下，单位镜面面积年平均输出热功率尽量大；

问题3：在定日镜尺寸可以不同，安装高度也可以不同的前提下，重新设计定日镜场的各参数：吸收塔的位置坐标、定日镜数目、各个定日镜的尺寸、安装高度和位置坐标，使得定日镜场在达到额定功率$48M W$的条件下，单位镜面面积年平均输出热功率尽量大。

= 模型假设与变量符号约定

== 模型假设

- 假定全年白天晴朗无云，即不会有云层遮挡太阳光线对输出热功率造成影响

- 由于镜面表面脏污、不平整所造成的反射损失，其对应的镜面反射率可取为定值$92%$

- 为节约计算成本，假定太阳光线为平行光线，不考虑锥形光线的情景

== 符号约定

// 定义所有符号和约定
#let all_symbols = (
  ([$alpha_s$], [太阳高度角，即太阳光与地平线的夹角]),
  ([$gamma_s$], [太阳方位角，即从正北方沿顺时针度量的太阳方位]),
  ([$omega$], [太阳时角，正午时角为0，上午为负值，下午为正值，每小时变化$15°$]),
  ([$"ST"$], [当地时间，以$24$小时计，换算为小时（如$3:30"PM" -> "ST" = 15.5$）]),
  ([$delta$], [太阳赤纬角，描述太阳直射点的维度]),
  ([$phi$], [纬度，北纬为正]),
  ([$H$], [海拔高度]),
  ([$S$], [太阳光线在镜场坐标系中的单位方向向量]),
  ([$"Day"$], [自春分之日（$3$月$21$日，作为第$0$天）起的天数]),
  (
    [$"DNI"$],
    [法向直接辐射辐照度，指地球上垂直于太阳光线的平面在单位面积、单位时间内接收到的太阳辐射能量（或单位面积的辐射功率）],
  ),
  (
    [$G_0$],
    [太阳常数，即在日地平均距离条件下，地球大气上界垂直于太阳光线的面上所接受的太阳辐射通量密度，也是单位面积的辐射功率，取为$1.366"kW"$/$m^2$],
  ),
  ([$eta$], [定日镜场的光学效率，即从太阳光照射到集热器吸收之间的能量利用率]),
  (
    [$eta_"sb"$],
    [阴影遮挡效率，由于定日镜之间以及吸收塔与定日镜之间的遮挡，造成理应辐射到定日镜、反射到集热器的能量不能充分利用，称此能量利用率为阴影遮挡效率],
  ),
  (
    [$eta_"cos"$],
    [余弦效率，由于太阳光与平面镜之间入射角的存在，导致$"DNI"$在与反射镜面的面积相乘的时候还需加乘入射角的余弦，称此余弦值为余弦效率],
  ),
  (
    [$eta_"at"$],
    [大气透射率，从定日镜反射到集热器接收之间光线受到大气散射的影响使得能量有所损失，对应的能量利用率即为大气透射率],
  ),
  (
    [$eta_"trunc"$],
    [集热器的截断效率，由于集热器面积有限，集热器不能将所有反射后的能量全部接收。对于集热器接收到的能量，反射前后均不受阴影影响的光线能量的利用率即为截断效率],
  ),
  ([$eta_"ref"$], [镜面反射率，受镜面脏污、不平整等因素造成的能量损失，其对应的能量利用率为镜面反射率]),
  ([$E_"field"$], [定日镜场输出的热功率]),
  ([$E_"mirror"$], [定日镜场单位面积镜面输出的热功率]),
  ([$overline(s)$], [指标$s$（如输出热功率、光学效率等）的年平均数值]),
  ([$A_i$], [第$i$面定日镜的采光面积，即平面镜的面积]),
  ([$a_i, a$], [第$i$面定日镜的平面镜宽度为$a_i$，均一致时为$a$]),
  ([$b_i, b$], [第$i$面定日镜的平面镜高度为$b_i$，均一致时为$b$]),
  ([$h_i, h$], [第$i$面定日镜的安装高度为$h_i$，均一致时为$h$]),
  ([$(x_i, y_i)$], [第$i$面定日镜的安装位置坐标]),
  ([$n$], [定日镜的总面数]),
  ([$d_"ij"$], [第$i$面定日镜与第$j$面定日镜之间的距离]),
  ([$d_i$], [第$i$面定日镜与吸收塔之间的距离]),
  ([$d_"HR"^(i)$], [第$i$面定日镜中心与集热器中心之间的距离]),
  ([$H_t$], [吸收塔高度，即集热器中心距地面的高度]),
  ([$(x_t, y_t)$], [吸收塔位置坐标]),
  ([$D_c$], [集热器直径]),
  ([$H_c$], [集热器高度]),
)

#split_table(all_symbols, splits: (7, 26, all_symbols.len()))

#block([*注*：所有长度单位面积均为$m$（米），海拔高度除外，其单位为$"km"$（千米）；角度使用弧度制单位$"rad"$；功率单位为$"kW"$（千瓦）])


= 模型建立

== 问题一

根据题目信息，吸收塔位置为$(x_t,y_t)=(0,0)$，定日镜的宽、高均为$a=b=6m$，安装高度均为$h=4m$，$n=1745$面定日镜的位置给定，要求计算定日镜场的光学效率$eta$，输出热功率$E_"field"$，单位镜面面积的输出热功率$E_"mirror"$的年平均值。

要得出某时间点定日镜场的光学效率$eta$，需要计算该时间点下每一块定日镜的阴影遮挡效率$eta_"sb"^"(i)"$、余弦效率$eta_"cos"^"(i)"$、大气透射率$eta_"at"^"(i)"$、集热器的截断效率$eta_"trunc"^"(i)"$、镜面反射率$eta_"ref"^"(i)"$，其之间满足如下关系：

$ eta = 1 / n sum_(i=1)^n eta_"sb"^"(i)" eta_"cos"^"(i)" eta_"at"^"(i)" eta_"trunc"^"(i)" eta_"ref"^"(i)" $

= 模板的基本使用

使用本模板之前，请阅读模板的使用说明文档。下面是本模板使用的基本样式：

#figure(
  block(inset: 8pt, stroke: 0.5pt, radius: 3pt)[

    ```typ
    #import "@preview/cumcm-muban:0.3.0": *
    #show: thmrules

    #show: cumcm.with(
      title: "论文的标题",
      problem-chosen: "A", // 选择的题目
      team-number: "1234", // 团队的编号
      college-name: "高校的名称",
      member: (
        A: "成员A",
        B: "成员B",
        C: "成员C",
      ),
      advisor: " ", // 指导教师
      date: datetime(year: 2023, month: 9, day: 8), // 日期

      cover-display: true, // 是否显示封面以及编号页

      abstract: [
        此处填写摘要内容
      ],

      keywords: ("关键字1", "关键字2", "关键字3"),
    )

    // 正文内容

    // 参考文献
    #bib(bibliography("refs.bib"))

    #appendix("附录标题", "附录内容")

    ```],
  caption: "基本样式",
) \

根据要求，电子版论文提交时需去掉封面和编号页。可以将 `cover-display` 设置为 false 来实现，即:

#block(inset: 8pt, stroke: 0.5pt, radius: 3pt, width: 100%)[```typ
  cover-display: false, // 是否显示封面与编号页
  ```]

这样就能实现了。

请确保你的论文内容符合要求，包括但不限于页数、格式、内容等。

下面给出写作与排版上的一些示例。

= 图片

在数学建模中，我们经常需要插入图片。Typst 支持的图片格式有 "png", "jepg", ""gif"", "svg"，其他类型的图片无法插入文档。我们可以通过改变参数 `width` 来改变图片的大小，详见#link("https://typst.app/docs/reference/visualize/image/")[typst/docs/image]。下面是一些图片插入的示例：

#figure(
  image("./figures/f1.jpg", width: 70%),
  caption: [
    单图示例
  ],
)

#figure(
  grid(
    columns: 2,
    gutter: 2pt,
    image("./figures/f2.jpg"), image("./figures/f1.jpg"),
    text("（a）venn 图", size: 10pt), text("（b）venn 图", size: 10pt),
  ),
  caption: [
    多图并排示例
  ],
)

= 表格

数学建模中表格有助于数据的整理与展示。Typst 支持使用 `table` 来插入表格，详见 #link("https://typst.app/docs/reference/model/table/")[typst/docs/table]。下面是一些表格插入的示例：

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [],
      [*Area*],
      [*Parameters*],
    ),

    [*Cylinder*],
    [$pi h (D^2 - d^2) / 4$],
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],

    [*Tetrahedron*], [$sqrt(2) / 12 a^3$], [$a$: edge length],
  ),
  caption: "表格示例",
)

#figure(
  table(
    columns: 4,
    align: center + horizon,
    stroke: none,
    table.hline(),
    table.header(
      table.cell(rowspan: 2, [*Names*]),
      table.cell(colspan: 2, [*Properties*]),
      table.hline(stroke: 0.6pt),
      table.cell(rowspan: 2, [*Creators*]),
      [*Type*],
      [*Size*],
    ),
    table.hline(stroke: 0.4pt),
    [Machine], [Steel], [5 $"cm"^3$], [John p& Kate],
    [Frog], [Animal], [6 $"cm"^3$], [Robert],
    [Frog], [Animal], [6 $"cm"^3$], [Robert],
    table.hline()
  ),
  caption: "三线表示例",
)

#figure(
  block(inset: 8pt, stroke: 0.5pt, radius: 3pt)[
    ```typ
    #figure(
      table(
        columns: 4,
        align: center + horizon,
        stroke: none,
        table.hline(),
        table.header(
          table.cell(rowspan: 2, [*Names*]),
          table.cell(colspan: 2,[*Properties*],),
          table.hline(stroke: 0.6pt),
          table.cell(rowspan: 2, [*Creators*]),
          [*Type*], [*Size*],

        ),
        table.hline(stroke: 0.4pt),
        [Machine], [Steel], [5 $"cm"^3$], [John p& Kate],
        [Frog], [Animal], [6 $"cm"^3$], [Robert],
        [Frog], [Animal], [6 $"cm"^3$], [Robert],
        table.hline()
      ),
      caption: "表格示例"
    )
    ```],
)

更多使用方法可以查看 #link("https://typst.app/docs/reference/model/table/")[typst/docs/table]。

= 公式

数学建模中，公式的使用是必不可少的。Typst 可以使用 Typst 原生语法插入公式，参考 #link("https://typst.app/docs/reference/math/")[typst/docs/math]。下面是一些公式插入的示例：

首先是行内公式，例如 $a^2 + b^2 = c^2$。行内公式使用 `$$` 包裹，公式和两端的 `$$` 之间没有空格。

其次是行间公式，例如：$ integral.triple_(Omega)\(frac(diff P, diff x) + frac(diff Q, diff y) + frac(diff R, diff z)\)d v = integral.surf_(Sigma)P d y d z + Q d z d x + R d x d y $ 式（1）是高斯公式。行间公式使用 `$$` 环境包裹，公式和两端的 `$$` 之间至少有一个空格。

公式内可以使用换行符 `\` 换行。若需要对齐，每行可以包含一个或多个对齐点 `&` 对其进行对齐。例如：
$
  sum_i b_i &= sum_i sum_(h,j != i) frac(sigma_(h j) (i), sigma_(h j)) \ &= sum_(h != j) frac(1, sigma_(h j)) sum_(i != h,j) sigma_(h j)(i)
$ `&` 是对齐的位置，`&` 可以有多个，但是每行的个数要相同。

矩阵输入示例：
$
  A = mat(
    a_(1 1), a_(1 2), ..., a_(1 n);
    a_(2 1), a_(2 2), ..., a_(2 n);
    dots.v, dots.v, dots.down, dots.v;
    a_(n 1), a_(n 2), ..., a_(n n);
  )
$ \


分段函数可以使用 `case` 环境：
$
  f\(x\)= cases(
    0 #h(1em) x text("为无理数,"),
    1 #h(1em) x text("为有理数.")
  )
$
假如要公式里面有个别文字，需要把这部分放在 text 环境里面,即 `text[文本内容]` 。

如果公式中有个别需要加粗的字母，可以使用 `bold()` 进行加粗。如，$alpha a bold(alpha a)$。

以上仅为一些简单的公式示例，更多的公式使用方法可以查看 #link("https://typst.app/docs/reference/math/")[typst/docs/math]

另外，如果需要插入 LaTeX 公式可以使用外部包 #link("https://typst.app/universe/package/mitex")[mitex]。


= 其他功能

== 脚注

利用 `#footnote(脚注内容)`可以生产脚注 #footnote("脚注例")

== 无序列表与有序列表

无序列表例：

#list(
  [元素1],
  [元素2],
  [...],
) \

有序列表例：

#enum(
  [元素1],
  [元素2],
  [...],
)

== 字体粗体与斜体

如果想强调部分内容,可以使用加粗的手段来实现。加粗字体可以用 `*需要加粗的内容*` 或 `#strong[需要加粗的内容]` 来实现。例如：*这是加粗的字体，This is bold fonts*。

中文字体没有斜体设计，但是英文字体有。_斜体 Italics_。

= 参考文献与引用

参考文献对于一篇正式的论文来说是必不可的，在建模中重要的参考文献当然应该列出。Typst 支持使用 BibTeX 来管理参考文献。在 `refs.bib` 文件中添加参考文献的信息，然后在正文中使用 `#cite(<引用的文献的 key>)` 来引用文献。例如：#cite(<xu_fakeshield_2025>)。最后通过 `#bib(bibliography("refs.bib"))` 来生成参考文献列表。

#bib(bibliography("refs.bib"))

#pagebreak()

#appendix(
  "线性规划 - Python 源程序",

  ```py
  import numpy as np
  from scipy.optimize import linprog

  c = np.array([2, 3, 1])
  A_up = np.array([[-1, -4, -2], [-3, -2, 0]])
  b_up = np.array([-8, -6])

  r = linprog(c, A_ub=A_up, b_ub=b_up, bounds=((0, None), (0, None), (0, None)))

  print(r)
  ```,
)

#appendix(
  "非线性规划 - Python 源程序",

  ```py
  from scipy import optimize as opt
  import numpy as np
  from scipy.optimize import minimize

  # 目标函数
  def objective(x):
  	return x[0] ** 2 + x[1] ** 2 + x[2] ** 2 + 8

  # 约束条件
  def constraint1(x):
  	return x[0] ** 2 - x[1] + x[2] ** 2  # 不等约束

  def constraint2(x):
  	return -(x[0] + x[1] ** 2 + x[2] ** 2 - 20)  # 不等约束

  def constraint3(x):
  	return -x[0] - x[1] ** 2 + 2

  def constraint4(x):
  	return x[1] + 2 * x[2] ** 2 - 3  # 不等约束

  # 边界约束
  b = (0.0, None)
  bnds = (b, b, b)

  con1 = {'type': 'ineq', 'fun': constraint1}
  con2 = {'type': 'ineq', 'fun': constraint2}
  con3 = {'type': 'eq', 'fun': constraint3}
  con4 = {'type': 'eq', 'fun': constraint4}
  cons = ([con1, con2, con3, con4])  # 4个约束条件
  x0 = np.array([0, 0, 0])
  # 计算
  solution = minimize(objective, x0, method='SLSQP',  bounds=bnds, constraints=cons)
  x = solution.x

  print('目标值: ' + str(objective(x)))
  print('答案为')
  print('x1 = ' + str(x[0]))
  print('x2 = ' + str(x[1]))
  ```,
)
