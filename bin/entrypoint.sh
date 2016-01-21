#!/bin/bash

UPSTREAM_DNS1=${UPSTREAM_DNS1:-8.8.8.8}
UPSTREAM_DNS1=${UPSTREAM_DNS1:-8.8.4.4}
DO_IPV6=${DO_IPV6:-yes}
DO_IPV4=${DO_IPV4:-yes}
DO_UDP=${DO_UDP:-yes}
DO_TCP=${DO_TCP:-yes}
VERBOSITY=${VERBOSITY:-0}
NUM_THREADS=${NUM_THREADS:-1}
SO_RCVBUFF=${SO_RCVBUFF:-0}
SO_SNDBUF=${SO_SNDBUF:-0}
SO_REUSEPORT=${SO_REUSEPORT:-no}
EDNS_BUFFER_SIZE=${EDNS_BUFFER_SIZE:-4096}
MSG_CACHE_SIZE=${MSG_CACHE_SIZE:-4m}
RRSET_CACHE_SIZE=${RRSET_CACHE_SIZE:-4m}
CACHE_MIN_TTL=${CACHE_MIN_TTL:-0}
CACHE_MAX_TTL=${CACHE_MAX_TTL:-86400}
CACHE_MAX_NEGATIVE_TTL=${CACHE_MAX_NEGATIVE_TTL:-3600}
HIDE_IDENTITY=${HIDE_IDENTITY:-no}
HIDE_VERSION=${HIDE_VERSION:-no}
STATISTICS_INTERVAL=${STATISTICS_INTERVAL:-0}
STATISTICS_CUMULATIVE=${STATISTICS_CUMULATIVE:-no}
EXTENDED_STATISTICS=${EXTENDED_STATISTICS:-no}

sed 's/{{UPSTREAM_DNS1}}/'"${UPSTREAM_DNS1}"'/' -i /etc/unbound/unbound.conf
sed 's/{{UPSTREAM_DNS2}}/'"${UPSTREAM_DNS2}"'/' -i /etc/unbound/unbound.conf
sed 's/{{DO_IPV6}}/'"${DO_IPV6}"'/' -i /etc/unbound/unbound.conf
sed 's/{{DO_IPV4}}/'"${DO_IPV4}"'/' -i /etc/unbound/unbound.conf
sed 's/{{DO_UDP}}/'"${DO_UDP}"'/' -i /etc/unbound/unbound.conf
sed 's/{{DO_TCP}}/'"${DO_TCP}"'/' -i /etc/unbound/unbound.conf
sed 's/{{VERBOSITY}}/'"${VERBOSITY}"'/' -i /etc/unbound/unbound.conf
sed 's/{{NUM_THREADS}}/'"${NUM_THREADS}"'/' -i /etc/unbound/unbound.conf
sed 's/{{SO_RCVBUFF}}/'"${SO_RCVBUFF}"'/' -i /etc/unbound/unbound.conf
sed 's/{{SO_SNDBUF}}/'"${SO_SNDBUF}"'/' -i /etc/unbound/unbound.conf
sed 's/{{SO_REUSEPORT}}/'"${SO_REUSEPORT}"'/' -i /etc/unbound/unbound.conf
sed 's/{{EDNS_BUFFER_SIZE}}/'"${EDNS_BUFFER_SIZE}"'/' -i /etc/unbound/unbound.conf
sed 's/{{MSG_CACHE_SIZE}}/'"${MSG_CACHE_SIZE}"'/' -i /etc/unbound/unbound.conf
sed 's/{{RRSET_CACHE_SIZE}}/'"${RRSET_CACHE_SIZE}"'/' -i /etc/unbound/unbound.conf
sed 's/{{CACHE_MIN_TTL}}/'"${CACHE_MIN_TTL}"'/' -i /etc/unbound/unbound.conf
sed 's/{{CACHE_MAX_TTL}}/'"${CACHE_MAX_TTL}"'/' -i /etc/unbound/unbound.conf
sed 's/{{CACHE_MAX_NEGATIVE_TTL}}/'"${CACHE_MAX_NEGATIVE_TTL}"'/' -i /etc/unbound/unbound.conf
sed 's/{{HIDE_IDENTITY}}/'"${HIDE_IDENTITY}"'/' -i /etc/unbound/unbound.conf
sed 's/{{HIDE_VERSION}}/'"${HIDE_VERSION}"'/' -i /etc/unbound/unbound.conf
sed 's/{{STATISTICS_INTERVAL}}/'"${STATISTICS_INTERVAL}"'/' -i /etc/unbound/unbound.conf
sed 's/{{STATISTICS_CUMULATIVE}}/'"${STATISTICS_CUMULATIVE}"'/' -i /etc/unbound/unbound.conf
sed 's/{{EXTENDED_STATISTICS}}/'"${EXTENDED_STATISTICS}"'/' -i /etc/unbound/unbound.conf


exec "$@"
