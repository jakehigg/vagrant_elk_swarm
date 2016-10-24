#!/bin/bash
vagranthome="$(df | grep vagrant | grep -i psf | cut -d'%' -f2 | sed 's/ //g')"
if [ "$vagranthome" == "" ]
then
vagranthome="$(df | grep vagrant | grep -v -i psf | cut -d'%' -f2 | sed 's/ //g')"
fi
hostname="$(hostname)"

rm $vagranthome/$hostname.ipaddress
hostname -I | cut -f1 -d' ' > $vagranthome/$hostname.ipaddress

sudo /opt/puppetlabs/bin/puppet module install garethr-docker
sudo /opt/puppetlabs/bin/puppet module install KyleAnderson/consul
sudo /opt/puppetlabs/bin/puppet module install puppet-nginx
