#!/usr/bin/env bash

iptables -I INPUT -p tcp -m multiport --dport 4505,4506 -j ACCEPT
service iptables save

# wget -O install_salt.sh http://bootstrap.saltstack.org
# sh install_salt.sh -P

cat <<EOF >/etc/salt/minion
master: salt
EOF

cat <<EOF >>/etc/hosts
192.168.37.10 salt
EOF

service salt-minion restart
