Vagrant.configure("2") do |config|
  config.vm.box = "gusztavvargadr/windows-11"

  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
    v.cpus = 4
    v.name = "tools-mingw-clang-#{Time.now.to_i}"
  end

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provision "file", source: "./playbook.yml", destination: "/vagrant/"

  config.vm.provision "shell", path: "install.ps1"
end
