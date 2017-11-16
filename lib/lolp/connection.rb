require 'faraday'
require 'faraday_middleware'
require 'lolp/configuration'
require 'singleton'

module Lolp
  module Connection
    def connection
      FaradayConnection.instance
    end
  end

  class FaradayConnection
    include Singleton
    include Lolp::Configuration

    def initialize
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
      Faraday.new(url: config.api_endpoint, headers: { Authorization: @token }) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end

    def authenticate
      @token ||= connection.post('login', username: config.username, password: config.password).body
    end
  end
end
