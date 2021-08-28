module Mpesa
  class Payout
    PATH = 'mpesa/stkpush/v1/processrequest'.freeze

    def call
      Object.new post_request(url: PATH, body: body).body
    end

    def body
      {
        'InitiatorName': params['initiator_username'],
        'SecurityCredential': credentials,
        'CommandID': params['command_id'],
        'Amount': params['amount'],
        'PartyA': params['shorcode'],
        'PartyB': params['phone'],
        'Remarks': params['remarks'],
        'QueueTimeOutURL': param[:timeout_url],
        'ResultURL': params['result_url'],
        'Occasion': params['occasion']
      }
    end

    def credentials
      SecurityCred.new(password).password_credential
    end
  end
end
