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
        'Timestamp': timestamp,
        'Amount': args[:amount],
        'PartyA': format_phone(args[:phone]),
        'PhoneNumber': format_phone(args[:phone]),
        'CallBackURL': args[:callback_url],
        'AccountReference': args[:reference],
        'TransactionDesc': args[:trans_desc]
      }.merge(transaction_details)
    end

    def transaction_details
      {
        'TransactionType': args[:till_no].present? ? 'CustomerBuyGoodsOnline' : 'CustomerPayBillOnline',
        'PartyB': args[:till_no] || shortcode
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
