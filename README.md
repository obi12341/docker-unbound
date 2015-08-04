Unbound (with DNSSEC validation)
===========
[![](https://badge.imagelayers.io/writl/unbound:latest.svg)](https://imagelayers.io/?images=writl/unbound:latest 'Get your own badge on imagelayers.io')

# Running

Just use this command to start the container. Unbound will listen on port 53/udp.

```docker run --name unbound -d -p 53:53/udp -p 53:53 writl/unbound:1.5.4-1```

# Configuration
These options can be set:

- **DO_IPV6**: Enable or disable ipv6. (Default: "yes", Possible Values: "yes, no")
- **VERBOSITY**: verbosity number, 0 is least verbose. (Default: "0", Possible Values: "0, 1, 2, 3, ...")
- **NUM_THREADS**: number of threads to create. 1 disables threading. (Default: "1", Possible Values: "1, 2, 3, ..."
