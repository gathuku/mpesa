require "configuration"
require 'net/http'
require 'net/https'
require 'uri'

module Mpesa
  class Mpesamain

    def get_access_token
        uri = URI('https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials')
        Net::HTTP.start(uri.host, uri.port,
    :use_ssl => uri.scheme == 'https',
    :verify_mode => OpenSSL::SSL::VERIFY_NONE)

    request = Net::HTTP::Get.new uri.request_uri
    request.basic_auth Configuration.consumer_key, Configuration.consumer_secret

    response = http.request request # Net::HTTPResponse object

    puts response
    puts response.body

    end

  end
end
