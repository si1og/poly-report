// Shared Typst presets for Russian university reports.

#let lovelace-theme = read("themes/lovelace.tmTheme", encoding: none)

// The size14.clo scale from LaTeX extsizes, converted from TeX pt to PDF pt.
#let latex-pt(size) = size * (72 / 72.27) * 1pt
#let latex-size = (
  tiny: latex-pt(6),
  scriptsize: latex-pt(8),
  footnotesize: latex-pt(10),
  small: latex-pt(12),
  normalsize: latex-pt(14.4),
  large: latex-pt(17.28),
  Large: latex-pt(20.74),
  LARGE: latex-pt(24.88),
  huge: latex-pt(29.86),
  Huge: latex-pt(35.83),
)

#let default-font = "CM Super 1440"
#let default-code-font = "CM Super Typewriter 1200"
#let default-large-font = "CM Super 1728"

#let tiny = text.with(size: latex-size.tiny)
#let scriptsize = text.with(size: latex-size.scriptsize)
#let footnotesize = text.with(size: latex-size.footnotesize)
#let small = text.with(size: latex-size.small)
#let normalsize = text.with(size: latex-size.normalsize)
#let large = text.with(size: latex-size.large, font: default-large-font)
#let Large = text.with(size: latex-size.Large)
#let LARGE = text.with(size: latex-size.LARGE)
#let huge = text.with(size: latex-size.huge)
#let Huge = text.with(size: latex-size.Huge)

#let report(
  body,
  font: default-font,
  code-font: default-code-font,
  large-heading-font: auto,
  title-page: none,
  with-outline: false,
) = {
  let heading-font = if large-heading-font == auto {
    if font == default-font { default-large-font } else { font }
  } else if large-heading-font == none { font } else { large-heading-font }

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
  show heading.where(level: 1): set text(font: heading-font, size: 17.28pt)
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
