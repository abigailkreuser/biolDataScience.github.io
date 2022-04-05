R_FILES = $(wildcard *.R)
TEXFILE = $(wildcard *.tex)

analysis: 
	Rscript -e "install.packages('plyr')"
	R CMD BATCH $(R_FILES)
  Rscript -e "rmarkdown::render('lecture.Rmd')"
 
view:
	evince $(TEXFILE).pdf &

compile: 
	pdflatex $(TEXFILE)

clean:
	rm -fv *.aux *.log *.toc *.blg *.bbl *.synctex.gz
	rm -fv *.out *.bcf *blx.bib *.run.xml
	rm -fv *.fdb_latexmk *.fls
	rm -fv *.pdf
