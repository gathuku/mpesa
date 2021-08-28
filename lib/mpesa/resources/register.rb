module Mpesa
  class Register < Resource
    PATH = 'mpesa/c2b/v1/registerurl'.freeze

    def call
      Object.new post_request(url: PATH, body: body).body
    end

    def body
      {
        'ShortCode': params[:shortcode],
        'ResponseType': 'Completed',
        'ConfirmationURL': params[:confirmation_url],
        'ValidationURL': params[:validation_url]
      }
    end
  end
end
