module Mpesa
  class Status < Resource
    PATH = 'mpesa/transactionstatus/v1/query'
    def call
      Object.new post_request(url: PATH, body: body).body
    end

    def body
      {

      }
    end
  end
end
