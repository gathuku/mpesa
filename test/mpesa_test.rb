require "test_helper"

class MpesaTest < Minitest::Test
def setup
  @data={
    'consumer_key':'aR7R09zePq0OSfOttvuQDrfdM4n37i0C',
    'consumer_secret':'F9AebI6azDlRjLiR',
    'confirmation_url':'https://524317db.ngrok.io/confirm',
    'validation_url': 'https://524317db.ngrok.io/validate'
  }
end

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
end
