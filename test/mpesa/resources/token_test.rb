require 'test_helper'
require 'active_support/testing/time_helpers'

class TokenTest < MpesaTest
  include ActiveSupport::Testing::TimeHelpers

  def test_it_can_cache
    cache = Mpesa::Token.new(@client).cache
    cache.write('test', 'test')
    assert_equal 'test', cache.fetch('test')
  end

  def test_it_can_cache_token
    token_instance = Mpesa::Token.new(@client)
    token_instance.cache_token

    assert token_instance.cache.exist?('token')

    travel 3500 do
      refute_nil token_instance.cache.fetch('token')
      assert token_instance.cache.exist?('token')
    end

    travel 3600 do
      assert_nil token_instance.cache.fetch('token')
      refute token_instance.cache.exist?('token')
    end
  end
end
