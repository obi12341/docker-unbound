Unbound (with DNSSEC validation)
===========

# Running

Just use this command to start the container. Unbound will listen on port 53/udp.

```docker run --name unbound -d -p 53:53/udp -p 53:53 writl/unbound```

# Configuration
These options can be set:

- **DO_IPV6**: Enable or disable ipv6. (Default: "yes", Possible Values: "yes, no")
