#!/usr/bin/env bash
vagranthome="$(df | grep vagrant | grep -i psf | cut -d'%' -f2 | sed 's/ //g')"
if [ "$vagranthome" == "" ]
then
vagranthome="$(df | grep vagrant | grep -v -i psf | cut -d'%' -f2 | sed 's/ //g')"
fi

$vagranthome/bootstrap.sh

sudo mkdir /etc/puppetlabs/facter/facts.d/ -p
sudo echo "master01ipaddress: $(cat $vagranthome/master01.ipaddress)" > /etc/puppetlabs/facter/facts.d/facts.yaml
sudo echo "role: dsslave" >> /etc/puppetlabs/facter/facts.d/facts.yaml
sleep 60
sudo echo "swarm_token: $(cat $vagranthome/swarm.token)" >> /etc/puppetlabs/facter/facts.d/facts.yaml

sudo /opt/puppetlabs/bin/puppet apply $vagranthome/puppet/site.pp 
