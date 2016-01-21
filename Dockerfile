FROM alpine:3.3

MAINTAINER ryanckoch@gmail.com

RUN apk add --update bash unbound

ADD conf/unbound.conf /etc/unbound/unbound.conf

RUN chown -R unbound:unbound /etc/unbound/


ADD bin/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 53/udp
EXPOSE 53

CMD ["/usr/sbin/unbound", "-c", "/etc/unbound/unbound.conf", "-d", "-v"]

ENTRYPOINT ["/entrypoint.sh"]
