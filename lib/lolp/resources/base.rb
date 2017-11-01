require 'lolp/resources/restfully_accessible'

module Lolp::Resources
  class Base
    extend RestfullyAccessible

    class << self
      def client
        @client ||= Lolp::Client.new
      end
    end
  end
end
