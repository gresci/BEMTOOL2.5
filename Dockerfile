FROM rexyai/restrserve

ENV BEMTOOL_DIR='BEMTOOL-ver2.5-2018_0901' \
    ALADYMT='ALADYMTools_1.6.tar.gz' \
    MCDA_SAVE_DIR='/app/MCDA_OUTPUT' \
    BEMTOOL_URL='http://localhost:8080' \
    BEMTOOL_PORT='8080'

RUN apt-get update && apt-get -y install build-essential libgtk2.0-dev \
    libjpeg62-turbo-dev libxml2-dev libxslt-dev curl libcurl4-openssl-dev libssl-dev \
    libudunits2-dev libgit2-dev libgdal-dev gdal-bin libproj-dev proj-data proj-bin libgeos-dev

RUN mkdir /installation
COPY ${ALADYMT} /installation/${ALADYMT}
COPY ${BEMTOOL_DIR}/RUNme.r /installation/RUNme.r

RUN R CMD INSTALL /installation/ALADYMTools*.tar.gz \
    && rm -r /installation/ALADYMTools* \
    && Rscript -e 'source("/installation/RUNme.r")' \
    && rm -r /installation

COPY . /app
WORKDIR /app

EXPOSE ${BEMTOOL_PORT}

CMD "Rscript -e 'source(\"app.R\");'"