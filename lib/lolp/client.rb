require 'lolp/connection'
require 'lolp/configuration'
require 'lolp/client/project'
require 'lolp/client/authentication'

module Lolp
  class Client
    include Lolp::Configuration
    include Lolp::Connection
    include Lolp::Client::Project
    include Lolp::Client::Authentication

    def initialize(config = {})
      defaults

      config.each do |k,v|
        instance_variable_set(:"@#{key}", v)
      end
    end
  end
end
