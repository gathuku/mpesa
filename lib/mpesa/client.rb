require 'faraday'
require 'faraday_middleware'

module Mpesa
  class Client
    attr_reader :key, :secret, :env, :adapter, :shortcode, :stk_key

    def initialize(key:, secret:, shortcode: nil, stk_key: nil, env: 'production', adapter: Faraday.default_adapter)
      @key = key
      @secret = secret
      @env = env
      @adapter = adapter
      @stk_key = stk_key
      @shortcode = shortcode
    end

    def auth
      Token.new(self).token
    end

    def register(**args)
      Register.new(self, args).call
    end

    def stk(**args)
      Stk.new(self, args).call
    end

    def payout(**args)
      Payout.new(self, args).call
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
