# frozen_string_literal: true

require 'openssl'
require 'base64'

module Mpesa
  # Security Credentials
  class SecurityCred
    attr_reader :initiator_password, :env

    def initialize(pass, env)
      @initiator_password = pass
      @env = env
    end

    def password_credential
      raw = if env == 'production'
              File.read(File.join(File.dirname(__FILE__), '../cert/production.pem'))
            else
              File.read(File.join(File.dirname(__FILE__), '../cert/sandbox.pem'))
            end

      cert = OpenSSL::X509::Certificate.new(raw)
      key = cert.public_key
      Base64.strict_encode64(key.public_encrypt(initiator_password))
    end
  end
end
