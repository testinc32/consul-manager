#!/usr/bin/env ruby

# needs CONSUL_URI
# needs CONSUL_TOKEN

require_relative "../lib/configure.rb"
require "yaml"
require "time"

DUMP_DIR = ROOT_DIR + "dump/kv/"

FileUtils.mkdir_p(DUMP_DIR)

puts "Dumping ACL"

timestamp = Time.now.strftime("%Y%m%d-%H%M%S")

dump = Diplomat::Acl.list

File.open(DUMP_DIR + "consul-acl-#{timestamp}.yml", "w+") do |f|
  f.write(dump.to_yaml)
end

puts "Dumped #{dump.count} ACL entries"
puts "\nDONE\n"
