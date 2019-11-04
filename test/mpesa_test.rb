require "test_helper"

class MpesaTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Mpesa::VERSION
  end

  def test_it_does_something_useful
    assert true
  end
end
