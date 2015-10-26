require "bundler/setup"
require "diplomat"
require "pathname"

ROOT_DIR = Pathname(File.expand_path("../../", __FILE__))

CONSUL_URI   = ENV.fetch("CONSUL_URI")   { fail "Please provide CONSUL_URI" }
CONSUL_TOKEN = ENV.fetch("CONSUL_TOKEN") { fail "Please provide CONSUL_TOKEN" }

Diplomat.configure do |config|
  config.url       = CONSUL_URI
  config.acl_token = CONSUL_TOKEN
end
