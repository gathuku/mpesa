module Mpesa
  class Token < Resource
    def token
      Object.new get_request(url: 'oauth/v1/generate?grant_type=client_credentials', basic_auth: true).body
    end
  end
end
