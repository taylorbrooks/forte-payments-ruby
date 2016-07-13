require 'faraday'
require 'faraday_middleware'

Dir[File.expand_path('../resources/*.rb', __FILE__)].each{|f| require f}

module FortePayments
  class Client
    include FortePayments::Client::Addresses
    include FortePayments::Client::Customers
    include FortePayments::Client::Paymethods
    include FortePayments::Client::Settlements
    include FortePayments::Client::Transactions

    attr_reader :api_key, :secure_key, :account_id, :location_id

    def initialize(api_key: api_key, secure_key: secure_key, account_id: account_id, location_id: location_id)
      @api_key     = api_key
      @secure_key  = secure_key
      @account_id  = account_id
      @location_id = location_id
    end

    def get(path, options={})
      connection.get(path, options).body
    end

    def post(path, req_body)
      connection.post do |req|
        req.url(path)
        req.body = req_body
      end.body
    end

    def put(path, options={})
      connection.put(path, options).body
    end

    def delete(path, options = {})
      connection.delete(path, options).body
    end

    private

    def base_url
      "https://sandbox.forte.net/api/v2"
    end

    def base_path
      "/accounts/#{account_id}/locations/#{location_id}"
    end

    def connection
      Faraday.new(url: base_url, headers: { :accept => 'application/json', 'X-Forte-Auth-Account-Id' => "#{account_id}" }) do |connection|
        connection.basic_auth api_key, secure_key
        connection.request    :json
        connection.response   :logger
        connection.use        FaradayMiddleware::Mashify
        connection.response   :json
        connection.adapter    Faraday.default_adapter
      end
    end
  end
end
