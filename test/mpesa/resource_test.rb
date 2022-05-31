# frozen_string_literal: true

require 'test_helper'
require 'faraday'

class ResourceTest < Minitest::Test

  def setup
    @conn = Faraday.new do |builder|
      builder.response :json, content_type: 'application/json'
      builder.adapter :test do |stub|
        stub.get("/") do |env|
          [
            401,
            { 'Content-Type': 'application/json' },
            '{"errorMessage": "wrong credentials"}'
          ]
        end
      end
    end

  end

  def test_should_return_254_formatted_number
    resource = Mpesa::Resource.new('client')
    invalid_numbers = %w[0701234567 +254701234567 701234567]
    expected_format = '254701234567'
    invalid_numbers.each do |number|
      assert_equal expected_format, resource.format_phone(number)
    end
  end

  def test_should_raise_error_by_default
    client = Mpesa::Client.new(key: '', secret: '')
    resource = Mpesa::Resource.new(client)

    assert client.raise_errors
    err = assert_raises do
      resource.handle_response(@conn.get("/"))
    end
    assert_equal 'You did not supply valid authentication credentials. wrong credentials', err.message
  end

  def test_should_not_raise_error_if_disabled
    client = Mpesa::Client.new(key: '', secret: '', raise_errors: false)
    resource = Mpesa::Resource.new(client)
    response = resource.handle_response(@conn.get("/"))
    refute client.raise_errors
    assert_equal 401, response.status
    assert_equal "wrong credentials", response.body['errorMessage']
  end
end
