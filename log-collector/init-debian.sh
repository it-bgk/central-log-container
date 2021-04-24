#!/bin/sh

apt update
apt upgrade -y
apt install -y screen sudo cron-apt rsyslog git
apt remove sshd
ssh-keygen -t ecdsa
git clone git@github.com:it-bgk/central-log-container.git
###
