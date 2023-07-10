# Golang API

## Running the API using Go

Clone the repo to your local machine and navigate to the directory you've cloned it to.

Run the following command to start the API server 
```bash
$ go run main.go
``` 

Navigate in your web browser to `localhost:80` to get the JSON response. Alternatively, run the following command to get the response in a terminal

```bash
$ curl localhost                  

{"message":"Automate all the things!","time":1688761073}
```

## Running the API using Docker

Clone the repo to your local machine and navigate to the directory you've cloned it to.

Run the following command to build the docker image locally

```bash
$ docker build . -t golang-api:latest
```

Run the following command to start the container and access it from your local machine

```bash
$ docker run -d -p 80:80 golang-api:latest
```

Navigate in your web browser to `localhost:80` to get the JSON response. Alternatively, run the following command to get the response in a terminal

```bash
$ curl localhost                  

{"message":"Automate all the things!","time":1688761073}
```

# Github Actions

A Github Actions workflow has been provided for this application. When any code is changed in the `app` directory, the action is triggered and the pipeline is run. The pipline lints and tests the code before packaging it into a container image for Snyk to scan. Snyk then scans the image for any security vulnerabilites. If the Snyk scan passes, the image is pushed to the GitHub Container Registry and tagged with the short-sha of the commit that built it.

After the new image is built, the final job uses helm to deploy the image to a cluster previously built inside the infra pipeline. This pipeline assumes that your cluster infrastructure was already built previously.