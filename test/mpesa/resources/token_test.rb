require 'test_helper'

class TokenTest < MpesaTest
  def test_it_can_cache
    cache = Token.new(@client).cache
    cache.write('test', 'test')
    assert_equal 'test', cache.fetch('test')
  end

  def test_it_can_cache_token
    token_instance = Token.new(@client)
    cache = token_instance.cache
    token_instance.cache_token
    refute_nil cache.fetch('token')
    assert cache.exist?('token')

    travel 3500 do
      refute_nil cache.fetch('token')
      assert cache.exist?('token')
    end

    travel 3600 do
      assert_nil cache.fetch('token')
      refute cache.exist?('token')
    end
  end
end
