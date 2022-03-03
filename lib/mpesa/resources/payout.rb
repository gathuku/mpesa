# frozen_string_literal: true

module Mpesa
  class Payout < Resource
    PATH = 'mpesa/b2c/v1/paymentrequest'

    def call
      Object.new post_request(url: PATH, body: body).body
    end

    def body
      {
        'InitiatorName': args[:initiator_username],
        'SecurityCredential': credentials,
        'CommandID': args[:command_id],
        'Amount': args[:amount],
        'PartyA': client.shortcode || args[:shortcode],
        'PartyB': format_phone(args[:phone]),
        'Remarks': args[:remarks],
        'QueueTimeOutURL': args[:timeout_url],
        'ResultURL': args[:result_url],
        'Occasion': args[:occasion]
      }
    end

    def credentials
      SecurityCred.new(args[:initiator_password], client.env).password_credential
    end
  end
end
