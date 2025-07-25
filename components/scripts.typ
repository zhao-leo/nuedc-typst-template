#import "@preview/ctheorems:1.1.3": *
#let bib(bibliography-file) = {
  show bibliography: set text(10.5pt)
  set bibliography(title: "参考文献", style: "gb-7714-2015-numeric")
  bibliography-file
  v(12pt)
}

#let appendix-num = counter("appendix")

#let appendix(title, body) = {
  appendix-num.step()
  table(
    fill: (_, row) => if row == 0 or row == 1 { luma(200) } else { none },
    rows: 3,
    columns: 1fr,
    text[*附录 #context appendix-num.display()：*],
    text[*#title*],
    body
  )
}

#let split_table(
  symbols,
  caption: "符号约定表",
  splits: (), // 自定义切分点
  add_pagebreak: true, // 是否在表格之间添加分页符
) = {
  // 如果没有指定切分点，则将整个表格作为一个部分
  let split_points = if splits.len() == 0 { (symbols.len(),) } else { splits }

  // 验证切分点是否有效
  assert(
    split_points.all(p => p > 0 and p <= symbols.len()),
    message: "切分点必须在1到符号数量之间",
  )

  let parts = split_points.len()
  let start_idx = 0

  for (i, end_idx) in split_points.enumerate() {
    // 获取当前部分的符号
    let current_symbols = symbols.slice(start_idx, end_idx)

    // 构建当前部分的表格
    figure(
      table(
        columns: 2,
        align: (left, left),
        stroke: none,
        inset: 5pt,
        table.hline(),
        table.header(
          [*符号*],
          [*约定*],
        ),
        table.hline(stroke: 0.4pt),
        ..current_symbols.flatten(),
        table.hline()
      ),
      caption: if parts > 1 {
        caption + " (续表 " + str(i + 1) + "/" + str(parts) + ")"
      } else {
        caption
      },
    )

    // 更新下一部分的起始索引
    start_idx = end_idx

    // 如果不是最后一个部分且需要分页，添加分页符
    if i < parts - 1 and add_pagebreak {
      pagebreak()
    }
  }
}

// 使用示例

// 示例1: 不切分表格
// #split_table(all_symbols)

// 示例2: 将表格分成3部分，在第10行和第20行处切分
// #split_table(all_symbols, splits: (14, all_symbols.len()))

// 示例3: 按照自然分组切分，不添加分页符
// #split_table(
//   all_symbols,
//   splits: (12, 20, all_symbols.len()),
//   add_pagebreak: false
// )
