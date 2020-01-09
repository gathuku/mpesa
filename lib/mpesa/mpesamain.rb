# frozen_string_literal: true

require 'token'
# Main logic
# extends Mpesa module
module Mpesa
  class << self
    # @base_url = if Mpesa.configuration.env == 'sanbox'
    #               'https://sandbox.safaricom.co.ke'
    #             else
    #               'https://api.safaricom.co.ke'
    #             end

    # Get access Token
    def access_token
      path = '/oauth/v1/generate?grant_type=client_credentials'
      base_url = Mpesa.configuration.base_url
      key = Mpesa.configuration.key
      secret = Mpesa.configuration.secret
      conn = Faraday.new(url: base_url + path) do |req|
        req.adapter Faraday.default_adapter
        req.basic_auth(key, secret)
      end
      conn.get
    end

    # Register C2B URLs
    def register_urls
      path = '/mpesa/c2b/v1/registerurl'
      body = {
        'ShortCode': Mpesa.configuration.paybill,
        'ResponseType': 'Completed',
        'ConfirmationURL': Mpesa.configuration.confirmation_url,
        'ValidationURL': Mpesa.configuration.validation_url
      }

      call(path: path, body: body)
    end

    # Send B2C payouts
    def payout(amount:, phone:, command_id:, remarks:)
      path = '/mpesa/b2c/v1/paymentrequest'
      body = {
        'InitiatorName': Mpesa.configuration.initiator_username,
        'SecurityCredential': Mpesa.configuration.security_credential,
        'CommandID': command_id,
        'Amount': amount,
        'PartyA': Mpesa.configuration.paybill,
        'PartyB': phone,
        'Remarks': remarks,
        'QueueTimeOutURL': Mpesa.configuration.timeout_url,
        'ResultURL': Mpesa.configuration.result_url,
        'Occasion': '' # optional
      }
      call(path: path, body: body)
    end

    # LIPA NA Mpesa Online
    def stk_push(amount:, phone:, ref: 'Payment', desc: 'Payment')
      shortcode = Mpesa.configuration.lnmo_shortcode
      lipa_na_mpesa_key = Mpesa.configuration.lipa_na_mpesa_key
      timestamp = Time.now.strftime('%Y%m%d%H%M%S').to_i
      password = Base64.encode64("#{shortcode}#{lipa_na_mpesa_key}#{timestamp}")
      path = '/mpesa/stkpush/v1/processrequest'
      body = {
        'BusinessShortCode': Mpesa.configuration.lnmo_shortcode,
        'Password': password.split("\n").join,
        'Timestamp': timestamp.to_s,
        'TransactionType': 'CustomerPayBillOnline',
        'Amount': amount,
        'PartyA': phone,
        'PartyB': Mpesa.configuration.lnmo_shortcode,
        'PhoneNumber': phone,
        'CallBackURL': Mpesa.configuration.lnmocallback,
        'AccountReference': ref,
        'TransactionDesc': desc
      }

      call(path: path, body: body)
    end

    def call(path:, body:)
      base_url = Mpesa.configuration.base_url
      token = Token.new.call
      headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer #{token}"
      }
      Faraday.post(base_url + path, body.to_json, headers)
    end
  end
end
