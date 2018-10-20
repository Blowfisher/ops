#!/bin/bash
#

docker stop test
docker rm test
docker run -it --name test -v $(pwd)/roles:/demo:rw ansible:1.0 
