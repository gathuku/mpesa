# frozen_string_literal: true

require 'base64'

module Mpesa
  class StkQuery < Resource
    PATH = 'mpesa/stkpushquery/v1/query'

    def call
      Object.new post_request(url: PATH, body: body).body
    end

    def body
      {
        'BusinessShortCode': shortcode,
        'Password': password,
        'Timestamp': timestamp,
        'CheckoutRequestID': args[:checkout_request_id]
      }
    end

    def password
      Base64.strict_encode64("#{shortcode}#{args[:pass_key] || client.pass_key}#{timestamp}")
    end

    def timestamp
      Time.now.strftime('%Y%m%d%H%M%S')
    end

    def shortcode
      args[:shortcode] || client.shortcode
    end
  end
end
