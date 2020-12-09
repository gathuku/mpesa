# frozen_string_literal: true

require 'test_helper'
class MpesamainTest < Minitest::Test
  # Test Get access Token

  def test_configured
    refute_nil Mpesa.configuration.confirmation_url
  end

  def test_access_token
    VCR.use_cassette('access_token') do
      response = Mpesa.access_token
      assert_equal(200, response.status)
    end
  end

  # Test Register urls
  def test_register_urls
    VCR.use_cassette('register_urls') do
      response = Mpesa.register_urls
      assert_equal(200, response.status)
    end
  end

  # Test B2C payouts
  def test_b2c_payout
    VCR.use_cassette('b2c_payout') do
      response = Mpesa.payout(amount: 100, phone: '254705112855',
                              command_id: 'BusinessPayment', remarks: 'paid')
      assert_equal(200, response.status)
    end
  end

  # Test STK
  def test_stk
    VCR.use_cassette('stk_push') do
      response = Mpesa.stk_push(amount: 100, phone: '254705112855')
      assert_equal(200, response.status)
    end
  end

  # Test call
  def test_call
    assert Mpesa.respond_to?(:call)
  end
end
