require "mpesa/version"
require "mpesa/configuration"
require "mpesa/mpesamain"
module Mpesa
  class Error < StandardError; end
  # Your code goes here...
class << self
  attr_accessor :configuration
end

def self.configuration
  @configuration ||= Configuration.new
end

def self.reset
  @configuration = Configuration.new
end

def self.configure
  yield(configuration)
end

def self.access_key
  Mpesamain.get_access_token
end
end
