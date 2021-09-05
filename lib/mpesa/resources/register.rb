module Mpesa
  class Register < Resource
    PATH = 'mpesa/c2b/v1/registerurl'.freeze

    def call
      Object.new post_request(url: PATH, body: body).body
    end

    def body
      {
        'ShortCode': args[:shortcode],
        'ResponseType': 'Completed',
        'ConfirmationURL': args[:confirmation_url],
        'ValidationURL': args[:validation_url]
      }
    end
  end
end
