from debian:wheezy

MAINTAINER SunChengCheng <sunchengcheng@useease.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo deb http://mirrors.163.com/debian wheezy main non-free contrib >/etc/apt/sources.list && \
	echo deb http://mirrors.163.com/debian wheezy-proposed-updates main contrib non-free >>/etc/apt/sources.list && \
	echo deb-src http://mirrors.163.com/debian wheezy main non-free contrib >>/etc/apt/sources.list && \
	echo deb-src http://mirrors.163.com/debian wheezy-proposed-updates main contrib non-free >>/etc/apt/sources.list && \
	echo deb http://mirrors.163.com/debian-security wheezy/updates main contrib non-free >>/etc/apt/sources.list && \
	echo deb-src http://mirrors.163.com/debian-security wheezy/updates main contrib non-free >>/etc/apt/sources.list && \
	apt-get update && \
	apt-get install -y wget python ipython less net-tools vim-tiny sudo openssh-server && \
	rm -rf /var/lib/apt/lists/*

ENV SCALA_VERSION 2.11.2
ENV CDH_VERSION cdh4
ENV JAVA_HOME /opt/java
ENV SCALA_HOME /opt/scala
ENV SPARK_HOME /opt/spark
ENV PATH $SPARK_HOME/bin:$SCALA_HOME/bin:$JAVA_HOME/bin:$PATH
ENV SPARK_WORKER_PORT 8888

RUN ["useradd", "spark"]
ADD runspark /
ENTRYPOINT ["/runspark"]
USER spark

