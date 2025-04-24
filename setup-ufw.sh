#!/bin/bash

# Reset UFW and set defaults
ufw --force reset
ufw default deny incoming
ufw default allow outgoing

# Allow loopback traffic
ufw allow in on lo
ufw allow out on lo
ufw allow in on lo from ::1 to ::1
ufw allow out on lo from ::1 to ::1

# Deny internal localhost (IPv4 and IPv6)
ufw deny from 127.0.0.0/8
ufw deny from ::1

# Allow specific services
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow from {{ yourIP }}

# Allow IPv6 loopback services
ufw allow in on lo from ::1
ufw allow out on lo to ::1

# Blocklist IPs/Subnets (IPv4)
for ip in \
    216.32.180.0/23 213.199.180.128/26 213.199.154.0/24 208.86.203.0/24 \
    208.86.202.0/24 208.84.66.0/24 208.84.65.0/24 207.46.163.0/24 \
    207.46.100.0/24 157.56.112.0/24 157.56.110.0/23 157.55.234.0/24 \
    148.163.156.0/23 146.112.255.0/24 146.112.63.0/24 146.112.62.0/24 \
    146.112.59.0/24 104.47.0.0/17 94.245.120.64/26 67.231.158.0/24 \
    67.231.151.0/24 67.231.149.0/24 67.231.148.0/24 67.231.147.0/24 \
    67.231.146.0/24 67.231.145.0/24 67.231.144.0/24 65.55.169.0/24 \
    65.55.88.0/24 52.238.78.88 52.100.0.0/14 40.107.0.0/17 \
    40.92.0.0/14 23.103.200.0/22 23.103.144.0/20 23.103.136.0/21 \
    23.103.132.0/22; do
    ufw deny from $ip
done

# Blocklist IPv6
for ip6 in \
    2a04:e4c7:ffff::/48 2a04:e4c7:fffe::/48 2a01:111:f403::/48 \
    2a01:111:f400:fc00::/54 2a01:111:f400:7c00::/54; do
    ufw deny from $ip6
done

# Enable UFW
ufw enable
