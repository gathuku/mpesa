require "mpesa/configuration"
require 'net/http'
require 'net/https'
require 'uri'
require 'faraday'


  class Mpesamain

    def initialize
      @config=Mpesa::Configuration.new
      @config.consumer_key = "aR7R09zePq0OSfOttvuQDrfdM4n37i0C"
      @config.consumer_secret="F9AebI6azDlRjLiR"
      @uri =URI('https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials')
    end

    def get_access_token
        uri = URI('https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials')
    #   http=  Net::HTTP.start(uri.host, uri.port,
    # :use_ssl => uri.scheme == 'https',
    # :verify_mode => OpenSSL::SSL::VERIFY_NONE)
    #
    # request = Net::HTTP::Get.new uri.request_uri
    # request.basic_auth @config.consumer_key, @config.consumer_secret
    #
    # response= http.request request # Net::HTTPResponse object
    # puts response
    # puts response.body
    conn= Faraday.new(url:uri) do |req|
      req.adapter Faraday.default_adapter
      req.basic_auth(@config.consumer_key, @config.consumer_secret)
    end

    res=conn.get
    puts res.body

    end

  end
