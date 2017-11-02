require 'faraday'
require 'faraday_middleware'
require 'lolp/configuration'

module Lolp
  class Client
    include Lolp::Configuration

    def initialize
      authorize
      @default_client = generate_client
    end
    attr_reader :default_client

    private

    def generate_client
      Faraday.new(url: config.api_url, headers: { cookie: @session }) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end

    def authorize
      unless @session
        result = generate_client.post 'api/login', username: config.username, password: config.password
        @session = result.env[:response_headers]['set-cookie']
      end
    end
  end
end
