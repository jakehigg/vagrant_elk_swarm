node default {

if $::role == 'dsmaster' {
package { 'unzip':
ensure => 'installed',
} ->

package { 'curl':
ensure => 'installed',
} ->

package { 'jq':
ensure => 'installed',
} ->

class { 'docker':
  tcp_bind        => "tcp://0.0.0.0:2375",
  socket_bind     => 'unix:///var/run/docker.sock',
  ip_forward      => true,
  iptables        => true,
  ip_masq         => true,
  #extra_parameters => "--cluster-store=consul://${$::ipaddress_eth0}:8500 --cluster-advertise=eth0:2375"
} -> 

exec { 'swarm-init':
command     => "/usr/bin/docker swarm init --advertise-addr ${$::ipaddress_eth0}",
unless      => '/usr/bin/docker info | /bin/grep "Is Manager: true"',
} ->

exec { 'swarm-token':
command    => '/usr/bin/docker swarm join-token --quiet worker > /vagrant/swarm-token',
} ->

docker_network { 'my-net':
  ensure   => present,
  driver   => 'overlay',
  subnet   => '192.168.3.0/24',
  gateway  => '192.168.3.1',
  ip_range => '192.168.3.4/28',
} 

}
if $::role == 'dsslave' {
package { 'curl':
ensure => 'installed',
} ->

package { 'jq':
ensure => 'installed',
} ->

class { 'docker':
  tcp_bind        => "tcp://0.0.0.0:2375",
  socket_bind     => 'unix:///var/run/docker.sock',
  ip_forward      => true,
  iptables        => true,
  ip_masq         => true,
#  bridge          => docker0,
#  fixed_cidr      => '10.10.30.0/24',
#  default_gateway => '10.10.30.1',
#  extra_parameters => "--cluster-store=consul://${$::master01ipaddress}:8500 --cluster-advertise=${ipaddress_eth0}:4000"
} -> 

exec { 'swarm-join':
command     => "/usr/bin/docker swarm join --token $(/bin/cat /vagrant/swarm-token) ${$::master01ipaddress}:2377",
unless      => '/usr/bin/docker info | /bin/grep "Swarm: active"',
}

}

if $::role == 'storage' {
 nfs::server::export{ '/data_folder':
   ensure  => 'mounted',
   clients => '*(rw,insecure,async,no_root_squash) localhost(rw)'
}



}


}
