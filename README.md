Unbound (with DNSSEC validation)
===========

Just use this command to start the container. Unbound will listen on port 53/udp.

```docker run --name unbound -p 53:53/udp writl/unbound```
