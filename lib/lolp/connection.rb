require 'faraday'
require 'lolp/errors'
require 'faraday_middleware'

module Lolp
  module Connection
    def get(path, params = {})
      request(:get, path, params)
    end

    def post(path, params = {})
      request(:post, path, params)
    end

    def delete(path, params = {})
      request(:delete, path, params)
    end

    def authenticated?
      !!@token
    end

    def last_response
      @last_response if defined? @last_response
    end

    def request(method, url = nil, data = nil, headers = nil, &block)
      @last_response = if %i(post put patch).include?(method)
          connection.run_request(method, url, data, headers, &block)
        else
          connection.run_request(method, url, nil, headers) { |r|
            r.params.update(data) if data
            yield(r) if block_given?
          }
        end

      if error = Error.from_response(@last_response)
        raise error
      end
      @last_response.body
    end

    private

    def connection
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

      @connection.authorization(:Bearer, @token) if @connection && authenticated?
      @connection ||= Faraday.new(args) do |f|
        f.request :json
        f.response :json, content_type: /\bjson$/
        f.adapter Faraday.default_adapter
      end
    end
  end
end
