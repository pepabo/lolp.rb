module Lolp
  module Configuration
    def config
      @config ||= Config.new
    end

    def configure
      yield config
    end

    class Config
      attr_accessor :api_endpoint, :username, :password

      def initialize
        @api_endpoint = ENV['LOLIPOP_MC_API_ENDPOINT'] || 'https://api.mc.lolipop.jp/v1'
        @username = ENV['LOLIPOP_MC_USERNAME']
        @password = ENV['LOLIPOP_MC_PASSWORD']
      end
    end
  end
end
