# frozen_string_literal: true

require 'mpesa/version'
require 'mpesa/mpesamain'
require 'uri'
require 'faraday'
require 'json'

module Mpesa
  class Error < StandardError; end
  # Your code goes here...
  class << self
    attr_accessor :configuration

    # Configure method
    def configure
      @configuration ||= Configuration.new
      yield(configuration)
    end

    # Reset to load defaults
    def reset
      @configuration = Configuration.new
    end
  end
end

# Configuration class
class Configuration
  attr_accessor :confirmation_url, :validation_url,
                :shortcode, :paybil, :initiator_username,
                :timeout_url, :result_url
  def initialize
    @confirmation_url = '/confirm'
    @validation_url = '/validate'
    @shortcode = '171837'
  end
end
