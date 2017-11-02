require 'lolp/resources/restfully_accessible'

module Lolp::Resources
  class Base
    extend RestfullyAccessible

    class << self
      def client
        unless @client
          client = Lolp::Client.new
          @client = client.default_client
        end
      end
    end
  end
end
