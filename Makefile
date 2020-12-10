DOCX_REFERENCE_DOC = --reference-doc=/templates/APA-7.docx
LATEX_REF_DOC = --template=/templates/default.latex

PANDOC_CALL = docker run --rm --volume "`pwd`:/data" -v $(shell readlink ./styles):/styles/ -v $(shell readlink ./templates):/templates/ --user `id -u`:`id -g` pandoc_dockerfile
# Alternative: run locally
# PANDOC_CALL = pandoc
# Alternative: run specific version (pandoc/ubuntu-latex)
# PANDOC_VERSION = 2.11.2
#PANDOC_CALL = docker run --rm --volume "`pwd`:/data" -v $(shell readlink ./styles):/styles/ -v $(shell readlink ./templates):/templates/ --user `id -u`:`id -g` pandoc/ubuntu-latex:$(PANDOC_VERSION)

BIBLIOGRAPHY_FILE = $(wildcard *.bib)

run: pdf docx

pdf:
	rm -f ./references_copy.bib && \
	cp -Lr ./$(BIBLIOGRAPHY_FILE) ./references_copy.bib && \
	$(PANDOC_CALL) paper.md	\
	 	--filter pandoc-crossref \
		--citeproc \
		--bibliography=references_copy.bib \
		$(LATEX_REF_DOC) \
		--pdf-engine=xelatex \
		-o outfile.pdf && \
	rm ./references_copy.bib

docx:
	rm -f ./references_copy.bib && \
	cp -Lr ./$(BIBLIOGRAPHY_FILE) ./references_copy.bib && \
	$(PANDOC_CALL) paper.md \
		--filter pandoc-crossref \
		--citeproc \
		--bibliography=references_copy.bib \
		$(DOCX_REFERENCE_DOC) \
		-o outfile.docx && \
	rm ./references_copy.bib

install:
	cd ..
	git clone https://github.com/citation-style-language/styles
	git clone https://github.com/geritwagner/templates
	cd ../theory-elaboration-manuscript
	ln -s ../styles styles
	ln -s ../templates templates
	# For gitinfo2:
	cd .git/hooks
	cp /usr/share/texlive/texmf-dist/tex/latex/gitinfo2/post-xxx-sample.txt post-checkout
	cp post-checkout post-merge
	cp post-checkout post-commit
	cd ../..
	docker build -t pandoc_dockerfile .
