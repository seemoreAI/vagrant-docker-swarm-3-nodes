#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "* Add hosts ..."
echo "192.168.99.151 docker1.do1.lab docker1" >> /etc/hosts
echo "192.168.99.152 docker2.do1.lab docker2" >> /etc/hosts
echo "192.168.99.153 docker3.do1.lab docker3" >> /etc/hosts

echo "* Install Additional Packages ..."
apt-get install -y jq tree git vim