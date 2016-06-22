#!/usr/bin/env ruby
require '/ruby-processcli-helper.rb'
$zk_pid = nil
CONFLUENT_HOME = '/confluent-2.0.0'

def start_service
  puts "-> starting zookeeper"
  $zk_pid = running_daemon "#{CONFLUENT_HOME}/bin/zookeeper-server-start #{CONFLUENT_HOME}/etc/kafka/zookeeper.properties"
  check_socket_live '127.0.0.1', 2181
  puts "-> zookeeper started"
end

def stop_service
  puts "-> stopping zookeeper"
  kill_process $zk_pid
  puts "-> zookeeper stopped"
end

def signal_handler sig
  raise Interrupt
end

include Helper::ProcessCLI

add_stop_exception Interrupt
run!


