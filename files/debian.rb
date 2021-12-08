# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define "default" do |node|
    node.vm.box = "${box_basename}"
    node.vm.boot_timeout = 1800
    node.vm.synced_folder ".", "/vagrant", disabled: true
    node.vm.box_check_update = true

    node.vm.provider :libvirt do |lv|
      lv.disk_bus = "virtio"
      lv.driver = "kvm"
      lv.video_ram = 256
      lv.cpus = 1
      lv.memory = 1024
    end
  end
end
