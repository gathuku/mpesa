#require "mpesa"
module Mpesa
  class Configuration
    attr_accessor :mpesa_env,:consumer_key, :consumer_secret, :paybil,
                   :lipa_na_mpesa

      def initialize
        @mpesa_env=nil
        @consumer_key=nil
        @consumer_secret=nil
        @paybil=nil
      end

  end
end
