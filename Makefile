ifeq ($(shell uname -s),Darwin)
PACKAGE_DATA_DIR := $(HOME)/Library/Application Support
FONT_INSTALL_DIR ?= $(HOME)/Library/Fonts/poly-report
else
PACKAGE_DATA_DIR := $(or $(XDG_DATA_HOME),$(HOME)/.local/share)
FONT_INSTALL_DIR ?= $(or $(XDG_DATA_HOME),$(HOME)/.local/share)/fonts/poly-report
endif

PACKAGE_PATH ?= $(or $(TYPST_PACKAGE_PATH),$(PACKAGE_DATA_DIR)/typst/packages)
PACKAGE_VERSION := $(shell sed -n 's/^version = "\([^"]*\)"$$/\1/p' typst.toml)
PACKAGE_PARENT := $(PACKAGE_PATH)/local/poly-report
PACKAGE_DIR := $(PACKAGE_PARENT)/$(PACKAGE_VERSION)

.PHONY: test clean cm-super-fonts install-fonts install-package

cm-super-fonts:
	fontforge -lang=py -script scripts/prepare-cm-super.py

install-fonts: cm-super-fonts
	install -d "$(FONT_INSTALL_DIR)"
	install -m 644 fonts/cm-super/*.otf "$(FONT_INSTALL_DIR)/"

install-package:
	install -d "$(PACKAGE_PARENT)"
	@if [ "$$(readlink "$(PACKAGE_DIR)")" = "$(CURDIR)" ]; then exit 0; fi; \
	if [ -e "$(PACKAGE_DIR)" ] || [ -L "$(PACKAGE_DIR)" ]; then \
		printf '%s\n' "Package path already exists: $(PACKAGE_DIR)" >&2; exit 1; \
	fi; \
	ln -s "$(CURDIR)" "$(PACKAGE_DIR)"

test:
	typst compile --root . example/main.typ example/main.pdf
	typst compile --root . example/long.typ example/long.pdf

clean:
	rm -f example/main.pdf
