#import "components/cover.typ": generate-cover
  #set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  )
#generate-cover(
  year: "2024",
  problem-id: "A",
  problem-name: "信号处理实验",
  team-id: "2023211113",
  school: "某大学",
  team-members: ("张三", "李四"),
  teachers: ("王老师"),
)
#generate-cover(
  year: "2024",
  problem-id: "A",
  problem-name: "信号处理实验",
  team-id: "2023211113",
  school: "某大学",
  team-members: ("张三", "李四"),
  teachers: ("王老师"),
  show-teachers: false,
)
#import "components/abstract.typ": abstract-page
#abstract-page(
  body: [这是实验报告的摘要部分，简要介绍实验目的、方法和结果。],
  keywords: ("实验", "信号处理", "数据分析")
)