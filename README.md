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
```

Стили ER-диаграмм основаны на `tikz-er2` Павла Caldo (2009).
