FROM ubuntu:jammy
MAINTAINER patrick@oberdorf.net

ENV VERSION 1.17.1

WORKDIR /usr/local/src/
ADD assets/sha256checksum sha256checksum

RUN apt update && apt install -y \
	build-essential \
	tar \
	wget \
	libssl-dev \
	libevent-dev \
	libevent-2.1-7 \
	libexpat1-dev \
	libexpat1 \
	dnsutils \
	&& wget http://www.unbound.net/downloads/unbound-${VERSION}.tar.gz -P /usr/local/src/ \
	&& sha256sum -c sha256checksum \
	&& tar -xvf unbound-${VERSION}.tar.gz \
	&& rm unbound-${VERSION}.tar.gz \
	&& cd unbound-${VERSION} \
	&& ./configure --prefix=/usr/local --with-libevent \
	&& make \
	&& make install \
	&& cd ../ \
	&& rm -R unbound-${VERSION} \
	&& apt purge -y \
	build-essential \
	gcc \
	gcc-12-base \
	cpp \
	libssl-dev \
	libevent-dev \
	libexpat1-dev \
	&& apt autoremove --purge -y \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd --system unbound --home /home/unbound --create-home
ENV PATH $PATH:/usr/local/lib
RUN ldconfig
ADD assets/unbound.conf /usr/local/etc/unbound/unbound.conf
RUN mkdir /usr/local/etc/unbound/conf.d
RUN chown -R unbound:unbound /usr/local/etc/unbound/

USER unbound
RUN unbound-anchor -a /usr/local/etc/unbound/root.key ; true
RUN unbound-control-setup \
	&& wget ftp://FTP.INTERNIC.NET/domain/named.cache -O /usr/local/etc/unbound/root.hints

USER root
ADD start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 53/udp
EXPOSE 53

CMD ["/start.sh"]
