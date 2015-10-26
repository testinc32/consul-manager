#!/usr/bin/env ruby

# needs CONSUL_URI
# needs CONSUL_TOKEN

require_relative "../lib/configure.rb"
require "yaml"
require "time"
require "fileutils"

DUMP_DIR = ROOT_DIR + "dump/kv/"

FileUtils.mkdir_p(DUMP_DIR)

puts "Dumping KV"

timestamp = Time.now.strftime("%Y%m%d-%H%M%S")

dump = Diplomat::Kv.get("", :recurse => true)

File.open(DUMP_DIR + "consul-kv-#{timestamp}.yml", "w+") do |f|
  f.write(dump.to_yaml)
end

puts "Dumped #{dump.count} keys"
puts "\nDONE\n"
