#!/usr/bin/env bash

wget -O install_salt.sh http://bootstrap.saltstack.org
sudo sh install_salt.sh -M -P
yum -y install salt-api
yum -y install pyOpenSSL

cat <<EOF >/etc/salt/minion
master: salt
EOF

cat <<EOF >>/etc/hosts
192.168.37.10 salt
EOF

adduser saltapi
echo "saltapi:password" | sudo chpasswd

salt-call --local tls.create_self_signed_cert

cat <<EOF > /etc/salt/master.d/rest_cherrypy.conf
rest_cherrypy:
  port: 7443
  ssl_crt: /etc/pki/tls/certs/localhost.crt
  ssl_key: /etc/pki/tls/certs/localhost.key
EOF

cat <<EOF > /etc/salt/master.d/rest_auth.conf
external_auth:
  pam:
    saltapi:
      - .*
      - '@key'
EOF

mkdir -p /home/vagrant/bin
cat <<EOF > /home/vagrant/bin/slt
#!/bin/bash
sudo salt "$1*" ${@:2}
EOF

chmod +x /home/vagrant/bin/slt

iptables -I INPUT -p tcp -m multiport --dport 7443 -j ACCEPT
service iptables save

service salt-master restart
service salt-minion restart
chkconfig salt-api on
service salt-api start
