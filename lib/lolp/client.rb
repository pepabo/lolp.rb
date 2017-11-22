require 'lolp/connection'
require 'lolp/project'
require 'lolp/configuration'

module Lolp
  class Client
    include Lolp::Project
    include Lolp::Configuration

    def connection
      @connection ||= Lolp::Connection.new(config)
    end
  end
end
