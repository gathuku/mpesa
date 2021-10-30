# frozen_string_literal: true

module Mpesa
  class Reversal < Resource
    PATH = 'mpesa/reversal/v1/request'

    def call
      Object.new post_request(url: PATH, body: body).body
    end

    def body
      {
        "Initiator": args[:initiator_username],
        "SecurityCredential": credentials,
        "CommandID": 'TransactionReversal',
        "TransactionID": args[:transaction_id],
        "Amount": args[:amount],
        "ReceiverParty": args[:receiver],
        "RecieverIdentifierType": args[:receiver_type],
        "Remarks": args[:remarks] || 'check status',
        "QueueTimeOutURL": args[:timeout_url],
        "ResultURL": args[:result_url],
        "Occasion": args[:occasion] || 'check status'
      }
    end

    def credentials
      SecurityCred.new(args[:initiator_password], client.env).password_credential
    end
  end
end
