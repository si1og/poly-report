.PHONY: test clean cm-super-fonts

cm-super-fonts:
	fontforge -lang=py -script scripts/prepare-cm-super.py

test:
	typst compile --root . --font-path fonts example/main.typ example/main.pdf
	typst compile --root . --font-path fonts example/long.typ example/long.pdf

clean:
	rm -f example/main.pdf
