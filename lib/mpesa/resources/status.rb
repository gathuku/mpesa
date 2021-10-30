# frozen_string_literal: true

module Mpesa
  class Status < Resource
    PATH = 'mpesa/transactionstatus/v1/query'
    def call
      Object.new post_request(url: PATH, body: body).body
    end

    def body
      {
        "CommandID": 'TransactionStatusQuery',
        "PartyA": args[:shortcode] || client.shortcode,
        "IdentifierType": args[:identifier_type],
        "Remarks": args[:remarks] || 'check status',
        "Initiator": args[:initiator_username],
        "SecurityCredential": credentials,
        "QueueTimeOutURL": args[:timeout_url],
        "ResultURL": args[:result_url],
        "TransactionID": args[:transaction_id],
        "Occasion": args[:occasion] || 'check status'
      }
    end

    def credentials
      SecurityCred.new(args[:initiator_password], client.env).password_credential
    end
  end
end
