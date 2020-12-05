LMK_AUXDIR=build
MAINFILE=src/thesis.tex

LMK_FLAGS=-bibtex -cd -auxdir=$(LMK_AUXDIR) -outdir=$(LMK_AUXDIR)
SRCFILES=$(wildcard $(dir $(MAINFILE))*.tex)
PDFNAME:=$(basename $(notdir $(MAINFILE))).pdf

.PHONY: all clean cleanall open

all: $(PDFNAME)

open: $(PDFNAME)
	@open $(PDFNAME) || xdg-open $(PDFNAME) || echo "Don't know how to open."


$(PDFNAME): $(dir $(MAINFILE))$(LMK_AUXDIR)/thesis.pdf
	mv $(dir $(MAINFILE))$(LMK_AUXDIR)/thesis.pdf ./$(PDFNAME)

$(dir $(MAINFILE))$(LMK_AUXDIR)/thesis.pdf: $(SRCFILES)
	latexmk $(LMK_FLAGS) -pdf $(MAINFILE)

clean:
	latexmk $(LMK_FLAGS) -c $(MAINFILE)

cleanall:
	latexmk $(LMK_FLAGS) -C $(MAINFILE)
	rm ./src/numbers/*
	rm ./$(PDFNAME)
