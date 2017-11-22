require 'faraday'
require 'faraday_middleware'

module Lolp
  class Connection
    def initialize(config)
      @config = config
      authenticate
      @connection = connection
    end

    def get(path)
      @connection.get(path)
    end

    def post(path, params = {})
      @connection.post(path, params)
    end

    def delete(path, params = {})
      @connection.delete(path, params)
    end

    private

    def connection
      Faraday.new(url: @config.api_endpoint, headers: { Authorization: "Bearer #{@token}" }) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter Faraday.default_adapter
      end
    end

    def authenticate
      @token ||= connection.post('login', username: @config.username, password: @config.password).body
    end
  end
end
