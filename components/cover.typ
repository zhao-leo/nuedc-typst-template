#import "@preview/cuti:0.3.0": show-cn-fakebold
#show: show-cn-fakebold
#let generate-cover(
  year: str,
  problem-id: str,
  problem-name: str,
  team-id: str,
  school: str,
  team-members: array,
  teachers: array,
  show-teachers: true,
) = {
  // 封面页
  align(center)[
    #v(2cm)
    // 第一行：学年学期
    #text(size: 24pt, font: "STZhongsong", weight: "bold")[#year 年全国大学生电子设计竞赛]
    #v(1.2cm)
    // 第二行：实验报告标题
    #text(size: 24pt, font: "STZhongsong", weight: "bold")[#problem-id 题：#problem-name]
    #v(0.5cm)

    #text(size: 15pt, font: "STZhongsong")[设计报告]
    #v(2cm)

    // Logo
    #image("../assets/logo.png", width: 40%)
    #v(3cm)


    // 信息表格
    #let info-row(label, content) = {
      grid(
        columns: (auto, auto),
        align(right)[
          #text(font: "STSong", size: 14pt, weight: "bold")[*#label*]
        ],
        [
          #box(width: 180pt)[
            #box(width: 180pt)[
              #place(dx: 0pt, dy: 14pt)[
                #line(length: 180pt)
              ]
              #align(center)[
                #text(font: "STSong", size: 14pt)[#content]
              ]
            ]
          ]
        ],
      )
    }

    #info-row("参赛队号：", team-id)
    #info-row("参赛学校：", school)
    #let flag = 0;
    #for member in team-members {
      if flag == 0 {
        info-row("参赛队员：", member)
        flag = 1
      } else {
        info-row("　　　　  ", member) // 空标签行
      }
    }
    #if show-teachers {
      let flag = 0
      for member in team-members {
        if flag == 0 {
          info-row("指导教师：", member)
          flag = 1
        } else {
          info-row("　　　　  ", member) // 空标签行
        }
      }
    }


    // 添加间距
    #v(1cm)

    // 生成时间信息
    #text(size: 15pt, font: "STZhongsong")[#datetime.today().display("[year]年[month]月[day]日")]
  ]
  pagebreak()
}
