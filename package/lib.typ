// 设置页面格式
#import "@preview/cuti:0.3.0": show-cn-fakebold
#import "@preview/ctheorems:1.1.3": *

#import "components/cover.typ": generate-cover
#import "components/abstract.typ": abstract-page
#show: show-cn-fakebold
#show: thmrules
#let NUEDC-report(
  year: str,
  problem-id: str,
  problem-name: str,
  team-id: str,
  school: str,
  team-members: array,
  teachers: array,
  abstract: content,
  keywords: array,
  show-teachers: true,
  body,
) = {
  // 初始化相关页面、文本和段落样式
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 2.54cm, left: 3.18cm, right: 3.18cm),
  )
  // 设置字体
  set text(
    font: ("Times New Roman", "SimSun"),
    size: 12pt,
    weight: "regular",
    lang: "zh",
  )
  // 粗体
  show strong: it => {
    show regex("[\p{hani}\s]+"): set text(stroke: 0.02857em)
    it
  }
  // 正文首行缩进和行距设置
  set par(
    first-line-indent: (amount: 2em, all: true),
    leading:22pt,
    linebreaks: "optimized",
    justify: true,
  )
  // 图表标题样式
  show figure.caption: it => {
    text(font: ("Times New Roman", "FangSong"), size: 9pt)[#it.body]
  }
  show figure: it => [
    #v(4pt)
    #it
    #v(4pt)
  ]
  show figure.where(kind: raw): it => {
    set block(width: 100%, breakable: true)
    it
  }
  // 设置heading样式
  set heading(outlined: true, numbering: "1.1.1")
  // 一级标题样式
  show heading.where(level: 1): it => [
    // #counter(heading.where(level: 1)).step()
    #counter(heading.where(level: 2)).update(1)
    #counter(heading.where(level: 3)).update(1)
    #let num_1 = counter(heading.where(level: 1)).get().at(0)

    #align(center)[
      #v(12pt)
      #par(first-line-indent: (amount: 0em, all: true))[
        #text(font: ("Times New Roman", "SimHei"), size: 18pt, weight: "bold")[
          #if num_1 > 0 {
            numbering("1 ", num_1)
          }
          #it.body
        ]
      ]
      #v(12pt)
    ]

  ]
  // 二级标题样式
  show heading.where(level: 2): it => [
    // 计算二级标题的编号
    #counter(heading.where(level: 2)).step()
    #counter(heading.where(level: 3)).update(1)
    #let num_1 = counter(heading.where(level: 1)).get().at(0)
    #let num_2 = counter(heading.where(level: 2)).get().at(0)

    // 二级标题样式具体设置
    #align(left)[
      #v(2pt)
      #par(first-line-indent: (amount: 0em, all: true))[
        #text(font: ("Times New Roman", "SimHei"), size: 14pt, weight: "bold")[
          #numbering("1.1", num_1, num_2)
          #it.body
        ]
      ]
      #v(2pt)
    ]
  ]
  // 三级标题样式
  show heading.where(level: 3): it => [
    // 计算三级标题的编号
    #counter(heading.where(level: 3)).step()
    #let num_1 = counter(heading.where(level: 1)).get().at(0)
    #let num_2 = counter(heading.where(level: 2)).get().at(0)
    #let num_3 = counter(heading.where(level: 3)).get().at(0)

    // 三级标题样式具体设置
    #align(left)[
      #v(0.5pt)
      #par(first-line-indent: (amount: 0em, all: true))[
        #text(font: ("Times New Roman", "SimHei"), size: 12pt, weight: "bold")[
          #numbering("1.1.1", num_1, num_2 - 1, num_3)
          #it.body
        ]
      ]
      #v(0.5pt)
    ]
  ]
  // 代码标题样式
  show raw.where(block: true): block => [
    #pad(left: 2.5em)[
      #block
    ]
  ]

  // 正文声明
  generate-cover(
    year: year,
    problem-id: problem-id,
    problem-name: problem-name,
    team-id: team-id,
    school: school,
    team-members: team-members,
    teachers: teachers,
    show-teachers: show-teachers,
  )
  abstract-page(
    body: abstract,
    keywords: keywords,
  )
  outline()
  pagebreak()
  // 主体文档
  counter(page).update(1)
  set page(
    footer: context {
      if counter(page).get().first() > 0 [
        #align(right)[
          #text[#counter(page).get().first()]
        ]
      ]
    },
  )
  body
}
