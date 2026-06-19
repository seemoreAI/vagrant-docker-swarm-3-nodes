#!/bin/bash
# Взимаме името на текущата машина (docker2 или docker3) за лога
HOSTNAME=$(hostname -s)

echo "* Joining $HOSTNAME to the Swarm cluster ..."

# Изчакваме мениджърът да запише токена в споделената папка
while [ ! -f /vagrant/worker_token.txt ]; do
  sleep 1
done

# Четем токена и се присъединяваме към мениджъра
TOKEN=$(cat /vagrant/worker_token.txt)
docker swarm join --token $TOKEN 192.168.99.151:2377