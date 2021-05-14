FROM pandoc/ubuntu-latex:2.13
RUN tlmgr update --self
RUN tlmgr install gitinfo2
RUN tlmgr install xstring

RUN apt-get update && apt-get install -y python3-pip && pip3 install pantable
