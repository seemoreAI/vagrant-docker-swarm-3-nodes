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
            
            # 1. Базови стъпки (изпълняват се на ВСИЧКИ нодове)
            node.vm.provision "shell", path: "docker-setup.sh"
            node.vm.provision "shell", path: "other-steps.sh"

            # 2. Специфични Swarm стъпки
            if i == 1
                # Изпълнява се САМО на docker1
                node.vm.provision "shell", path: "swarm-manager.sh"
            else
                # Изпълнява се на docker2 и docker3
                node.vm.provision "shell", path: "swarm-worker.sh"
            end
            
        end
    end
end