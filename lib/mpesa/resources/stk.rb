# frozen_string_literal: true

require 'base64'

module Mpesa
  class Stk < Resource
    PATH = 'mpesa/stkpush/v1/processrequest'

    def call
      Object.new post_request(url: PATH, body: body).body
    end

    def body
      {
        'BusinessShortCode': shortcode,
        'Password': password,
        'Timestamp': timestamp.to_s,
        'TransactionType': 'CustomerPayBillOnline',
        'Amount': args[:amount],
        'PartyA': args[:phone],
        'PartyB': shortcode,
        'PhoneNumber': args[:phone],
        'CallBackURL': args[:callback_url],
        'AccountReference': args[:reference],
        'TransactionDesc': args[:trans_desc]
      }
    end

    def password
      Base64.strict_encode64("#{shortcode}#{args[:pass_key] || client.pass_key}#{timestamp}")
    end

    def timestamp
      Time.now.strftime('%Y%m%d%H%M%S').to_i
    end

    def shortcode
      args[:shortcode] || client.shortcode
    end
  end
end
