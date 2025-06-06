# To use local instead of shared versions, replace the following and use the code in comments
DOCX_REFERENCE_DOC = --reference-doc APA-7.docx
# DOCX_REFERENCE_DOC = --reference-doc APA-7.docx
LATEX_REF_DOC = --template basic.tex
# LATEX_REF_DOC = --template basic.tex
CSL_FILE = --csl apa.csl
# CSL_FILE = --csl mis-quarterly.csl
BIBLIOGRAPHY_FILE = --bibliography references.bib

# The parameters should be in the same document (ideally in the YAML header of paper.md).
# We will keep them in the Makefile until template and reference-doc can be set in the YAML header.
# https://github.com/jgm/pandoc/issues/4627

.PHONY : build run analyses pdf latex docx

help :
	@echo "Usage: make [command]"
	@echo "    help"
	@echo "        Show this help description"
	@echo "    build"
	@echo "        Build the docker image pandoc_dockerfile"
	@echo "    run"
	@echo "        Run analyses of the complete repository"
	@echo "    analyses"
	@echo "        Run all analyses"
	@echo "    pdf"
	@echo "        Generate paper pdf"
	@echo "    latex"
	@echo "        Generate paper tex"
	@echo "    docx"
	@echo "        Generate paper docx"

run : analyses pdf latex docx

build:
	docker build -t pandoc_dockerfile .

analyses:
	[ -f analysis/Makefile ] && $(MAKE) -C analysis run || true # Skip if no Makefile in analysis directory

PANDOC_CALL = docker run --rm \
	--volume "`pwd`:/data" \
	--user `id -u`:`id -g` \
	pandoc_dockerfile \
	--verbose

pdf:
	$(PANDOC_CALL) \
		paper.md \
		--filter pantable \
		--filter pandoc-crossref \
		--citeproc \
		$(BIBLIOGRAPHY_FILE) \
		$(CSL_FILE) \
		$(LATEX_REF_DOC) \
		--pdf-engine xelatex \
		--output paper.pdf

latex:
	$(PANDOC_CALL) \
		paper.md \
		--filter pantable \
		--filter pandoc-crossref \
		--citeproc \
		$(BIBLIOGRAPHY_FILE) \
		$(CSL_FILE) \
		$(LATEX_REF_DOC) \
		--to latex \
		--pdf-engine xelatex \
		--output paper.tex

docx:
	$(PANDOC_CALL) \
		paper.md \
		--filter pantable \
		--filter pandoc-crossref \
		--citeproc \
		$(BIBLIOGRAPHY_FILE) \
		$(CSL_FILE) \
		$(DOCX_REFERENCE_DOC) \
		--output paper.docx

docker:
	docker build -t pandoc_dockerfile .