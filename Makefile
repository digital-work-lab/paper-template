DOCX_REFERENCE_DOC = --reference-doc /templates/ICIS2021.docx
LATEX_REF_DOC = --template /templates/basic.tex
CSL_FILE = --csl /styles/mis-quarterly.csl
BIBLIOGRAPHY_FILE = --bibliography /bibliography/references.bib
# The parameters should be in the same document (ideally in the YAML header of paper.md).
# We will keep them in the Makefile until template and reference-doc can be set in the YAML header.
# https://github.com/jgm/pandoc/issues/4627

.PHONY : run pdf docx install

help :
	@echo "Usage: make [command]"
	@echo "    help"
	@echo "        Show this help description"
	@echo "    run"
	@echo "        Run analyses of the complete repository"
	@echo "    analyses"
	@echo "        Run all analyses"
	@echo "    pdf"
	@echo "        Generate manuscript pdf"
	@echo "    docx"
	@echo "        Generate manuscript docx"

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
		--output outfile.pdf

docx:
	$(PANDOC_CALL) \
		paper.md \
		--filter pandoc-crossref \
		--citeproc \
		$(BIBLIOGRAPHY_FILE) \
		$(CSL_FILE) \
		$(DOCX_REFERENCE_DOC) \
		--output outfile.docx

install:
	git clone https://github.com/geritwagner/bibliography ../bibliography
	git clone https://github.com/citation-style-language/styles ../styles
	git clone https://github.com/geritwagner/templates ../templates
	ln -s ../styles
	ln -s ../templates
	ln -s ../bibliography
	# For gitinfo2:
	cp /usr/share/texlive/texmf-dist/tex/latex/gitinfo2/post-xxx-sample.txt .git/hooks/post-checkout
	cp .git/hooks/post-checkout .git/hooks/post-merge
	cp .git/hooks/post-checkout .git/hooks/post-commit
	docker build -t pandoc_dockerfile .
