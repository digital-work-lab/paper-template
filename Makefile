# To use local instead of shared versions, replace the following and use the code in comments
DOCX_REFERENCE_DOC = --reference-doc /templates/ICIS2021.docx
# DOCX_REFERENCE_DOC = --reference-doc APA-7.docx
LATEX_REF_DOC = --template /templates/basic.tex
# LATEX_REF_DOC = --template basic.tex
CSL_FILE = --csl /styles/mis-quarterly.csl
# CSL_FILE = --csl mis-quarterly.csl
BIBLIOGRAPHY_FILE = --bibliography /bibliography/references.bib
# BIBLIOGRAPHY_FILE = --bibliography references.bib

# The parameters should be in the same document (ideally in the YAML header of paper.md).
# We will keep them in the Makefile until template and reference-doc can be set in the YAML header.
# https://github.com/jgm/pandoc/issues/4627

.PHONY : run pdf docx

help :
	@echo "Usage: make [command]"
	@echo "    help"
	@echo "        Show this help description"
	@echo "    run"
	@echo "        Run analyses of the complete repository"
	@echo "    analyses"
	@echo "        Run all analyses"
	@echo "    pdf"
	@echo "        Generate paper pdf"
	@echo "    docx"
	@echo "        Generate paper docx"

run : pdf docx

PANDOC_CALL = docker run --rm \
	--volume "`pwd`:/data" \
	--volume $(shell readlink -f ./styles):/styles/ \
	--volume $(shell readlink -f ./templates):/templates/ \
	--volume $(shell readlink -f ./bibliography):/bibliography/ \
	--user `id -u`:`id -g` \
	pandoc_dockerfile

pdf:
	$(PANDOC_CALL) \
		paper.md \
		--filter pandoc-crossref \
		--citeproc \
		$(BIBLIOGRAPHY_FILE) \
		$(CSL_FILE) \
		$(LATEX_REF_DOC) \
		--pdf-engine xelatex \
		--output paper.pdf

docx:
	$(PANDOC_CALL) \
		paper.md \
		--filter pandoc-crossref \
		--citeproc \
		$(BIBLIOGRAPHY_FILE) \
		$(CSL_FILE) \
		$(DOCX_REFERENCE_DOC) \
		--output paper.docx
