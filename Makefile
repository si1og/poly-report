PACKAGE := poly-report
TEXMFHOME := $(shell kpsewhich -var-value=TEXMFHOME)
INSTALL_DIR := $(TEXMFHOME)/tex/latex/$(PACKAGE)

.PHONY: all install test clean

all: $(PACKAGE).sty

$(PACKAGE).sty: $(PACKAGE).dtx $(PACKAGE).ins
	latex -interaction=nonstopmode -halt-on-error $(PACKAGE).ins

install: $(PACKAGE).sty
	mkdir -p "$(INSTALL_DIR)"
	install -m 0644 $(PACKAGE).sty "$(INSTALL_DIR)/$(PACKAGE).sty"
	mktexlsr "$(TEXMFHOME)"

test: $(PACKAGE).sty
	cd example && TEXINPUTS=..: latexmk -g -pdf -shell-escape -interaction=nonstopmode -halt-on-error main.tex

clean:
	rm -f $(PACKAGE).sty $(PACKAGE).log $(PACKAGE).aux
	cd example && latexmk -C main.tex
