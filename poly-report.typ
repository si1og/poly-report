// Shared Typst presets for Russian university reports.

#let lovelace-theme = read("themes/lovelace.tmTheme", encoding: none)

#let report(
  body,
  font: "CMU Serif",
  code-font: "CMU Typewriter Text",
  large-heading-font: none,
  title-page: none,
  with-outline: false,
) = {
  set document(title: "Учебный отчёт")
  set page(
    paper: "a4",
    margin: (left: 25mm, right: 25mm, top: 22mm, bottom: 20mm),
    numbering: "1",
    number-align: center + bottom,
  )
  set text(font: font, size: 14pt, fill: luma(15), lang: "ru")
  set raw(theme: lovelace-theme)
  show raw: set text(font: code-font)
  show ref: set text(fill: blue)
  set par(justify: true, first-line-indent: (amount: 7.5mm, all: true), leading: 0.52em, spacing: 0.53em)
  set heading(numbering: (..nums) => [#numbering("1.1", ..nums)#h(10pt)])
  set enum(indent: 9.3pt, body-indent: 0.34em, spacing: 18pt)
  show enum: set block(above: 19pt, below: 27pt)
  show heading: set text(weight: "bold")
  show heading.where(level: 1): set text(font: if large-heading-font == none { font } else { large-heading-font }, size: 17.28pt)
  show heading.where(level: 2): set text(size: 14.4pt)
  show heading.where(level: 3): set text(size: 14.4pt)
  show heading.where(level: 3): set block(below: 15pt)
  show heading: it => {
    set par(first-line-indent: 0pt)
    it
  }
  set figure.caption(separator: ": ")
  show figure.where(kind: image): set figure(supplement: [Рис.])
  show figure.where(kind: table): set figure(supplement: [Таблица])
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set align(left)
  show figure.where(kind: "listing"): set figure(supplement: [Листинг])
  show figure.where(kind: "listing"): set figure.caption(position: top)
  show figure.where(kind: "listing"): set block(breakable: true, above: 24pt)
  show figure.where(kind: "listing"): set align(left)

  if title-page != none {
    title-page
    pagebreak()
  }
  if with-outline {
    outline(title: [Содержание], indent: auto)
    pagebreak()
  }
  body
}

#let image-figure(body, caption) = figure(
  body,
  caption: caption,
  kind: image,
  placement: none,
)

#let image-grid(images, caption, gutter: 8pt) = figure(
  grid(
    columns: (1fr,) * images.len(),
    gutter: gutter,
    ..images,
  ),
  caption: caption,
  kind: image,
  placement: none,
)

#let listing-body(source, lang) = {
  set text(size: 15pt)
  show raw.line: it => {
    h(-10mm)
    box(align(right, text(size: 12pt, fill: luma(130), str(it.number))), width: 6mm)
    h(4mm)
    it.body
  }
  raw(source.trim(at: end), lang: lang, block: true)
}

#let code-listing(source, caption, lang: none) = figure(
  align(left, listing-body(source, lang)),
  caption: caption,
  kind: "listing",
  gap: 14.5pt,
  supplement: [Листинг],
  placement: none,
)

#let a3-page(body, landscape: true) = {
  pagebreak()
  {
    set page(
      width: if landscape { 420mm } else { 297mm },
      height: if landscape { 297mm } else { 420mm },
      margin: (left: 25mm, right: 25mm, top: 20mm, bottom: 20mm),
      numbering: "1",
    )
    body
  }
}

#let full-page-figure(body, caption) = a3-page(
  figure(
    body,
    caption: caption,
    kind: image,
    placement: none,
  ),
)

#let db-schema-table(name, fields, attribute-width: 100mm) = block(
  width: auto,
  breakable: false,
  table(
    columns: (14mm, attribute-width),
    stroke: 0.6pt,
    inset: (x: 5pt, y: 3pt),
    align: (center, left),
    table.cell(colspan: 2, align: center)[*#name*],
    ..fields.map(field => (field.at(0), field.at(1))).flatten(),
  ),
)

#let db-schema-dictionary(name, fields, attribute-width: 60mm) = db-schema-table(
  name,
  fields,
  attribute-width: attribute-width,
)
