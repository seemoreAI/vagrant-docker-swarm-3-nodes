#!/bin/bash
echo "* Initializing Docker Swarm Manager on docker1 ..."
# Инициализираме Swarm през IP адреса от частната мрежа
docker swarm init --advertise-addr 192.168.99.151

echo "* Saving worker join token to shared folder ..."
# Взимаме чистия токен и го записваме в споделената папка /vagrant
docker swarm join-token worker -q > /vagrant/worker_token.txt