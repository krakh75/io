#!/bin/bash

# Install required packages
sudo apt install qemu-kvm libvirt-daemon-system -y &&
sudo apt-get install virt-manager -y &&
sudo apt install bridge-utils &&
sudo apt install -y cloud-image-utils

# Add user to necessary groups
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER

# Prepare directories
mkdir -p $HOME/kvm/base
mkdir -p $HOME/kvm/ionet

# Download base image
wget -P $HOME/kvm/base https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img

# Create virtual disk
qemu-img create -F qcow2 -b ~/kvm/base/focal-server-cloudimg-amd64.img -f qcow2 ~/kvm/ionet/ionet.qcow2 50G

# Generate MAC address
export MAC_ADDR=$(printf '52:54:00:%02x:%02x:%02x' $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))
echo $MAC_ADDR

# Set variables
export INTERFACE=ionet01
export IP_ADDR=192.168.122.101

# Create network config file
cat >network-config <<EOF
ethernets:
    $INTERFACE:
        addresses: 
        - $IP_ADDR/24
        dhcp4: false
        gateway4: 192.168.122.1
        match:
            macaddress: $MAC_ADDR
        nameservers:
            addresses: 
            - 1.1.1.1
            - 8.8.8.8
        set-name: $INTERFACE
version: 2
EOF

# Create user data file
cat >user-data <<EOF 
#cloud-config
hostname: ionet
manage_etc_hosts: true
users:
  - name: user
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    home: /home/user
    shell: /bin/bash
    lock_passwd: false
ssh_pwauth: true
disable_root: false
chpasswd:
  list: |
    user:user
  expire: false
EOF

# Create meta-data file
touch meta-data

# Generate seed image
cloud-localds -v --network-config=network-config ~/kvm/ionet/ionet-seed.qcow2 user-data meta-data

# Set permissions
sudo setfacl -m u:libvirt-qemu:rx $HOME
sudo setfacl -m u:libvirt-qemu:rx $HOME/kvm/
sudo setfacl -m u:libvirt-qemu:rx $HOME/kvm/base/
sudo setfacl -m u:libvirt-qemu:rx $HOME/kvm/ionet/

# Install the virtual machine
virt-install --connect qemu:///system --virt-type kvm --name ionet --ram 3072 --vcpus=2 --os-type linux --os-variant ubuntu20.04 --disk path=$HOME/kvm/ionet/ionet.qcow2,device=disk --disk path=$HOME/kvm/ionet/ionet-seed.qcow2,device=disk --import --network network=default,model=virtio,mac=$MAC_ADDR --noautoconsole --cpu qemu64

# List virtual machines
virsh list

# Open console for the new virtual machine
virsh console ionet
