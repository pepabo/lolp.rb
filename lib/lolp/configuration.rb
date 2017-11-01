module Lolp
  module Configuration
    def config
      @config ||= Config.new
    end

    def configure
      yield config
    end

    class Config
      attr_accessor :api_url, :username, :password

      def initialize
        @api_url  = ENV['LOLIPOP_MC_API_URL']
        @username = ENV['LOLIPOP_MC_USERNAME']
        @password = ENV['LOLIPOP_MC_PASSWORD']
      end
    end
  end
end
