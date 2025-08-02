# 全国大学生电子设计竞赛 Typst 模板
⚠️本模板是基于`typst 0.13.1 (8ace67d9)`制作的，`typst`在`0.13.0`中引入了破环性变更，因此注意更新您的typst！
## 简介
---
这是一个为全国大学生电子设计竞赛（及其他类似科创竞赛）设计的通用 `Typst` 报告模板。

它提供了一个结构清晰、格式规范的框架，旨在帮助参赛者摆脱繁杂的格式调整，专注于报告内容的撰写，从而快速、高效地完成高质量的设计报告。

## 文件结构
---
```text
.
├── figures
│   ├── figures/f1.jpg  # Example Picture 1
│   └── figures/f2.jpg  # Example Picture 1
├── main.typ            # Entry Point, 包含一些使用样例代码
├── package             # Core Package 包含样例模板 
│   ├── package/assets
│   │   └── package/assets/logo.png         # 电赛LOGO
│   ├── package/components
│   │   ├── package/components/abstract.typ # 摘要页面
│   │   ├── package/components/cover.typ    # 封面
│   │   └── package/components/scripts.typ  # 自定义函数
│   └── package/lib.typ                     # template
├── readme.md
├── refs.bib                                # main.typ中的引用文献
└── tests                                   # 测试代码
    ├── tests/test_abstract.typ
    ├── tests/test_cover_without_teacher.typ
    └── tests/test_cover_with_teacher.typ
```


本模板主要参考了以下两个项目，都是非常棒的，在这里也推荐一下：

1. [电子设计竞赛 LaTeX 报告模板](https://github.com/SandOcean-ovo/Template-for-Electrical-Competition-Report) 本模板的主要样式就是按照这个LaTeX模板生成的pdf制作的

2. [全国大学生数学建模竞赛 Typst 模板](https://github.com/a-kkiri/CUMCM-typst-template)本模板的大部分自定义函数来自这个模板，值得注意的是，其官方仓库目前仅支持`Typst version<0.13`，但是在`pr`中存在解决方案。




>马上就是2025年的全国大学生电子设计竞赛了，在~~认真~~准备题目之后，我们也准备提前准备相关报告模板，由于我们都对`LaTeX`不是特别熟悉，因此我编写了这个模板，希望看到这里的你也能用的开心，电赛进国！
>
> -- April 写于2025/07/25 (≧∀≦)ゞ

> 今天给报告写完了，就先推到仓库上吧～
>
> 做的真的很烂……，提高做不出来哇！！！
>
> -- April 写于2025/08/01 (◞‸◟)

> 包一轮游的，希望能有个省三
>
> -- April 写于2025/08/02 ………………

