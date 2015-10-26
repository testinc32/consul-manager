#!/usr/bin/env ruby

# needs CONSUL_URI
# needs CONSUL_TOKEN

require_relative "../lib/configure.rb"
require "yaml"

export_file = ARGV.fetch(0) { fail "Please provide file name" }
export_file = ROOT_DIR + export_file

fail "Export file \"#{export_file}\" does not exist" unless File.exist?(export_file)

export_data = YAML.load(File.read(export_file))

namespace = Pathname(export_data["namespace"])

puts "Found #{export_data["data"].size} keys to export to #{namespace}"

export_data["data"].each do |k, v|
  path = namespace + k
  Diplomat::Kv.put(path, v)
  putc "."
end

puts "\nDONE\n"
