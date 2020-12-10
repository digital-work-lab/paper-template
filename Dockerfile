FROM pandoc/ubuntu-latex:latest
RUN tlmgr install gitinfo2
RUN tlmgr install xstring
