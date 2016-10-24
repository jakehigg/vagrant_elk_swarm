#!/bin/bash

vagranthome="$(df | grep vagrant | grep -i psf | cut -d'%' -f2 | sed 's/ //g')"
if [ "$vagranthome" == "" ]
then
vagranthome="$(df | grep vagrant | grep -v -i psf | cut -d'%' -f2 | sed 's/ //g')"
fi

sudo mkdir /etc/puppetlabs/facter/facts.d/ -p
sudo echo "role: dsmaster" >> /etc/puppetlabs/facter/facts.d/facts.yaml
sudo echo "datacenter: mydatacenter" >> /etc/puppetlabs/facter/facts.d/facts.yaml

$vagranthome/bootstrap.sh

sudo /opt/puppetlabs/bin/puppet apply $vagranthome/puppet/site.pp
sleep 90 
sudo /opt/puppetlabs/bin/puppet apply $vagranthome/puppet/services.pp
sleep 90
sudo /opt/puppetlabs/bin/puppet apply $vagranthome/puppet/logstash.pp
