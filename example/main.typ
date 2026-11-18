#import "../poly-report.typ": *

#show: report.with(
  title-page: [
    #align(center)[
      *Санкт-Петербургский политехнический университет Петра Великого*

      #v(45mm)
      *ОТЧЁТ ПО ПРАКТИЧЕСКОЙ РАБОТЕ*

      #v(10mm)
      Базы данных
    ]
  ],
  with-outline: true,
)

= Проверка пресетов

Русский текст отчёта с длинным абзацем. Представление группирует начертания
по гарнитуре и подсчитывает количество форматов и градаций насыщенности.

== Таблица базы данных

#figure(
  db-schema-table("Typeface", (
    ("PK", "id_Typeface"),
    ("", "Name"),
    ("FK", "id_Weight"),
  )),
  caption: [Атрибуты таблицы начертаний],
  kind: table,
) <tab:typeface>

См. @tab:typeface.

== Листинг

#code-listing(
  "SELECT id_font_family, name FROM typeface;",
  [Пример SQL-запроса],
  lang: "sql",
) <lst:query>

См. @lst:query.

#image-figure(image("assets/mark.svg", width: 90%), [Проверка рисунка]) <fig:mark>

#image-grid(
  (image("assets/mark.svg", width: 100%), image("assets/mark.svg", width: 100%)),
  [Проверка сетки рисунков],
) <fig:grid>

#a3-page(landscape: false)[
  = Вертикальная страница A3

  Проверка отдельного листа A3.
]

= Заключение

После страницы A3 документ снова продолжается на листе A4.

#full-page-figure(
  image("assets/mark.svg", width: 100%, height: 235mm, fit: "contain"),
  [Проверка альбомной страницы A3],
) <fig:a3>
