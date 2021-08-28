module Mpesa
  class Stk < Resource
    PATH = 'mpesa/stkpush/v1/processrequest'

    def call
      Object.new post_request(url: PATH, body: body).body
    end

    def body
      {
        'BusinessShortCode': params[:shortcode],
        'Password': password,
        'Timestamp': timestamp.to_s,
        'TransactionType': 'CustomerPayBillOnline',
        'Amount': params[:amount],
        'PartyA': params[:phone],
        'PartyB': params[:shorcode],
        'PhoneNumber': params[:phone],
        'CallBackURL': params[:callback_url],
        'AccountReference': params[:ref],
        'TransactionDesc': params[:desc]
      }
    end

    def password
      Base64.strict_encode64("#{params[:shortcode]}#{params[:stk_key]}#{timestamp}")
    end

    def timestamp
      Time.now.strftime('%Y%m%d%H%M%S').to_i
    end
  end
end
