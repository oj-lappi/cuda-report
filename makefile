#Darkmatter_cuda is filled in by substitution in boil_report
DOCUMENT_NAME=Darkmatter_cuda
TEX_SOURCE=$(DOCUMENT_NAME).tex
BIB_SOURCE=$(DOCUMENT_NAME).bib
AUX_OUTPUT=$(DOCUMENT_NAME).aux
PDF_TARGET=$(DOCUMENT_NAME).pdf


all : $(PDF_TARGET)

$(PDF_TARGET) : $(TEX_SOURCE)
	@echo "Compiling pdf from $(TEX_SOURCE)"
	@pdflatex -file-line-error -interaction batchmode -- $(TEX_SOURCE) &> /dev/null || :
	@-if [ -f "$(BIB_SOURCE)" ];then \
		echo "Compiling bibliography"; \
		bibtex "$(AUX_OUTPUT)"; \
		pdflatex -file-line-error -interaction batchmode -- $(TEX_SOURCE) &> /dev/null; \
	fi
	@-pdflatex -file-line-error -interaction batchmode -- $(TEX_SOURCE) &> /dev/null;
	@if [ $${?} != 0 ];then \
		echo "Errors:"; \
	fi
	grep ".\{1,\}:[0-9]\{1,\}:" $(DOCUMENT_NAME).log ||:

.PHONY : clean
clean :
	rm $(DOCUMENT_NAME).aux
	rm $(DOCUMENT_NAME).log
	rm $(DOCUMENT_NAME).out
	rm $(DOCUMENT_NAME).toc
	rm $(DOCUMENT_NAME).blg
