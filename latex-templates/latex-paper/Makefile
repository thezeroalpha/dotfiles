LMK_AUXDIR=build
MAINFILE=src/main.tex
PDFNAME=output.pdf

LMK_FLAGS=-bibtex -cd -auxdir=$(LMK_AUXDIR) -outdir=$(LMK_AUXDIR)
SRCFILES=$(wildcard $(dir $(MAINFILE))*.tex)
OUTPDF=$(dir $(MAINFILE))$(LMK_AUXDIR)/$(notdir $(basename $(MAINFILE))).pdf

.PHONY: all clean cleanall open

all: $(PDFNAME)

open: $(PDFNAME)
	@open $(PDFNAME) || xdg-open $(PDFNAME) || echo "Don't know how to open."


$(PDFNAME): $(OUTPDF)
	mv $(OUTPDF) ./$(PDFNAME)

$(OUTPDF): $(SRCFILES)
	latexmk $(LMK_FLAGS) -pdf $(MAINFILE)

clean:
	latexmk $(LMK_FLAGS) -c $(MAINFILE)

cleanall:
	latexmk $(LMK_FLAGS) -C $(MAINFILE)
	rm ./src/numbers/*
	rm ./$(PDFNAME)
