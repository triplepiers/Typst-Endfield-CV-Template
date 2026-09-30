// Color Theme
#let ink = rgb("111111")
#let paper = rgb("FCFBF9")
#let muted = rgb("707070")
#let line-gray = rgb("D8D8D5")
#let yellow = rgb("FFF500")
#let cyan = rgb("00D8C0")
#let magenta = rgb("F33DC5")
#let red = rgb("FF3B30")
#let yellow-mid = rgb("FFF86A")
#let yellow-pale = rgb("FFFBB8")
#let cyan-mid = rgb("65E6DA")
#let cyan-pale = rgb("B8F4EE")
#let magenta-mid = rgb("F781D9")
#let magenta-pale = rgb("FCC4ED")
#let red-mid = rgb("FF857D")
#let red-pale = rgb("FFC3BF")

// Icons
#import "@preview/fontawesome:0.6.2": *
#let github-icon = box(fa-icon("github", fill: ink))
#let gitlab-icon = box(fa-icon("gitlab", fill: ink))
#let phone-icon = box(fa-icon("square-phone", fill: ink))
#let email-icon = box(fa-icon("envelope", solid: true, fill: ink))
#let bilibili-icon = box(fa-icon("bilibili", fill:ink))

#let format-phone(phone) = {
  let digits = phone.replace(" ", "")
  "(+86) " + digits.slice(0, 3) + " " + digits.slice(3, 7) + " " + digits.slice(7, 11)
}

#let phone_item(phone) = if phone != none {
  box[
      #phone-icon
      #h(3pt)
      #format-phone(phone)
    ]
} else { none }

#let email_item(email) = if email != none {
    box[
      #email-icon
      #h(3pt)
      #link("mailto:" + email)[#email]
    ]
} else { none } 

#let github_item(github) = if github != none { 
  box[
    #github-icon 
    #h(3pt)
    #link("https://github.com/" + github)[#github]
  ]
} else { none }

#let bilibili_item(bilibili) = if bilibili != none { 
  box[
    #bilibili-icon 
    #box[#bilibili]
  ] 
} else { none } 

#let info(
  phone: none,
  email: none,
  github: none,
  bilibili: none
) = {
  set text(size: 8pt)
  
  let items = (
    phone_item(phone),
    email_item(email),
    github_item(github),
    bilibili_item(bilibili),
  ).filter(x => x != none)

  block(width: 100%, inset: (left: 2pt))[
    #for (i, item) in items.enumerate() {
      if i > 0 {
        h(5pt)
        [·]
        h(5pt)
      }
      item
    }
  ]
}

// Fonts
#let cjk = "HarmonyOS Sans SC"
#let body-font = ("Gilroy", "HarmonyOS Sans SC")
#let display = ("Novecento sans wide", "HarmonyOS Sans SC")
#let technical = ("Novecento sans wide", "HarmonyOS Sans SC")

#let resume(body) = {
  set document(title: "Endfield_CV")

  set page(
    paper: "a4",
    margin: (
      top: 15mm,
      bottom: 15mm,
      left: 16mm,
      right: 16mm,
    ),
    fill: paper,
    background: align(top + right)[
      #image(
        "assets/contour.png",
        width: 122mm,
        height: 64mm,
        fit: "cover",
      )]
  )

  set text(
    font: body-font,
    lang: "zh",
    region: "cn",
    size: 9.2pt,
    weight: 500,
    fill: ink,
  )

  set par(
    leading: 0.78em,
    justify: false,
  )

  body
}

#let micro(body) = text(font: technical, size: 6.6pt, weight: 500, fill: muted, tracking: 0.09em, body)

#let tint-row(colors) = grid(
  columns: (7pt, 5pt, 4pt),
  column-gutter: 1pt,
  ..colors.map(color => box(fill: color, width: 100%, height: 5pt)),
)

#let print-test() = grid(
  columns: (auto,),
  rows: (5pt, 5pt, 5pt, 5pt),
  row-gutter: 1pt,
  tint-row((yellow, yellow-mid, yellow-pale)),
  tint-row((magenta, magenta-mid, magenta-pale)),
  tint-row((cyan, cyan-mid, cyan-pale)),
  tint-row((red, red-mid, red-pale)),
)

// 自动编号
#let section-counter = counter("section")
#let section(title, english) = {
  section-counter.step()

  context {
    let index = section-counter.get().first()
    let index-text = if index < 10 {
      "0" + str(index)
    } else {
      str(index)
    }

    block(above: 9pt, below: 7pt)[
      #grid(
        columns: (1fr,),
        rows: (auto, 0.8pt),
        row-gutter: 3pt,

        grid(
          columns: (28pt, auto, auto, 1fr),
          column-gutter: 6pt,

          // Index
          box(
            fill: yellow,
            width: 28pt,
            height: 17pt,
          )[
            #align(center + horizon)[
              #text(
                font: technical,
                size: 10pt,
                weight: 800,
                tracking: 0.06em,
                index-text,
              )
            ]
          ],

          // 中文标题
          box(
            fill: ink,
            height: 17pt,
            inset: (x: 8pt),
          )[
            #align(center + horizon)[
              #text(
                font: cjk,
                size: 10.5pt,
                weight: 700,
                fill: paper,
                title,
              )
            ]
          ],

          // 英文标题
          box(height: 17pt)[
            #align(left + horizon)[
              #micro(english)
            ]
          ],

          // 右侧装饰
          align(right + horizon)[
            #box(width: 96pt, height: 17pt, clip: true)[
              #image(
                "assets/divider.svg",
                width: 96pt,
                height: 17pt,
                fit: "cover",
              )
            ]
          ],
        ),

        box(fill: ink, width: 100%, height: 0.8pt),
      )
    ]
  }
}


#let entry(title, meta, date, body) = block(below: 12pt)[
  #grid(
    columns: (1fr, auto),
    column-gutter: 10pt,
    [#text(weight: 700, title) #h(6pt) #text(size: 7.6pt, weight: 500, fill: muted, meta)],
    text(font: technical, size: 7.2pt, weight: 500, fill: muted, tracking: 0.025em, date),
  )
  #v(1.5pt)
  #text(size: 8.8pt, body)
]

#let name_tags(
  name: "",
  tags: "",
) = {
  grid(
    columns: (auto, auto, 1fr, auto),
    column-gutter: 10pt,
    align: bottom,

    text(
      font: cjk,
      size: 28pt,
      weight: 700,
      tracking: -0.02em,
    )[#name],

    box(
      fill: yellow,
      inset: (x: 7pt, y: 2.5pt),
    )[
      #text(size: 9.1pt, weight: 700)[#tags]
    ],

    [],
    print-test(),
  )
}

#let footer(
  enabled: true,
  access-level: 5,
  label: "ENDFIELD INDUSTRIES // PERSONNEL ARCHIVE",
) = {
  if enabled {
    let level = calc.clamp(access-level, 1, 5)
    let access = "■" * level + "□" * (5 - level)

    align(right)[
      #text(
        font: cjk,
        size: 8pt,
        fill: rgb("#777777"),
      )[
        #label
        \
        ACCESS LEVEL: #access
      ]
    ]
  }
}


#let skill-row(
  label,
  content,
  gap: 8pt,
) = grid(
  columns: (auto, 1fr),
  column-gutter: gap,

  micro(label),

  align(right)[
    #text(
      font: cjk,
      size: 9pt,
      weight: 500,
    )[
      #content
    ]
  ],
)
#let skill-list(items) = grid(
  columns: (1fr,),
  row-gutter: 5pt,
  ..items.map(item =>
    skill-row(item.label, item.content)
  )
)