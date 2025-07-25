#import "@preview/cuti:0.3.0": show-cn-fakebold
#show: show-cn-fakebold
#let abstract-page(
  body: content,
  keywords: array,
) = {
  // 标题样式
  v(1.2cm)
  align(center)[
    #text(font: ("Times New Roman", "SimHei"), size: 22pt, weight: "bold")[摘要]
  ]
  // 正文样式
  v(1cm)
  text(font: ("Times New Roman", "FangSong"), size: 14pt)[#body]

  // 关键词样式
  v(1cm)
  let keyword_list = keywords.join("； ")
  align(left)[
    #text(font: ("Times New Roman", "FangSong"), size: 14pt)[*关键词：* #keyword_list]
  ]
  pagebreak()
}
