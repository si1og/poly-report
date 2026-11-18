# poly-report

Набор Typst-пресетов для учебных отчётов: русская типографика, страницы A4 и
A3, рисунки, таблицы, листинги кода и блоки для схем баз данных.

Версия пакета на LaTeX сохранена в ветке `deprecated/latex`.

## Требования и проверка

Требуется Typst 0.15 или новее. По умолчанию используется New Computer Modern
— совместимый с кириллицей вариант привычного шрифта LaTeX. Его можно заменить
параметром `font`.

```sh
make test
```

Команда создаёт `example/main.pdf` и проверяет перенос длинного листинга
на нескольких страницах. Установка в TeX не требуется:
подключите модуль через относительный путь или скопируйте `poly-report.typ` в
проект отчёта.

## Подключение

```typst
#import "../poly-report.typ": report, image-figure, code-listing

#show: report

= Введение

Текст отчёта.

#image-figure(image("img/result.png", width: 90%), [Результат запроса]) <fig:result>
#code-listing(read("../src/query.sql"), [Текст запроса], lang: "sql") <lst:query>
```

`report` настраивает лист A4, поля, русский язык, шрифт, абзацы, заголовки,
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

```typst
#import "../poly-report.typ": image-figure, image-grid, code-listing
#import "../poly-report.typ": a3-page, full-page-figure
#import "../poly-report.typ": db-schema-table, db-schema-dictionary

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

## Переход с LaTeX

Макросы LaTeX не импортируются в Typst автоматически. Соответствия:

| LaTeX | Typst |
| --- | --- |
| `\img` / `\screenshot` | `image-figure` |
| `\imgGrid` | `image-grid` |
| `\codeListing` | `code-listing` |
| `\fullPageFigure` | `full-page-figure` |
| `aThreePortraitPage` | `a3-page(landscape: false)` |
| `\dbSchemaTable` | `db-schema-table` |
| `\dbSchemaDictionary` | `db-schema-dictionary` |

Существующие `.tex`-отчёты продолжают собираться с версией из
`deprecated/latex`; их перенос выполняется отдельно.
