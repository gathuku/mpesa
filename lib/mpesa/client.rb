# frozen_string_literal: true

require 'faraday'

module Mpesa
  class Client
    attr_reader :key, :secret, :env, :adapter, :shortcode, :pass_key, :raise_errors

    def initialize(key:, secret:, shortcode: nil, pass_key: nil, env: 'production', adapter: Faraday.default_adapter, raise_errors: true)
      @key = key
      @secret = secret
      @env = env
      @adapter = adapter
      @pass_key = pass_key
      @shortcode = shortcode
      @raise_errors = raise_errors
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

    def status(**args)
      Status.new(self, args).call
    end

    def balance(**args)
      Balance.new(self, args).call
    end

    def reversal(**args)
      Reversal.new(self, args).call
    end

    def connection(basic_auth: false)
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = "https://#{subdomain}.safaricom.co.ke"
        conn.request :json
        conn.response :json, content_type: 'application/json'
        conn.adapter adapter
        conn.request :authorization, :basic, key, secret if basic_auth
        conn.request :authorization, 'Bearer', auth.access_token unless basic_auth
      end
    end

    def subdomain
      env == 'production' ? 'api' : 'sandbox'
    end
  end
end
