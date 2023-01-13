# frozen_string_literal: true

require 'active_support/cache'
require 'active_support/cache/memory_store'
require 'active_support/notifications'

module Mpesa
  class Token < Resource
    def token
      if cache.exist?('token')
        expires_at = cache.send(:read_entry, 'token')&.expires_at
        Object.new({
                     "access_token": cache.fetch('token'),
                     "expires_in": expires_at - Time.now.to_f
                   })
      else
        cache_token
      end
    end

    def cache_token
      res = call
      cache.write('token', res.access_token, expires_in: res.expires_in)
      res
    end

    def call
      res = get_request(url: 'oauth/v1/generate?grant_type=client_credentials', basic_auth: true)
      raise Error, res.reason_phrase if res.body.empty?
      Object.new(res.body)
    end

    def cache
      @cache ||= ActiveSupport::Cache::MemoryStore.new
    end
  end
end
