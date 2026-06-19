Vagrant.configure("2") do |config|

    config.vm.box="shekeriev/debian-13"
    config.vm.box_version = "13.5.20260608"

    1.upto(3) do |i|
        config.vm.define "docker#{i}" do |node|
            node.vm.hostname = "docker#{i}.do1.lab"
            node.vm.network "private_network", ip: "192.168.99.15#{i}"
            
            node.vm.provider :virtualbox do |vb|
                vb.customize ["modifyvm", :id, "--memory", "2048"]
            end
            
            # Базови инсталации
            node.vm.provision "shell", path: "docker-setup.sh"
            node.vm.provision "shell", path: "other-steps.sh"

            # Swarm Мениджър (Само за docker1)
            if i == 1
                node.vm.provision "shell", inline: <<-SHELL
                    echo "=== Инициализиране на Swarm Manager ==="
                    docker swarm init --advertise-addr 192.168.99.151
                    
                    # Записваме токена за работниците
                    docker swarm join-token worker -q > /vagrant/worker_token.txt
                    
                    echo "=== Създаване на Docker Secret за паролата ==="
                    echo '12345' | docker secret create db_root_password -
                    
                    echo "=== Стартиране на производствения стек ==="
                    # Swarm ще изчака работниците да се закачат и тогава ще разпредели контейнерите
                    docker stack deploy -c /vagrant/docker-compose-swarm.yaml bgapp
                SHELL
            end

            # Swarm Работници (За docker2 и docker3)
            if i > 1
                node.vm.provision "shell", inline: <<-SHELL
                    echo "=== Присъединяване на docker#{i} като Worker ==="
                    while [ ! -f /vagrant/worker_token.txt ]; do sleep 1; done
                    
                    MY_IP=$(hostname -I | awk '{print $2}')
                    TOKEN=$(cat /vagrant/worker_token.txt)
                    
                    docker swarm join --token $TOKEN --advertise-addr $MY_IP 192.168.99.151:2377
                SHELL
            end
            
        end
    end
end