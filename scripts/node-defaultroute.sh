#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

ip route replace default via 192.168.100.2
ip route del default via 10.0.2.2


