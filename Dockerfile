FROM ubuntu:jammy

ENV VERSION 1.21.0

WORKDIR /usr/local/src/
COPY assets/sha256checksum sha256checksum

RUN apt-get update && apt-get install -y \
  build-essential \
  tar \
  wget \
  libssl-dev \
  libevent-dev \
  libevent-2.1-7 \
  libexpat1-dev \
  libexpat1 \
  dnsutils \
  && wget --no-hsts http://www.unbound.net/downloads/unbound-${VERSION}.tar.gz -P /usr/local/src/ \
  && sha256sum -c sha256checksum \
  && tar -xvf unbound-${VERSION}.tar.gz \
  && rm unbound-${VERSION}.tar.gz \
  && cd unbound-${VERSION} \
  && ./configure --prefix=/usr/local --with-libevent \
  && make \
  && make install \
  && cd ../ \
  && rm -R unbound-${VERSION} \
  && apt-get purge -y \
  build-essential \
  gcc \
  cpp \
  libssl-dev \
  libevent-dev \
  libexpat1-dev \
  && apt-get autoremove --purge -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd --system unbound --home /home/unbound --create-home
ENV PATH $PATH:/usr/local/lib
RUN ldconfig
COPY assets/unbound.conf /usr/local/etc/unbound/unbound.conf
RUN mkdir /usr/local/etc/unbound/conf.d \
  && chown -R unbound:unbound /usr/local/etc/unbound/

USER unbound
RUN unbound-anchor -a /usr/local/etc/unbound/root.key ; true
RUN unbound-control-setup \
  && wget -q ftp://FTP.INTERNIC.NET/domain/named.cache -O /usr/local/etc/unbound/root.hints

USER root
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 53/udp
EXPOSE 53

CMD ["/start.sh"]
