# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'simplecov'
SimpleCov.start
require 'mpesa'

require 'minitest/autorun'
require 'webmock/minitest'

require 'minitest/reporters'
require 'coveralls'
require 'vcr'

# coverage
Coveralls.wear!

# minitest reporters
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# configure vcr
VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = false
  config.cassette_library_dir = File.expand_path('cassettes', __dir__)
  config.hook_into :webmock
  config.ignore_request { true } # ENV['DISABLE_VCR']
  config.ignore_localhost = true
  config.default_cassette_options = {
    record: :new_episodes
  }
end

class MpesaTest < Minitest::Test
  def setup
    @client = Mpesa::Client.new(
      key: 'ZtkRW6ATbVtFpNml5w5SfG26Adfyagn9',
      secret: 'dosFI1yQ8bvHEVFw',
      env: 'sandbox',
      shortcode: '600998',
      pass_key: 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919'
    )
  end
end
