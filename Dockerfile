FROM alpine:3.5

RUN apk add --update bash unbound && \
    rm -rf /tmp/* /var/cache/apk/*

ADD conf/unbound.conf /etc/unbound/unbound.conf
ADD bin/entrypoint.sh /entrypoint.sh

RUN chown -R unbound:unbound /etc/unbound/ && \
    chmod +x /entrypoint.sh

EXPOSE 53/udp
EXPOSE 53

CMD ["/usr/sbin/unbound", "-c", "/etc/unbound/unbound.conf", "-d", "-v"]

ENTRYPOINT ["/entrypoint.sh"]
