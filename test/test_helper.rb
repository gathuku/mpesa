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
  config.ignore_request { false } # ENV['DISABLE_VCR']
  config.ignore_localhost = true
  config.default_cassette_options = {
    record: :new_episodes
  }
end

class MpesaTest < Minitest::Test
  def setup
    # Configure
    Mpesa.configure do |config|
      config.confirmation_url = 'https://980c7766.ngrok.io/api/confirmation_url'
      config.validation_url = 'https://980c7766.ngrok.io/api/validation_url'
      config.shortcode = '174379'
      config.paybill = '601380'
      config.initiator_username = 'testapi113'
      config.timeout_url = 'https://example.com/timeout'
      config.result_url = 'https://example.com/result'
      config.lnmocallback = 'https://example.com/lnmocallback'
      config.lipa_na_mpesa_key = ENV['MPESA_ONLINE_KEY']
      config.env = 'sandbox'
      config.base_url = 'https://sandbox.safaricom.co.ke'
      config.key = 'ZtkRW6ATbVtFpNml5w5SfG26Adfyagn9' # ENV['MPESA_KEY']
      config.secret = 'dosFI1yQ8bvHEVFw' # ENV['MPESA_SECRET']
    end
  end
end
