#!/bin/bash

DO_IPV6=${DO_IPV6:-yes}

sed 's/{{DO_IPV6}}/'"${DO_IPV6}"'/' -i /usr/local/etc/unbound/unbound.conf

/usr/local/sbin/unbound -c /usr/local/etc/unbound/unbound.conf -d -v
