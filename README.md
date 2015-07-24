Unbound (with DNSSEC validation)
===========
[![](https://badge.imagelayers.io/writl/unbound:latest.svg)](https://imagelayers.io/?images=writl/unbound:latest 'Get your own badge on imagelayers.io')

# Running

Just use this command to start the container. Unbound will listen on port 53/udp.

```docker run --name unbound -d -p 53:53/udp -p 53:53 writl/unbound:1.5.4```

# Configuration
These options can be set:

- **DO_IPV6**: Enable or disable ipv6. (Default: "yes", Possible Values: "yes, no")
