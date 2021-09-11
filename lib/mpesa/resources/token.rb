require 'active_support/cache'
require 'active_support/cache/memory_store'
require 'active_support/notifications'

module Mpesa
  class Token < Resource
    def token
      if cache.exist?('token')
        cache.fetch('token')
      else
        cache_token
      end
    end

    def cache_token
      res = call
      cache.write('token', res.access_token, expires_in: res.expires_in)
      token
    end

    def call
      Object.new get_request(url: 'oauth/v1/generate?grant_type=client_credentials', basic_auth: true).body
    end

    def cache
      ActiveSupport::Cache::MemoryStore.new
    end
  end
end
