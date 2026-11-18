// Shared Typst presets for Russian university reports.

#let report(
  body,
  font: "Times New Roman",
  title-page: none,
  with-outline: false,
) = {
  set document(title: "Учебный отчёт")
  set page(
    paper: "a4",
    margin: (left: 25mm, right: 25mm, top: 20mm, bottom: 20mm),
    numbering: "1",
    number-align: center + bottom,
  )
  set text(font: font, size: 14pt, lang: "ru")
  set par(justify: true, first-line-indent: 12mm, leading: 0.65em)
  set heading(numbering: "1.1")
  show heading: it => {
    set par(first-line-indent: 0pt)
    it
  }
  set figure.caption(separator: ". ")
  show figure.where(kind: image): set figure(supplement: [Рисунок])
  show figure.where(kind: table): set figure(supplement: [Таблица])
  show figure.where(kind: "listing"): set figure(supplement: [Листинг])
  show figure.where(kind: "listing"): set figure.caption(position: top)
  show figure.where(kind: "listing"): set block(breakable: true)

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

#let code-listing(source, caption, lang: none) = figure(
  raw(source, lang: lang, block: true),
  caption: caption,
  kind: "listing",
  supplement: [Листинг],
  placement: none,
)

#let a3-page(body, landscape: true) = {
  pagebreak()
  {
    set page(
      width: if landscape { 420mm } else { 297mm },
      height: if landscape { 297mm } else { 420mm },
      margin: 15mm,
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
