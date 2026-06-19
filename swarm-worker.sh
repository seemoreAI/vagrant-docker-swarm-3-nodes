#!/bin/bash
HOSTNAME=$(hostname -s)

echo "=== Присъединяване на $HOSTNAME към Swarm клъстера ==="

# Изчакване на токена в споделената папка
while [ ! -f /vagrant/worker_token.txt ]; do
  sleep 1
done

# Извличане на точното IP на текущия нод от частната мрежа
MY_IP=$(hostname -I | awk '{print $2}')

# Четене на токена и свързване
TOKEN=$(cat /vagrant/worker_token.txt)
docker swarm join --token $TOKEN --advertise-addr $MY_IP 192.168.99.151:2377