require 'lolp/connection'
require 'lolp/project'
require 'lolp/ssl'
require 'lolp/ssl_domains'
require 'lolp/configuration'

module Lolp
  class Client
    include Lolp::Project
    include Lolp::SSL
    include Lolp::SSLDomains
    include Lolp::Configuration

    def connection
      @connection ||= Lolp::Connection.new(config)
    end
  end
end
