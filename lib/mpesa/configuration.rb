#require "mpesa"
module Mpesa
  class Configuration
    attr_accessor :mpesa_env,:consumer_key, :consumer_secret, :paybil,
                   :lipa_na_mpesa, :validation_url, :confirmation_url

      def initialize
        @mpesa_env=nil
        @consumer_key=nil
        @consumer_secret=nil
        @paybil=nil
        @lipa_na_mpesa=nil
        @validation_url = nil
        @confirmation_url =nil
      end

  end
end
