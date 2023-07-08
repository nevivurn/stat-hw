SOURCES := $(wildcard *.tex)
OUTPUTS := $(SOURCES:%.tex=%.pdf)

PYSOURCES := $(wildcard *.py)

PDFLATEX := lualatex
PDFLATEXFLAGS := --shell-escape
PREFIX := build

.PHONY: all
all: $(OUTPUTS)

.PHONY: install
install: $(OUTPUTS)
	install -Dm644 -t $(PREFIX) $(OUTPUTS)

clean:
	rm -rf *.pdf *.log *.aux *.svg svg-inkscape

%.pdf: %.tex
	[ -f $(@:%.pdf=%.py) ] && python $(@:%.pdf=%.py) || true
	$(PDFLATEX) $(PDFLATEXFLAGS) $^
