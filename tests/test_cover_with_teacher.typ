#import "../components/cover.typ": generate-cover
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
  show-teachers: false,
)
