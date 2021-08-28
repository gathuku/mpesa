require 'faraday'
require 'faraday_middleware'

module Mpesa
  class Client
    attr_reader :key, :secret, :env, :adapter

    def initialize(key:, secret:, env: 'production', adapter: Faraday.default_adapter)
      @key = key
      @secret = secret
      @env = env
      @adapter = adapter
    end

    def auth
      Token.new(self).token
    end

    def register(**params)
      Register.new(self, params).call
    end

    def connection(basic_auth: false)
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = "https://#{subdomain}.safaricom.co.ke"
        conn.request :json
        conn.response :json, content_type: 'application/json'
        conn.adapter adapter
        conn.basic_auth key, secret if basic_auth
        conn.request :authorization, :Bearer, auth.access_token unless basic_auth
      end
    end

    def subdomain
      env == 'production' ? 'api' : 'sandbox'
    end
  end
end
