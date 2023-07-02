SOURCES := $(wildcard *.tex)
OUTPUTS := $(SOURCES:%.tex=%.pdf)

PYSOURCES := $(wildcard *.py)

PDFLATEX := lualatex
PDFLATEXFLAGS := --shell-escape
PREFIX := build

.PHONY: all
all: generate $(OUTPUTS)

.PHONY: install
install: $(OUTPUTS)
	install -Dm644 -t $(PREFIX) $(OUTPUTS)

.PHONY: generate
generate: $(PYSOURCES)

.PHONY: $(PYSOURCES)
$(PYSOURCES):
	python $@

clean:
	rm -rf *.pdf *.log *.aux *.svg

%.pdf: %.tex | generate
	$(PDFLATEX) $(PDFLATEXFLAGS) $^
