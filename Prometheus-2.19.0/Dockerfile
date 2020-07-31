FROM centos:7
# version 20.0

#0) Set SOURCE_PATH and PROMETHEUS_FOLDER/VERSION
ENV SOURCE_PATH /usr/local/src
ENV PROMETHEUS_FOLDER prometheus-2.19.0.linux-amd64
ENV PROM_VERSION prometheus-2.19.0

#1) Add prometheus user 
RUN useradd --no-create-home --shell /bin/false prometheus

#2) Update and Install necessary packages through yum in CentOS
RUN yum -y update; yum clean all
RUN yum -y install systemd; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

#3) Copy prometheus tar.gz file into container path
COPY $PROMETHEUS_FOLDER.tar.gz $SOURCE_PATH

#4) Change working directory
WORKDIR $SOURCE_PATH

#5) Unzip prometheus tar.gz file and copy executable sh file
RUN tar -xzvf prometheus-2.19.0.linux-amd64.tar.gz; \
cp prometheus-2.19.0.linux-amd64/prometheus /usr/local/bin; \
cp prometheus-2.19.0.linux-amd64/promtool /usr/local/bin; \
chown prometheus:prometheus /usr/local/bin/prometheus /usr/local/bin/promtool; \

#6) Create directory using prometheus
mkdir /etc/prometheus /var/lib/prometheus; \
chown prometheus:prometheus /etc/prometheus /var/lib/prometheus; \

#7) Copy prometheus config file to /etc/prometheus path
cp prometheus-2.19.0.linux-amd64/prometheus.yml /etc/prometheus; \

#8) Copy folder using prometheus 
cp -r prometheus-2.19.0.linux-amd64/consoles /etc/prometheus; \
cp -r prometheus-2.19.0.linux-amd64/console_libraries /etc/prometheus; \

#9) Change config file and folder owner 
chown prometheus:prometheus /etc/prometheus/prometheus.yml; \
chown -R prometheus:prometheus /etc/prometheus/consoles /etc/prometheus/console_libraries;

#10) Copy prometheus.service file to container
COPY prometheus.service /etc/systemd/system/prometheus.service

#11) Connect host Volumn and Docker Volumn 
VOLUME ["/sys/fs/cgroup"]

#12) prometheus expose port (default : 9090)
EXPOSE 9090

#13) start prometheus
RUN systemctl start prometheus;systemctl enable prometheus

CMD ["/usr/sbin/init"]
