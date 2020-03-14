# frozen_string_literal: true

requre 'openssl'

module Mpesa
  class SecurityCred
    def initialize(pass:)
      @intitiator_password = pass
    end

    def password_credential
      path = if Mpesa.configuration.env == 'production'
               File.read(File.expand_path('./../cert/production.cer'))
               OPENSSL::Pkey::RSA.new(File.read(path))
             else
               File.read(File.expand_path('./../cert/sandbox.cer'))
             end

      key = OPENSSL::Pkey::RSA.new(File.read(path))
      key.public_encrypt(@initiator_password)
    end
   end
end
