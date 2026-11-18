# poly-report

Набор Typst-пресетов для учебных отчётов: русская типографика, страницы A4 и
A3, рисунки, таблицы, листинги кода и блоки для схем баз данных.

Версия пакета на LaTeX сохранена в ветке `deprecated/latex`.

## Требования и проверка

Требуется Typst 0.15 или новее. По умолчанию отчёт использует CM-Super.
Установите шрифты в пользовательский каталог один раз. Для конвертации нужны
TeX Live с CM-Super, `kpsewhich` и FontForge.

```sh
make install-fonts
typst compile example/main.typ example/main.pdf
```

Типографические контуры берутся из исходных Type 1 шрифтов. OTF-файлы
не хранятся в репозитории. CM-Super распространяется по GPLv2+ с исключением
для встраивания в PDF. См. `texmf-dist/doc/fonts/cm-super/README` в TeX Live.
Typst находит установленные шрифты автоматически. Параметры `font`,
`code-font` и `large-heading-font` позволяют выбрать другие семейства.

```sh
make test
```

Команда создаёт `example/main.pdf` и проверяет перенос длинного листинга
на нескольких страницах.

## Подключение

Установите локальный пакет командой `make install-package`.
Она создаёт ссылку на текущий checkout, поэтому правки в библиотеке сразу
доступны при следующей сборке отчёта.

```typst
#import "@local/poly-report:0.1.0": report, image-figure, code-listing

#show: report

= Введение

Текст отчёта.

#image-figure(image("img/result.png", width: 90%), [Результат запроса]) <fig:result>
#code-listing(read("../src/query.sql"), [Текст запроса], lang: "sql") <lst:query>
```

`poly-report` настраивает лист A4, поля, русский язык, шрифт, абзацы, заголовки,
подписи и нумерацию страниц. Содержание и титульный лист можно передать как
`with-outline` и `title-page`:

```typst
#show: report.with(
  title-page: [
    #align(center)[*Отчёт по лабораторной работе*]
  ],
  with-outline: true,
)
```

## Пресеты

Размеры соответствуют шкале LaTeX `extsizes` для 14 pt. Доступны
`tiny`, `scriptsize`, `footnotesize`, `small`, `normalsize`, `large`,
`Large`, `LARGE`, `huge` и `Huge`. Функция `large` также выбирает
оптическое семейство CM Super 1728. Для смены только кегля доступны
значения в `latex-size`.

```typst
#import "@local/poly-report:0.1.0": large, latex-size

#large[Название отчёта]
#set text(size: latex-size.small)
Текст меньшего размера.
```

```typst
#import "@local/poly-report:0.1.0": image-figure, image-grid, code-listing
#import "@local/poly-report:0.1.0": a3-page, full-page-figure
#import "@local/poly-report:0.1.0": db-schema-table, db-schema-dictionary

#image-figure(image("img/result.png", width: 90%), [Результат]) <fig:result>

#image-grid(
  (image("img/left.png", width: 100%), image("img/right.png", width: 100%)),
  [Сравнение результатов],
) <fig:comparison>

#code-listing(read("../src/main.sql"), [Основной запрос], lang: "sql") <lst:main>

#full-page-figure(
  image("img/schema.pdf", width: 100%, height: 235mm, fit: "contain"),
  [Схема базы данных],
) <fig:schema>

#a3-page(landscape: false)[
  = Дополнительная схема
  Содержимое отдельной страницы A3.
]

#db-schema-table("Typeface", (
  ("PK", "id_Typeface"),
  ("", "Name"),
  ("FK", "id_Weight"),
))
```

`full-page-figure` помещает рисунок на отдельную страницу A3 в альбомной
ориентации. `a3-page` принимает содержимое отдельной страницы A3. Блоки
`db-schema-table` и `db-schema-dictionary` оформляют таблицы сущностей;
расположение и линии связей задаются в самом документе средствами Typst либо
отдельной библиотекой диаграмм.
