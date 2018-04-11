require 'faraday'
require 'faraday_middleware'

module Lolp
  module Connection
    def get(path)
      connection.get(path)
    end

    def post(path, params = {})
      connection.post(path, params)
    end

    def delete(path, params = {})
      connection.delete(path, params)
    end

    def authenticated?
      !!@token
    end

    private

    def connection
      @connection || connection!
    end

    def connection!
      project_url = 'https://github.com/pepabo/lolp.rb'
      user_agent = "lolp/#{VERSION} (+#{project_url}; ruby#{RUBY_VERSION})"
      ssl_verify = true

      args = {
        url: @api_endpoint,
        ssl: { verify: ssl_verify },
        headers: {
          user_agent: user_agent,
          content_type: 'application/json'
        }
      }

      @connection = Faraday.new(args) do |f|
        f.authorization 'Bearer', @token if authenticated?
        f.request :json
        f.response :json, content_type: /\bjson$/
        f.adapter Faraday.default_adapter
      end
    end
  end
end
