# frozen_string_literal: true

require 'test_helper'
class ClientTest < MpesaTest
  def test_access_token
    # skip
    VCR.use_cassette('access_token') do
      response = @client.auth
      refute_nil response.access_token
    end
  end

  def test_register_urls
    # skip
    VCR.use_cassette('register_urls') do
      response = @client.register(
        shortcode: '600998',
        confirmation_url: 'http://test.com',
        validation_url: 'http://test.com'
      )
      refute_nil response.OriginatorCoversationID
    end
  end

  # Test B2C payouts
  def test_b2c_payout
    # skip
    VCR.use_cassette('b2c_payout') do
      response = @client.payout(
        initiator_username: 'testapi',
        initiator_password: 'Safaricom998!',
        command_id: 'BusinessPayment',
        phone: '254708374149',
        amount: '100',
        result_url: 'https://example.com/result',
        timeout_url: 'https://example.com/result',
        occasion: 'some desc',
        remarks: 'remarks'
      )

      refute_nil response.ConversationID
    end
  end

  # Test STK
  def test_stk
    # skip
    VCR.use_cassette('stk_push') do
      response = @client.stk(
        shortcode: '174379',
        amount: '10',
        phone: '0705112855',
        callback_url: 'https://test.com',
        reference: 'REF',
        trans_desc: 'desc'
      )
      refute_nil response.CheckoutRequestID
    end
  end

  def test_stk_transaction_type
    # skip
    payload = {
      shortcode: '174379',
      amount: '10',
      phone: '0705112855',
      callback_url: 'https://test.com',
      reference: 'REF',
      trans_desc: 'desc'
    }
    resource = Mpesa::Stk.new(@client, payload)
    assert_equal 'CustomerPayBillOnline', resource.body[:TransactionType], 'should default to a paybill transaction'
    assert_equal payload[:shortcode], resource.body[:PartyB]

    resource = Mpesa::Stk.new(@client, payload.merge({ till_no: '379174' }))
    assert_equal 'CustomerBuyGoodsOnline', resource.body[:TransactionType],
                 'should initiate a till payment if till_no provided'
    assert_equal '379174', resource.body[:PartyB]
  end

  def test_status
    skip
    # Gateway timeout issue
    VCR.use_cassette('status') do
      response = @client.status(
        shortcode: '600426',
        transaction_id: 'OEI2AK4Q16',
        identifier_type: 1,
        initiator_username: 'testapi',
        initiator_password: 'Safaricom426!',
        timeout_url: 'https://example.com/result',
        result_url: 'https://example.com/result'
      )
      refute_nil response.ConversationID
      assert_equal '0', response.ResponseCode
    end
  end

  def test_reversal
    skip
    # Under maintenance
    VCR.use_cassette('reversal') do
      response = @client.reversal(
        initiator_password: 'Safaricom426!',
        initiator_username: 'testapi',
        transaction_id: 'OEI2AK4Q16',
        amount: '100',
        receiver: '600610',
        receiver_type: '4',
        timeout_url: 'https://example.com/result',
        result_url: 'https://example.com/result'
      )

      refute_nil response.OriginatorConversationID
      assert_equal '0', response.ResponseCode
    end
  end
end
