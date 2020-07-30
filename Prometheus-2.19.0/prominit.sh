#! /bin/bash

docker rm -f promethues
docker rmi -f prometheus
docker build -t prometheus --no-cache .
docker run --privileged --name promethues -p 9090:9090 -itd -v /sys/fs/cgroup:/sys/fs/cgroup prometheus /usr/sbin/init
