
module FortePayments
  class Error < StandardError
  end

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
      make_request {
        connection.get(base_url + path, options)
      }
    end

    def post(path, req_body)
      make_request {
        connection.post do |req|
          req.url(base_url + path)
          req.body = req_body
        end
      }
    end

    def put(path, options={})
      make_request {
        connection.put(base_url + path, options)
      }
    end

    def delete(path, options = {})
      make_request {
        connection.delete(base_url + path, options)
      }
    end

    private

    def make_request(&block)
      response = yield

      if response.success?
        return response.body
      else
        message = (response.body && response.body["response"] && response.body["response"]["response_desc"]) ? response.body["response"]["response_desc"] : response.body
        
        raise FortePayments::Error, message
      end
    end

    def base_url
      "https://sandbox.forte.net/api/v2"
    end

    def base_path
      "/accounts/#{account_id}/locations/#{location_id}"
    end

    def connection
      connection_options = ENV['PROXIMO_URL'] ? { proxy: ENV['PROXIMO_URL'] } : {}

      connection_options[:headers] = {
        :accept => 'application/json',
        'X-Forte-Auth-Account-Id' => "act_#{account_id}"
        }

      Faraday.new(connection_options) do |connection|
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
