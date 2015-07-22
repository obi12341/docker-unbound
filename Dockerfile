FROM ubuntu:14.04
MAINTAINER patrick@oberdorf.net

RUN apt-get update
RUN apt-get install -y \
	build-essential \
	tar \
	wget \
	libssl-dev \
	libexpat1-dev \
	dnsutils

RUN wget http://www.unbound.net/downloads/unbound-1.5.4.tar.gz -P /usr/local/src/
WORKDIR /usr/local/src/
ADD assets/sha256checksum sha256checksum
RUN sha256sum -c sha256checksum
RUN tar -xvf unbound-1.5.4.tar.gz
WORKDIR /usr/local/src/unbound-1.5.4
RUN ./configure --prefix=/usr/local && make && make install

RUN useradd --system unbound
ENV PATH $PATH:/usr/local/lib
RUN ldconfig
COPY assets/unbound.conf /usr/local/etc/unbound/unbound.conf
RUN chown -R unbound:unbound /usr/local/etc/unbound/
RUN sudo -u unbound unbound-anchor -a /usr/local/etc/unbound/root.key ; true


EXPOSE 53/udp
CMD ["/usr/local/sbin/unbound", "-c", "/usr/local/etc/unbound/unbound.conf", "-d", "-v"]
