# frozen_string_literal: true

require 'test_helper'

class ResourceTest < Minitest::Test
  def test_should_return_254_formatted_number
    resource = Mpesa::Resource.new("client")
    invalid_numbers = %w[0701234567 +254701234567 701234567]
    expected_format = '254701234567'
    invalid_numbers.each do |number|
      assert_equal expected_format, resource.format_phone(number)
    end
  end
end