# frozen_string_literal: true

require "experian_address_validation"
require "dotenv"
require "vcr"
require "bundler/setup"

require_relative "support/helpers/client_helper"

Dotenv.load("env.test", "env.example")

VCR.configure do |c|
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
  c.cassette_library_dir = "spec/support/fixtures/vcr_cassettes"
  c.allow_http_connections_when_no_cassette = true
  c.default_cassette_options = { match_requests_on: [:uri] }

  # Filter senstive test credentials from VCR interaction.
  c.filter_sensitive_data("<AUTH_TOKEN>") { ENV["AUTH_TOKEN"] }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
