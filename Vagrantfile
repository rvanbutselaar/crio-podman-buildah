# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# cpu = # cpu per VM
cpu = 2

#
# mem = MB ram per VM
#
mem = 2048

#
# Do not update guest utils on vms
#
# vbguest_auto_update = false

#
# project name will be used to generate hostnames: <project#{node_nr}>
#
project = 'crio'

#
# Check if config needs to be generated
#
if ARGV[0] == 'up' || ARGV[0] == 'reload'
  update_config = true
end

Vagrant.configure(2) do |config|
  #
  # vm specs
  #
  config.vm.provider "virtualbox" do |v|
    v.memory = mem
    v.cpus = cpu
  end

  #
  # Use insecure key
  config.ssh.insert_key = false
  #

  #
  # M = total masters to create
  # N = total nodes to create
  #
  N = 1

  #
  # Local username
  #
  $local_username ||= `whoami`

  #
  # Create master nodes
  #
  (1..N).each do | node_nr |
    hostname = project + "#{node_nr}"

    config.vm.define hostname do | node |
      # node.vbguest.auto_update = vbguest_auto_update
      node.vm.box = 'centos/7'
      node.vm.hostname = hostname

      #
      # Provision VMs using shell
      #
      node.vm.provision :shell, :path => "files/prepare-install.sh"
    end
  end
end
