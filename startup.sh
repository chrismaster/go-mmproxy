#!/bin/sh
ip rule add from 127.0.0.1/8 iif lo table 123
ip route add local 0.0.0.0/0 dev lo table 123
ip -6 rule add from ::1/128 iif lo table 123
ip -6 route add local ::/0 dev lo table 123

/go/go-mmproxy -l 127.0.0.1:$in_port -6 [::1]:$out_port -4 127.0.0.1:$out_port -v $logs -allowed-subnets /conf/allowed-subnets.txt
