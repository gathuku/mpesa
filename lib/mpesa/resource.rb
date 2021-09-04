module Mpesa
  class Resource
    attr_reader :client, :args

    def initialize(client, args = {})
      @client = client
      @args = args
    end

    def get_request(url:, params: {}, headers: {}, basic_auth: true)
      handle_response client.connection(basic_auth: basic_auth).get(url, params, headers)
    end

    def post_request(url:, body: {}, headers: {})
      puts body
      handle_response client.connection.post(url, body, headers)
    end

    def handle_response(response)
      case response.status
      when 400
        raise Error, "Your request was malformed. #{response.body['errorMessage']}"
      when 401
        raise Error, "You did not supply valid authentication credentials. #{response.body['errorMessage']}"
      when 403
        raise Error, "You are not allowed to perform that action. #{response.body['errorMessage']}"
      when 404
        raise Error, "No results were found for your request. #{response.body['errorMessage']}"
      end
      response
    end
  end
end
