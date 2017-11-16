require 'lolp/connection'
require 'lolp/project'

module Lolp
  class Client
    include Lolp::Project

    def connection
      @connection ||= Lolp::Connection.new
    end
  end
end
