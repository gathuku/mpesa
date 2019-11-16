require "test_helper"

class MpesaTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Mpesa::VERSION
  end

  def test_it_returns_access_token

      stub_request(:get, "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials").
        with(
          headers: {
      	  'Authorization'=>'Basic YVI3UjA5emVQcTBPU2ZPdHR2dVFEcmZkTTRuMzdpMEM6RjlBZWJJNmF6RGxSakxpUg=='
          }).
        to_return(status: 200, body: "", headers: {})


      assert_equal(200, Mpesa.access_key.status)
  end

  def test_it_registers_urls
  stub_request(:post, "https://sandbox.safaricom.co.ke/mpesa/c2b/v1/registerurl").
   with(
     body: {"ConfirmationUrl"=>"https://524317db.ngrok.io/mpesa", "ResponseType"=>"Completed", "ValidationUrl"=>"https://524317db.ngrok.io/mpesa"},
     headers: {
 	  'Accept'=>'application/json',
 	  'Authorization'=>'Bearer #{get_access_token}',
 	  'Content-Type'=>'application/json',
     }).
   to_return(status: 200, body: "", headers: {})

    assert_equal(200, Mpesa.register_urls.status)
  end
end
