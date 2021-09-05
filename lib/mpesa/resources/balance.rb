module Mpesa
  class Status < Resource
    PATH = 'mpesa/transactionstatus/v1/query'
    def call
      Object.new post_request(url: PATH, body: body).body
    end

    def body
      {
        'CommandID': 'TransactionStatusQuery',
        'PartyA': params['shortcode'],
        'IdentifierType': 4,
        'Remarks': params['remarks'],
        'Initiator': params['initiator_username'],
        'SecurityCredential': '',
        'QueueTimeOutURL': params['timeout_url'],
        'ResultURL': params['result_url'],
        'TransactionID': params['transaction_id'],
        'Occassion': params['occasion']
      }
    end
  end
end
