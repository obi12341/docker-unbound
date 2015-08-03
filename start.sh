#!/bin/bash

DO_IPV6=${DO_IPV6:-yes}
VERBOSITY=${VERBOSITY:-0}
NUM_THREADS=${NUM_THREADS:-1}

sed 's/{{DO_IPV6}}/'"${DO_IPV6}"'/' -i /usr/local/etc/unbound/unbound.conf
sed 's/{{VERBOSITY}}/'"${VERBOSITY}"'/' -i /usr/local/etc/unbound/unbound.conf
sed 's/{{NUM_THREADS}}/'"${NUM_THREADS}"'/' -i /usr/local/etc/unbound/unbound.conf

/usr/local/sbin/unbound -c /usr/local/etc/unbound/unbound.conf -d -v
