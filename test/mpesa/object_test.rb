# frozen_string_literal: true

require 'test_helper'

class ObjectTest < Minitest::Test
  def test_it_convert_hash_to_struct
    response = { status: 200, message: 'Hello' }

    refute_nil Mpesa::Object.new(response).status
  end
end
