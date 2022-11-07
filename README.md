# Docker & Helm Chart deployment for KoopJS 
<em>See instructions below to install for Kubernetes or Docker ~ </em> Koop is a JavaScript toolkit for connecting spatial APIs. Out of the box, it exposes a Node. js server that translates GeoJSON into the GeoServices specification supported by ArcGIS products. 

## Features
Boilerplate REST API to get you started faster, with json config for Redis cache, Postgres/PostGIS support for speed, & local file store config if not using s3. 

<strong><em>The json config is located in:</em></strong>  ``` /koop/config/default.json```, and is pre-configured to support custom ports, redis cache, local filestore and Postgres/PostGIS for faster retrieval of geospatial information with ```Koop FileExporter``` for interop.

```
{
  "port": 8080,
  "cache": {
    "redis": {
      "host": "redis://localhost:6379"
    }
  },
  "filesystem": {
    "local": {
      "rootDir": "/var/koop/files"
    }
  },
  "db": {
    "postgis": "postgres://postgres:postgres@localhost:5432/geo_database"
  }
}
```

 - koopjs/cli
 - arcgis/core@4.25.0-next.20221012
 - pg: Postgres/PostGIS support
 - koop-queue
 - koop-s3fs: AWS s3 connect
 - koopjs/output-vector-tiles
 - koopjs/provider-agol
 - koopjs/provider-s3-select
 - koopjs/provider-file-geojson
 - koopjs/provider-github
 - GDAL: Read and write raster and vector geospatial datasets straight from [Node.js](http://nodejs.org) with this native [GDAL](http://www.gdal.org/) binding. GDAL [2.4.4](https://github.com/OSGeo/gdal/releases/tag/v2.4.4) ([GEOS](http://trac.osgeo.org/geos/) [3.4.2](http://trac.osgeo.org/geos/browser/tags/3.4.2/NEWS), [PROJ](http://trac.osgeo.org/proj/) [4.8.0](http://www.osgeo.org/node/1268)) comes bundled, so node-gdal will work straight out of the box. To get started, browse the [**API Documentation**](http://naturalatlas.github.io/node-gdal/classes/gdal.html) or [examples](examples/).
 - Worker Farm: A worker bot to run jobs for Koop
 - Koop Exporter: A Koop cache must be registered to work.
 - FeatureServer An open source implementation of the GeoServices specification.
 - <em>And more!</em>


 ## Boilerplate REST API test routes:

   1. http://localhost:8080/github/koopjs::geodata::north-america/FeatureServer/0/query

   2. http://localhost:8080/craigslist/seattle/apartments/FeatureServer/0/query


Once the container is built, you'll see the boilerplate REST API connecting to GitHub and CraigsList data:

![restapi-boilerplate](./koop/test/restapi.png)

----------------------------

## Docker Instructions
The Dockerfile is a multi-stage docker build to reduce image size. To skip build times pull the image and run:

<strong>Pull:</strong> ```docker pull jhoeller/koopjs```

<strong>Run:</strong> ```docker run --rm -it -d -v "${PWD}:/usr/src/" -p 8080:8080 -p 9000:9000 -p 80:80 jhoeller/koopjs:latest```

### Build & run locally

   - ```git clone https://github.com/salinaaaaaa/koopjs.git```
  
   - ```docker build -t koopjs .```

   - ```docker run --rm -it -d -v "${PWD}:/usr/src/" -p 8080:8080 -p 9000:9000 -p 80:80 koopjs```

------------------------------

## Kubernetes/Helm Deployment

   - ```cd helm```

   - ```helm install koopjs .```

#### Example override values.yaml
   - ```helm install koopjs . --set service.type=ClusterIP --set service.port=80```

#### Get default value NodePorts from KoopJS

  ```
  export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services koopjs)
  ```
  
  ```
  export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
  ```
  
  ```
  echo http://$NODE_IP:$NODE_PORT
  ```
