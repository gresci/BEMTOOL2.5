FROM rexyai/restrserve

RUN apt-get update && apt-get -y install build-essential libgtk2.0-dev

ENV BEMTOOL_DEPENDENCIES ggplot2 gridExtra akima stringr RGtk2 Hmisc timeDate reshape scales

COPY . /app
WORKDIR /app

#ENV RUNME BEMTOOL/RUNme.r
#ENV CIAO ${cat $RUNME}
#RUN echo $CIAO
#RUN bash dockerfiles/install_dependencies.sh

RUN mv BEMTOOL-ver* BEMTOOL

RUN R CMD INSTALL ALADYMTools*.tar.gz && rm ALADYMTools*.tar.gz \
    && Rscript -e 'source(paste(getwd(), "/BEMTOOL/RUNme.r", sep=""))'
