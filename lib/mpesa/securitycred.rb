# frozen_string_literal: true

require 'openssl'
require 'base64'

module Mpesa
  # Security Credentials
  class SecurityCred
    def initialize(pass)
      @intitiator_password = pass
    end

    def password_credential
      cert = if Mpesa.configuration.env == 'production'
               File.read('lib/cert/production.pem')
             else
               File.read('lib/cert/sandbox.pem')
             end

      key = OpenSSL::PKey::RSA.new(cert)
      Base64.strict_encode_64(key.public_encrypt(@initiator_password.bytes))
    end
  end
end
