# Cucumber tests
## Pre-requisites
Maestrano, Connec, Dolibarr, SimpleInvoices running locally

$ cd cucumber
$ rake features

# Docker Containers
## Build a docker image
$ sudo docker build -t "test_image" docker/

## Run an image in a container
$ sudo docker run -t -i --name=test_container 09d0e29d5da2 /bin/bash