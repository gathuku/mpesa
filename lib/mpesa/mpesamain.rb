require "mpesa/configuration"
require 'uri'
require 'faraday'
require 'json'


  class Mpesamain

    def initialize
      @config=Mpesa::Configuration.new
      @config.consumer_key = "aR7R09zePq0OSfOttvuQDrfdM4n37i0C"
      @config.consumer_secret="F9AebI6azDlRjLiR"
      @config.confirmation_url ="https://524317db.ngrok.io/mpesa"
      @config.validation_url = "https://524317db.ngrok.io/mpesa"
      @uri =URI('https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials')
    end

    def get_access_token
        uri = URI('https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials')
        conn= Faraday.new(url:uri) do |req|
          req.adapter Faraday.default_adapter
          req.basic_auth(@config.consumer_key, @config.consumer_secret)
        end
        conn.get
        #JSON.parse(conn.get)['access_token']
    end

    def register_urls
       url = URI('https://sandbox.safaricom.co.ke/mpesa/c2b/v1/registerurl')
       body={
         'ResponseType': 'Completed',
         'ConfirmationUrl': @config.confirmation_url,
         'ValidationUrl': @config.validation_url
       };
      headers={
        'Accept':'application/json',
        'Content-Type':'application/json',
        'Authorization': 'Bearer #{get_access_token}'
      }
      Faraday.post(url,body,headers)
    end

  end
