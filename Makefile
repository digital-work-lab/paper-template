ARTICLE_FILE        = paper.md
DEFAULT_EXTENSIONS = docx pdf
PANDOC_SCHOLAR_PATH = pandoc-scholar
TEMPLATE_FILE_LATEX = templates/basic.tex
DOCX_REFERENCE_FILE   = templates/APA-7.docx
include $(PANDOC_SCHOLAR_PATH)/Makefile
