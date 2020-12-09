# Mpesa

Welcome to mpesa gem. The gem will help you integrate with mpesa daraja API very easily.

## Installation

Install from the command line
```
gem install mpesa --version "0.1.1" --source "https://rubygems.pkg.github.com/gathuku"
```
Install via `Gemfile`
```
source "https://rubygems.pkg.github.com/gathuku" do
  gem "mpesa", "0.1.1"
end
```


## Configuration
You will need to configure the gem with your own credentials.
```ruby
# reset previous Configuration
Mpesa.reset 

# configure
Mpesa.configure do |config|
  config.confirmation_url = 'https://7a5c955c.ngrok.io/api/confirmation_url'
  config.validation_url = 'https://7a5c955c.ngrok.io/api/validation_url'
  config.lnmo_shortcode = '174379'
  config.paybill = '601380'
  config.initiator_username = 'testapi113'
  config.timeout_url = 'https://example.com/timeout'
  config.result_url = 'https://example.com/result'
  config.lnmocallback = 'https://7a5c955c.ngrok.io/lnmocallback'
  config.lipa_na_mpesa_key = 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919' # ENV['MPESA_ONLINE_KEY']
  config.env = 'sandbox'
  config.base_url = 'https://sandbox.safaricom.co.ke'
  config.security_credential = 'Safari.com868'
  config.key = 'ZtkRW6ATbVtFpNml5w5SfG26Adffdkh9' # ENV['MPESA_KEY']
  config.secret = 'dosFI1yQ8bvHdyhd' # ENV['MPESA_SECRET']
end
```
## Usage
The gem will allow you to consume below APIs.
- Register C2B URLS
- Lipa na mpesa online
- B2C

> All responses are a faraday response

You have access to

- response.status
- response.headers
- response.body

### Register C2B URLS
To register urls ensure you have defined your `paybill`,`confirmation_url` and `validation_url` in your config block. Then call `register_urls` method on `Mpesa` class.

```
response = Mpesa.register_urls
```

### Lipa na Mpesa online(STK push)
Ensure you have added `lipa_na_mpesa_key`, `lnmo_shortcode`, `lnmocallback` in your config block.

```
response = Mpesa.stk_push(amount: 100, phone: '254705112855')
```
The methods accepts amount and phone number params.

### B2C
Ensure you have `security_credential`, `result_url` and `timeout_url` in your config block.

```
response = Mpesa.payout(amount: 100, phone: '254705112855',
                        command_id: 'BusinessPayment', remarks: 'paid')
```

> `command_id ` can be `BusinessPayment`, `PromotionPayment` or `SalaryPayment`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gathuku/mpesa. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/gathuku/mpesa/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mpesa project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/gathuku/mpesa/blob/master/CODE_OF_CONDUCT.md).
