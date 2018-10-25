#!/bin/bash
#

docker stop test &>/dev/null
docker rm test &>/dev/null
docker run -it --name test -v $(pwd)/roles:/demo:rw ansible:1.0 
