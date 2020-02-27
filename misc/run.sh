#!/bin/bash

docker run -d --rm --name petclinic -p 8080:8080 -p 9090:9090 my-petclinic:latest