R_FILES = $(wildcard *.R)
TEXFILE = $(wildcard *.tex)

analysis: analysis.RData
	Rscript -e "install.packages('plyr')"
	R CMD BATCH $(R_FILES)

view:
	evince $(TEXFILE).pdf &

compile: 
	pdflatex $(TEXFILE)

clean:
	rm -fv *.aux *.log *.toc *.blg *.bbl *.synctex.gz
	rm -fv *.out *.bcf *blx.bib *.run.xml
	rm -fv *.fdb_latexmk *.fls
	rm -fv *.pdf
