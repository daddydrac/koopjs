FROM node:12.0 AS base

COPY . /usr/src/
WORKDIR /usr/src
ENV PATH /app/node_modules/.bin:$PATH

FROM base AS deps 

RUN npm install -g @koopjs/cli \
    @arcgis/core@4.25.0-next.20221012 \
    pg \
    koop-queue \
    koop-s3fs \
    @koopjs/output-vector-tiles \
    @koopjs/provider-agol \
    @koopjs/provider-s3-select \
    @koopjs/provider-file-geojson \
    @koopjs/provider-github \
    geojson-vt \
    koop \
    koop-localfs \
    config \
    highland \
    mkdirp \
    rimraf \
    koop-provider-pg \
    bluebird \
    lodash \
    pg-promise \
    @koopjs/cache-redis \
    koop-logger \
    redis \
    worker-farm

FROM deps AS geospatial

WORKDIR /usr/src/koop

RUN npm install
RUN npm install gdal --save

EXPOSE 8080 9000 80

CMD npm start
