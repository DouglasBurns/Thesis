LATEX=pdflatex
LATEXOPT=--shell-escape
NONSTOP=--interaction=nonstopmode

LATEXMK=latexmk
LATEXMKOPT=-pdf
CONTINUOUS=-pvc

# Title of Report
MAIN=Thesis

# Chapters of Report
SOURCES=$(MAIN).tex Makefile Chapters/*.tex PlotCollections/*.tex TableCollections/*.tex Feynmans/*.tex

# Figures of End_of_year_report
FIGURES := $(shell find Figures/* Plots/* -type f)

all:$(MAIN).pdf

.refresh:
	touch .refresh

$(MAIN).pdf: $(MAIN).tex .refresh $(SOURCES) $(FIGURES) 
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
	-pdflatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(MAIN)

force:
	touch .refresh
	rm $(MAIN).pdf
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
		-pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

clean:
	$(LATEXMK) -C $(MAIN)
	rm -f $(MAIN).pdfsync
	rm -rf *~ *.tmp
	rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk

once:
	$(LATEXMK) $(LATEXMKOPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

debug:
	$(LATEX) $(LATEXOPT) $(MAIN)

.PHONY:clean force once all
