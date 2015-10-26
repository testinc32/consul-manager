#!/usr/bin/env ruby

# needs CONSUL_URI
# needs CONSUL_TOKEN

require_relative "../lib/configure.rb"
require "yaml"

export_file = ARGV.fetch(0) { fail "Please provide file name" }
export_file = ROOT_DIR + export_file

fail "Export file \"#{export_file}\" does not exist" unless File.exist?(export_file)

data = YAML.load(File.read(export_file))

puts "Found #{data.size} keys to restore"

data.each do |entry|
  Diplomat::Kv.put(entry[:key], entry[:value])
  putc "."
end

puts "\nDONE\n"
