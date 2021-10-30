# Mpesa

Welcome to [mpesa](https://developer.safaricom.co.ke/) API gem. The gem defines the API resources and helps developers to make requests cleanly.

When you receive a JSON response from an API endpoint, it's really easy to convert this to a Ruby hash. But hashes don't feel very Ruby-ish when you're working with them.

To help on this gem parse the responses to `OpenStruct` Objects so a developer can interact with the response just like regular ruby objects we are used to.

This Gem provides an interface that developers can use to convert JSON to `OpenStruct` objects, this is useful when you want to parse results callbacks data.

## Installation

Install via `Gemfile`
```
gem 'mpesarb', '~> 0.3.0'
```

Or
```
bundle add mpesarb
```

## Usage

### Initialization

```ruby
client = Mpesa::Client.new(key: 'ZtkRW6ATbVtFpNml5w5SfG26Adfyagn9', secret: 'dosFI1yQ8bvHEVFw', env: 'sandbox')

response = client.auth
response.access_token # XiKf3D6UrY0J8S2aeOQ7R7w0BuA5
response.expires_in # 3599
```
__Parameters__

Required
- `key` - API consumer key - Required
- `secret` - API consumer secret  - Required

Optional
- `env` - API environment. Default `production`
- `adapter` - Faraday HTTP adapter. Default `:net_http`
- `shortcode` - Mpesa shortcode
- `pass_key` - LPNMO pass Key( used by STK API)


### Register Urls

Register C2B Urls( confirmation and validation url)
```ruby
 response = client.register(
   shortcode: "44445",
   confirmation_url: 'http://example.com/confirm',
   validation_url: 'http://example.com/validate'
 )
 response.OriginatorCoversationID #   "807-15591582-1"
 response.ResponseCode # "0"
 response.ResponseDescription # "success"  
```

### STK (LPNMO)

Lipa na mpesa online(Stk Push)

```ruby
response = client.stk(
  shortcode: "174379",
  pass_key: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919", # Optional if passed in client initialization
  amount: "10",
  phone: "254705112855",
  callback_url: "https://test.com",
  reference: "REF",
  trans_desc: "desc"
)

response.CheckoutRequestID # "ws_CO_040920212326513616"
response.inspect # to see all available attributes
```


### B2C (Payout)

```rb
response = client.payout(
  shortcode: "600998", # Optional if added in client initialization
  initiator_username: "testapi",
  initiator_password: "Safaricom998!",
  command_id: "BusinessPayment",
  phone: "254708374149",
  amount: "100",
  result_url: "https://example.com/result",
  timeout_url: "https://example.com/result",
  occasion: "some desc",
  remarks: "remarks"
)

response.ConversationID # AG_20210904_0000574b3c8d93651740
response.OriginatorConversationID #  "28831-15819693-1"
respose.ResponseDescription # "Accept the service request successfully."

```

### Transaction Status
Check Transation Status

```rb
response = client.status(
   shortcode: '600426',
   transaction_id: 'OEI2AK4Q16',
   identifier_type: 1,
   initiator_username: 'testapi',
   initiator_password: 'Safaricom426!',
   timeout_url: 'https://example.com/result',
   result_url: 'https://example.com/result'
)

response.ConversationID
response.ResponseCode
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gathuku/mpesa. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/gathuku/mpesa/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mpesa project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/gathuku/mpesa/blob/master/CODE_OF_CONDUCT.md).
