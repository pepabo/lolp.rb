require 'lolp/connection'
require 'lolp/configuration'
require 'lolp/client/project'
require 'lolp/client/authentication'
require 'lolp/client/certificate'
require 'lolp/client/publickey'

module Lolp
  class Client
    include Lolp::Configuration
    include Lolp::Connection
    include Lolp::Client::Project
    include Lolp::Client::Authentication
    include Lolp::Client::Certificate
    include Lolp::Client::Publickey

    def initialize(config = {})
      defaults

      config.each do |k,v|
        instance_variable_set(:"@#{key}", v)
      end
    end
  end
end
