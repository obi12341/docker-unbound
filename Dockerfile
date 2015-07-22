FROM ubuntu:14.04
MAINTAINER patrick@oberdorf.net

RUN apt-get update && apt-get install -y \
	build-essential \
	tar \
	wget \
	libssl-dev \
	libexpat1-dev \
	dnsutils \
	&& apt-get clean

WORKDIR /usr/local/src/
ADD assets/sha256checksum sha256checksum
RUN wget http://www.unbound.net/downloads/unbound-1.5.4.tar.gz -P /usr/local/src/ \
	&& sha256sum -c sha256checksum \
	&& tar -xvf unbound-1.5.4.tar.gz \
	&& rm unbound-1.5.4.tar.gz \
	&& cd unbound-1.5.4 \
	&& ./configure --prefix=/usr/local \
	&& make \
	&& make install \
	&& cd ../ \
	&& rm -R unbound-1.5.4

RUN useradd --system unbound
ENV PATH $PATH:/usr/local/lib
RUN ldconfig
COPY assets/unbound.conf /usr/local/etc/unbound/unbound.conf
RUN chown -R unbound:unbound /usr/local/etc/unbound/
RUN sudo -u unbound unbound-anchor -a /usr/local/etc/unbound/root.key ; true


EXPOSE 53/udp
CMD ["/usr/local/sbin/unbound", "-c", "/usr/local/etc/unbound/unbound.conf", "-d", "-v"]
