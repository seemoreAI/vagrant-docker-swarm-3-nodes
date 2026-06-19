#!/bin/bash
echo "=== Инициализиране на Swarm Manager на docker1 ==="
docker swarm init --advertise-addr 192.168.99.151

echo "=== Записване на токена за работниците ==="
docker swarm join-token worker -q > /vagrant/worker_token.txt

echo "=== Създаване на Docker Secret за базата данни ==="
echo '12345' | docker secret create db_root_password -

echo "=== Стартиране на производствения стек (Stack Deploy) ==="
docker stack deploy -c /vagrant/docker-compose-swarm.yaml bgapp