require "test_helper"

class MpesaTest < Minitest::Test
  @data={
    'consumer_key':'aR7R09zePq0OSfOttvuQDrfdM4n37i0C',
    'consumer_secret':'F9AebI6azDlRjLiR',
    'confirmation_url':'https://524317db.ngrok.io/confirm',
    'validation_url': 'https://524317db.ngrok.io/validate'
  }
  def test_that_it_has_a_version_number
    refute_nil ::Mpesa::VERSION
  end

  def test_it_returns_access_token
      url = URI('https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials')
      stub_request(:get,url).
      with(basic_auth(@data.consumer_key,@data.consumer_secret)).
      to_return(status:200,body:"",headers:{})

      assert_equal 200, Mpesa.register_urls
  end
end
