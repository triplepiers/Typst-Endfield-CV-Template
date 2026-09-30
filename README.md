# Endfield CV, but Typst!

一份[终末地](https://endfield.hypergryph.com)风味的中文简历模板（无照片）

## Preview

![CV_Preview](./assets/preview.png)

## Usage
> Typst Web 编辑器项目：[EndField_CV_Template](https://typst.app/project/wCng6z8cmIPPmmClhkoQ4r)

- 文件结构

  ```
  .
  ├── assets        # 图片资源
  ├── fonts         # 用到的字体
  ├── template.typ  # 模板定义
  └── main.typ      # <= 这里写正文
  ```

- 本地编译：输出为 `main.pdf`

  ```bash
  typst compile --font-path ./fonts main.typ
  ```

## Components

### Header

- 姓名 + Tag：很呆，但可以自己定义分隔符

  ```
  #name_tags(
    name: "管理员·Endmin",
    tags: "战略指挥 / 集成工业 / 区域开拓",
  )
  ```

- 联系方式：目前支持 手机号（phone）、邮箱（email）、GitHub、Bilibili

  ```
  #info(
    phone: "10010101001", 
    email: "endministrator@endfield.industries",
    github: "triplepiers",
  )
  ```
  
  - 手机号会格式化成 `(+86) xxx xxxx xxx`
  - GitHub <u>只需要填用户名</u>


### Section

- 标题：自动编号，需传入 "中文 - 英文标题"

  ```
  #section("培养与研究背景", "EDUCATION / RESEARCH")
  ```

- 内容：<u>每段经历</u> 需要单独的 entry，需传入 "岗位名称 - 公司/概述 - 时间"

  ```
  #entry(
    "协议源石技术与工业系统",
    "早期研究经历 · 协议技术 / 自动化工业",
    "早期经历"
  )[
    - *研究方向：* 长期参与协议源石相关技术研究，具备协议设备、能源系统、自动化工业及异常环境技术的综合知识基础。
    - *技术能力：* 熟悉协议核心部署、工业设施规划与资源生产流程，能够将研究成果转化为实际工程方案，并在复杂环境中完成快速部署。
  ]
  ```

- （可选）手动分割线：是虚线、上下留白可以自己调

  ```
  #v(0.2em)
  #line(length: 100%, stroke: (dash: (5pt, 2pt, 1pt, 2pt)))
  #v(0.2em)
  ```

- （可选）技能列表：两栏、详情右对齐，需传入 "技能标签 - [概述]"

  ```
  #skill-list((
    (
      label: "TECHNOLOGY",
      content: [协议源石技术 · 集成工业 · 自动化生产 · 能源与物流系统],
    ),
    ...
  ))
  ```

### Footer (保密等级标识)

```
#footer(access-level: 5)
```

- 支持通过 `access-level` 参数（1~5）定义保密等级（影响方块数量）

- 注意
  
  - 参与整体文档流定位（不是固定在右下角的绝对定位）

  - 每一页得手动添加（是的，很呆）

