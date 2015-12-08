
module FortePayments
  class Client
    include FortePayments::Client::Address
    include FortePayments::Client::Customer
    include FortePayments::Client::Paymethod
    include FortePayments::Client::Settlement
    include FortePayments::Client::Transaction

    attr_reader :api_key, :secure_key, :account_id, :location_id

    def initialize(api_key: ENV['FORTE_API_KEY'], secure_key: ENV['FORTE_SECURE_KEY'], account_id: ENV['FORTE_ACCOUNT_ID'], location_id: ENV['FORTE_LOCATION_ID'])
      @api_key     = api_key
      @secure_key  = secure_key
      @account_id  = account_id
      @location_id = location_id
    end

    def get(path, options={})
      connection.get(base_url + path, options).body
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
      headers = {
        :accept => 'application/json',
        'X-Forte-Auth-Account-Id' => "act_#{account_id}"
      }
      Faraday.new(headers: headers) do |connection|
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
