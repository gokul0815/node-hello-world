#!/bin/sh
docker ps -a awk '{ print \$1,\$2 }' grep gokuldevops/hello-world awk '{print \$1 }' xargs -I {} docker rm -f {}
docker run -d -p 8080:8080 gokuldevops/hello-world:latest