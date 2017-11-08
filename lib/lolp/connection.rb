require 'faraday'
require 'faraday_middleware'
require 'lolp/configuration'

module Lolp
  class Connection
    include Lolp::Configuration

    def initialize
      authorize
      @connection = connection
    end

    def get(url)
      @connection.get(url)
    end

    def post(url, params = {})
      @connection.post(url, params)
    end

    def delete(url, params = {})
      @connection.delete(url, params)
    end

    private

    def connection
      Faraday.new(url: config.api_url, headers: { Authorization: @token }) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end

    def authorize
      @token ||= connection.post('api/login', username: config.username, password: config.password).body
    end
  end
end
