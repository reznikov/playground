Vagrant.configure("2") do |config|
  config.vm.define "homelab"
  config.vm.box = "bento/ubuntu-20.04"

  config.vm.synced_folder ".",
                          "/vagrant",
                          disabled: true

  config.vm.synced_folder "templates/",
                          "/home/vagrant/templates",
                          create: true,
                          disabled: false

  config.vm.synced_folder "dist/",
                          "/home/vagrant/dist",
                          create: true,
                          disabled: false

  config.vm.provision "env",
                      type: "shell",
                      :path => "provisioners/env.sh",
                      privileged: false

  config.vm.provision "image",
                      type: "shell",
                      :path => "provisioners/image.sh",
                      privileged: false,
                      env: {
                          "USERNAME" => "reznikov",
                          "HOSTNAME" => "homelab"
                      }
end
