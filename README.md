# Prometheus-Grafana

This is a group of Prometheus & Grafana Docker files with versions for HyperFrame Open Edition.

### Prerequisites

Docker 19.03.12 (This is a workspace's version, other versions might be compatiable with this.)

### Set up Info
1) OS : CentOS 7
2) Prometheus : Prometheus 2.19.0
3) Grafana : Grafana 7.0.5

### Installing

1. Check your desired state of an image you will create.

    : Grafana version / Proemtheus version / OS version

2. Download a Dockerfile you want(Proemtheus or Grafana)
#### 1. Build an Docker Image
```bash
$ docker build -t <create image_name>:<image_version> .
```
#### 2. Generate a Container from Image
```bash
# Prometheus Default Port : 9090
# Grafana Default Port : 3000
$ docker run  -itd -p <Host_Port>:<Default_Port> <image_name>:<image_version> --name <container_name> --privileged -v /sys/fs/cgroup:/sys/fs/cgroup /usr/sbin/init
```

## License

This project is licensed under the Apache-2.0
