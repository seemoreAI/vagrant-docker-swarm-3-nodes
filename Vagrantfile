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
            
            node.vm.provision "shell", path: "docker-setup.sh"
            node.vm.provision "shell", path: "other-steps.sh"

            # Инициализиране на Docker Swarm
            if i == 1
                # Само за docker1 (Мениджър)
                node.vm.provision "shell", path: "swarm-manager.sh"
            else
                # За docker2 и docker3 (Работници)
                node.vm.provision "shell", path: "swarm-worker.sh"
            end
            
        end
    end
end