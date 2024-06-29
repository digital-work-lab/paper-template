FROM pandoc/ubuntu-latex:2.16.2
RUN tlmgr option repository ftp://tug.org/historic/systems/texlive/2021/tlnet-final
RUN tlmgr update --self
RUN tlmgr install gitinfo2
RUN tlmgr install xstring
RUN tlmgr install listings

RUN apt-get update && apt-get install -y python3-pip && pip3 install pantable
