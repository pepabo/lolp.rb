require 'lolp/version'
require 'lolp/client'

module Lolp
  class << self
    def client
      @client ||= Lolp::Client.new
    end

    def method_missing(method_name, *args, &block)
      if client.respond_to?(method_name)
        return client.send(method_name, *args, &block)
      end

      super
    end
  end
end
