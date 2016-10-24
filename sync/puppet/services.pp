node default {
if $::role == 'dsmaster' {

exec { 'elasticsearch':
command    => '/usr/bin/docker service create --name elasticsearch --replicas 1 --network my-net --publish 9200:9200 --publish 9300:9300 --mount type=bind,source=/vagrant/sharedstorage/elasticsearch/,dst=/usr/share/elasticsearch/data/ elasticsearch:latest elasticsearch -Des.network.host=0.0.0.0',
unless     => '/usr/bin/docker service ls | /bin/grep "elasticsearch"',
} ->

exec { 'kibana':
command    => '/usr/bin/docker service create --name kibana --replicas 1 --network my-net --publish 5601:5601 --mount type=bind,source=/vagrant/sharedstorage/config/kibana/,dst=/opt/kibana/config/ kibana:latest',
unless     => '/usr/bin/docker service ls | /bin/grep "kibana"',
} 


}
} 
