# poly-report

Общий LaTeX-пакет для учебных отчётов: оформление страницы, таблицы,
листинги `minted`, изображения, полноформатные страницы A3 и стили ER-диаграмм.

## Сборка и установка

```sh
make
make test
make install
```

`make` генерирует `poly-report.sty` из `poly-report.dtx` через `docstrip`.
`make install` устанавливает пакет в локальный `TEXMFHOME`.

После установки пакет подключается обычной командой:

```tex
\usepackage{poly-report}
```

Для сборки документов с `minted` необходим параметр `-shell-escape`.

## Основные макросы

```tex
\img[0.9]{img/result.png}{Результат}{\label{fig:result}}

\codeListing[cpp][firstline=10,lastline=30]
  {../src/main.cpp}
  {Основная функция}
  {\label{lst:main}}

\fullPageFigure
  {tex/graphics/schema.pdf}
  {Схема базы данных}
  {\label{fig:schema}}

\begin{aThreePortraitPage}
  Содержимое отдельной вертикальной страницы A3 с полями отчёта.
\end{aThreePortraitPage}
```

Для схем объектов базы данных пакет предоставляет таблицы, справочники,
метки полей и стили связей:

```tex
\begin{tikzpicture}
  \dbSchemaTable{typeface}{0,0}{
    \SetCell[c=2]{c} Typeface & \\
    PK & \dbFieldMark{typeface-pk}{id\_Typeface} \\
       & Name \\
  }

  \dbSchemaDictionary{weight}{18em,0}{
    \SetCell[c=2]{c} Weight & \\
    PK & \dbFieldMark{weight-pk}{id\_Weight} \\
       & Name \\
  }

  \draw[db schema link]
    (typeface.east) -- node[db schema cardinality] {$\infty$}
    (weight.west);
  \node[db schema annotation, above=0.3em of typeface] {Основная таблица};
\end{tikzpicture}
```

Необязательный первый аргумент `\dbSchemaTable` и
`\dbSchemaDictionary` задаёт ширину столбца атрибутов. Второй необязательный
аргумент `\dbSchemaTable` задаёт номера горизонтальных границ; например,
`[1-2,4]` проводит линию после двух полей составного первичного ключа.

Для наложения скриншотов на страницу, подключённую через `pdfpages`, можно
задать смысловые анкоры и позиционировать изображения относительно них:

```tex
\begin{tikzpicture}[remember picture, overlay]
  \exerciseAnchor{exercise-1-1-4}{23mm}{105mm}
  \screenAt[height=22mm,keepaspectratio]
    {exercise-1-1-4}{0mm}{0mm}{164mm}{img/1.1_4.png}
\end{tikzpicture}
```

Стили ER-диаграмм основаны на `tikz-er2` Павла Caldo (2009).
