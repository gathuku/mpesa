# frozen_string_literal: true

# Main logic
module Mpesa
  class << self
    @base_url = if Mpesa.configuration.env == 'sanbox'
                  'https://sandbox.safaricom.co.ke'
                else
                  'https://api.safaricom.co.ke'
                end

    # Get access Token
    def access_token
      path = '/oauth/v1/generate?grant_type=client_credentials'

      conn = Faraday.new(url: @base_url + path) do |req|
        req.adapter Faraday.default_adapter
        req.basic_auth(@config.consumer_key, @config.consumer_secret)
      end
      conn.get
      # JSON.parse(conn.get)['access_token']
    end

    # Register C2B URLs
    def register_urls
      path = '/mpesa/c2b/v1/registerurl'
      body = {
        'ResponseType': 'Completed',
        'ConfirmationUrl': Mpesa.configuration.confirmation_url,
        'ValidationUrl': Mpesa.configuration.validation_url
      }
      call(path: path, body: body)
    end

    # Send B2C payouts
    def payout(amount:, phone:, command_id:, remarks:)
      path = 'b2c/v1/paymentrequest'
      body = {
        'InitiatorName': Mpesa.configuration.initiator_username,
        'SecurityCredential': '',
        'CommandID': command_id,
        'Amount': amount,
        'PartyA': Mpesa.configuration.paybill,
        'PartyB': phone,
        'Remarks': remarks,
        'QueueTimeOutURL': Mpesa.configuration.timeout_url,
        'ResultURL': Mpesa.configuaration.result_url,
        'Occasion': '' # optional
      }

      call(path: path, body: body)
    end

    # LIPA NA Mpesa Online
    def stk_push(amount:, phone:, ref: 'Payment', desc: 'Payment')
      shortcode = Mpesa.configuration.shortcode
      lipa_na_mpesa_key = Mpesa.configuration.lipa_na_mpesa_key
      timestamp = Time.now.strftime('%Y%m%d%H%M%S')
      password = Base64.encode(shortcode + lipa_na_mpesa_key + timestamp)
      path = 'stkpush/v1/processrequest'
      body = {
        'BusinessShortCode': '',
        'Password': password,
        'Timestamp': '',
        'TransactionType': 'CustomerPayBillOnline',
        'Amount': amount,
        'PartyA': phone,
        'PartyB': Mpesa.configuration.shorcode,
        'PhoneNumber': phone,
        'CallBackURL': Mpesa.configuration.lnmocallback,
        'AccountReference': ref,
        'TransactionDesc': des
      }

      call(path: path, body: body)
    end

    def call(path:, body:)
      headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer #{JSON.parse(Mpesa.access_token)['access_token']}"
      }

      Faraday.post(@base_url + path, body.to_json, headers)
    end
  end
end
