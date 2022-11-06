FROM node:12.0 AS nodejs

COPY . /usr/src/
WORKDIR /usr/src
ENV PATH /app/node_modules/.bin:$PATH

FROM nodejs AS deps
RUN npm install -g @koopjs/cli
#RUN npm install gdal --save -g
RUN npm install -g @arcgis/core@4.25.0-next.20221012
RUN npm install -g pg
RUN npm install -g koop-queue
RUN npm install -g koop-s3fs
RUN npm install -g @koopjs/output-vector-tiles
RUN npm install -g @koopjs/provider-agol
RUN npm install -g @koopjs/provider-s3-select
RUN npm install -g @koopjs/provider-file-geojson
RUN npm install -g @koopjs/provider-github


FROM deps AS geospatial

WORKDIR /usr/src/koop

RUN npm install
EXPOSE 8080 9000 80

CMD npm start
