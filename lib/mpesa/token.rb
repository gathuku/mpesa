# frozen_string_literal: true

require 'redis'
require 'mpesamain'
# Access Token class
class Token
  @redis = Redis.new

  def initialize
    token = @redis.get('access_token')
    set_access_token if token.nil?
  end

  def call
    @redis.get('access_token')
  end

  def set_access_token
    token = JSON.parse(Mpesa.access_token.body)['access_token']
    @redis.setex('access_token', 3600, token)
  end
end
