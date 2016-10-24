node default {

exec { 'logstash':
command    => '/usr/bin/docker service create --name logstash --replicas 1 --network my-net --publish 5000:5000/udp logstash:latest logstash -e \'input { udp { port => 5000 } } output { elasticsearch { hosts => "elasticsearch:9200" } }\'',
unless     => '/usr/bin/docker service ls | /bin/grep "logstash"',
}

}
