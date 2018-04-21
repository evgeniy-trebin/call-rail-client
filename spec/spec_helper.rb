# frozen_string_literal: true

require 'codeclimate-test-reporter'
if ENV['CODECLIMATE_REPO_TOKEN']
  require 'simplecov'
  SimpleCov.start
end

require 'dotenv'
Dotenv.load
require 'pry-byebug'
require 'vcr'

require 'call_rail'

Dir[File.expand_path('support/*.rb', __dir__)].each { |f| require f }

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = false
  c.hook_into :webmock
  c.ignore_localhost = true
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.configure_rspec_metadata!
  c.debug_logger = $stdout if ENV.fetch('VCR_DEBUG', false)

  # c.before_record do |i|
  #   i.response.body.force_encoding('UTF-8')
  # end
  #
  # c.preserve_exact_body_bytes do |http_message|
  #   http_message.body.encoding.name == 'UTF-8' || !http_message.body.valid_encoding?
  # end

  c.default_cassette_options = {
    record: :once,
    match_requests_on: [
      :method, :body, VCR.request_matchers.uri_without_param(:ClientIp)
    ]
  }

  c.filter_sensitive_data('<CALL_RAIL_API_KEY>') { ENV.fetch('CALL_RAIL_API_KEY') }
  c.filter_sensitive_data('<CALL_RAIL_ACCOUNT_ID>') { ENV.fetch('CALL_RAIL_ACCOUNT_ID') }
end
