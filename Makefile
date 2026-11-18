.PHONY: test clean

test:
	typst compile --root . example/main.typ example/main.pdf
	typst compile --root . example/long.typ example/long.pdf

clean:
	rm -f example/main.pdf
