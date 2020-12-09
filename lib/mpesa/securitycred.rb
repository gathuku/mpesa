# frozen_string_literal: true

require 'openssl'
require 'base64'

module Mpesa
  # Security Credentials
  class SecurityCred
    def initialize(pass)
      @initiator_password = pass
    end

    def password_credential
      raw = if Mpesa.configuration.env == 'production'
               File.read('lib/cert/production.pem')
             else
               File.read('lib/cert/sandbox.pem')
             end

      cert = OpenSSL::X509::Certificate.new(raw)
      key = cert.public_key
      Base64.strict_encode64(key.public_encrypt(@initiator_password))
    end
  end
end
