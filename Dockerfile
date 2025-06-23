# Note: when updating pandoc/latex, make sure it builds locally and on Codespaces
FROM pandoc/latex:3.7-ubuntu

RUN tlmgr update --self
RUN tlmgr install gitinfo2
RUN tlmgr install xstring
RUN tlmgr install listings
RUN tlmgr install eso-pic
RUN tlmgr install biblatex

RUN apt-get update && apt-get install -y biber
RUN apt-get update && apt-get install -y python3-pip && pip3 install --break-system-packages pantable
