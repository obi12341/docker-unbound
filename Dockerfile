FROM ubuntu:trusty
MAINTAINER patrick@oberdorf.net

WORKDIR /usr/local/src/
ADD assets/sha256checksum sha256checksum

RUN apt-get update && apt-get install -y \
	build-essential \
	tar \
	wget \
	libssl-dev \
	libexpat1-dev \
	dnsutils \
	&& wget http://www.unbound.net/downloads/unbound-1.5.4.tar.gz -P /usr/local/src/ \
        && sha256sum -c sha256checksum \
        && tar -xvf unbound-1.5.4.tar.gz \
        && rm unbound-1.5.4.tar.gz \
        && cd unbound-1.5.4 \
        && ./configure --prefix=/usr/local \
        && make \
        && make install \
        && cd ../ \
        && rm -R unbound-1.5.4 \
	&& apt-get remove -y \
	build-essential \
	libssl-dev \
	libexpat1-dev \
	&& apt-get autoremove --purge -y \
	&& apt-get clean

RUN useradd --system unbound
ENV PATH $PATH:/usr/local/lib
RUN ldconfig
ADD assets/unbound.conf /usr/local/etc/unbound/unbound.conf
RUN chown -R unbound:unbound /usr/local/etc/unbound/
RUN sudo -u unbound unbound-anchor -a /usr/local/etc/unbound/root.key ; true
RUN sudo -u unbound unbound-control-setup
RUN sudo -u unbound wget ftp://FTP.INTERNIC.NET/domain/named.cache -O /usr/local/etc/unbound/root.hints

ADD start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 53/udp
EXPOSE 53

CMD ["/start.sh"]
