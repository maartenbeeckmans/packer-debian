#!/bin/bash -eux

### WARNING: DO NOT FORGET TO REMOVE IT IF ACCESSIBLE FROM OUTSIDE !!!

function add_vagrant_key {
    homedir=$(su - $1 -c 'echo $HOME')
    mkdir -p $homedir/.ssh
    curl -L 'https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub' -o $homedir/.ssh/authorized_keys
    chown -Rf $1. $homedir/.ssh
    chmod 700 $homedir/.ssh
    chmod 600 $homedir/.ssh/authorized_keys
}

if [ $(grep -c vagrant /etc/passwd) == 0 ] ; then
    useradd vagrant -m
    echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
    sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
fi

# Add public key to vagrant user
add_vagrant_key vagrant

