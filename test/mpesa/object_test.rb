require 'test_helper'

class ObjectTest < Minitest::Test
  def test_it_convert_hash_to_struct
    response = { status: 200, message: 'Hello' }

    parsed_response = Mpesa::Object.new(response)
    refute_nil parsed_response.status
  end
end
