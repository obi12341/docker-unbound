# Running

```
docker-compose up -d
```
or
```
docker run --name=unbound -d \
--restart=always \
-e UPSTREAM_DNS1=8.8.8.8 \
-e UPSTREAM_DNS2=8.8.4.4 \
-p 53:53 \
-p 53:53/udp \
ryanckoch/unbound-forwarder
```
