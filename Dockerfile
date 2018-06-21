FROM rocker/tidyverse:3.5.0

ADD *.sh /
ADD *.R /
ADD GEO_Search_Results.txt /

RUN R -e "install.packages('doParallel', repos='http://cran.cnr.berkeley.edu/')" \
  && R -e "source('http://bioconductor.org/biocLite.R'); biocLite(c('SCAN.UPC', 'pd.hg.u133.plus.2'))" \
  && Rscript "installBrainArrayAnnotations.R"
