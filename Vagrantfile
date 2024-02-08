Vagrant.configure("2") do |config|
  config.vm.box = "gusztavvargadr/windows-11"

  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
    v.cpus = 4
    v.name = "tools-mingw-clang-#{Time.now.to_i}"
  end
  # Synced folder configuration
  config.vm.synced_folder "/home/caselman/code", "/vagrant_code", type: "virtualbox"

  config.vm.provision "shell", path: "install.ps1"
end
