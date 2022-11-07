# Docker & Helm Chart deployment for KoopJS 
<em>See instructions below to install for Kubernetes or Docker ~ </em> Koop is a JavaScript toolkit for connecting spatial APIs. Out of the box, it exposes a Node. js server that translates GeoJSON into the GeoServices specification supported by ArcGIS products. 

TODO: Add GDAL,which is a translator library for raster and vector geospatial data formats

## Features
Boilerplate REST API to get you started faster, with json config for Redis cache, Postgres/PostGIS support for speed, & local file store config if not using s3. <strong><em>The json config is located in:</em></strong>  ``` /koop/config/default.json```.

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


 ## Boilerplate REST API test routes:

   1. http://localhost:8080/github/koopjs::geodata::north-america/FeatureServer/0/query

   2. http://localhost:8080/craigslist/seattle/apartments/FeatureServer/0/query


Once the container is built, you'll see the boilerplate REST API connecting to GitHub and CraigsList data:

![restapi-boilerplate](./koop/test/restapi.png)

----------------------------

## Docker Instructions
The Dockerfile is a multi-stage docker build to reduce image size.

To skip build times pull the image and run:

Pull: ```docker pull jhoeller/koopjs```
Run: ```docker run --rm -it -d -v "${PWD}:/usr/src/" -p 8080:8080 -p 9000:9000 -p 80:80 jhoeller/koopjs:latest```

### Build & run locally

   - ```git clone https://github.com/salinaaaaaa/koopjs.git```
  
   - ```docker build -t koopjs .```

   - ```docker run --rm -it -d -v "${PWD}:/usr/src/" -p 8080:8080 -p 9000:9000 -p 80:80 koopjs```

TODO: Add worker farm for GDAL tiles -> https://www.npmjs.com/package/worker-farm

------------------------------

## Kubernetes/Helm Deployment

   - ```helm install koopjs helm/ --values koopjs/values.yaml```

#### Override values.yaml
   - ```helm install koopjs helm/ --set service.type=ClusterIP --set service.port=80```

#### Get default value NodePorts from KoopJS

   - ```export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services koopjs)```

   - ```export NODE_IP=$(kubectl get nodes --namespace deault -o jsonpath="{.items[0].status.addresses[0].address}")```

   - ```echo http://$NODE_IP:NODE_PORT```
