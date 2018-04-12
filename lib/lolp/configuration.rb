module Lolp
  module Configuration
    attr_accessor :api_endpoint, :username, :password, :token

    def configure
      yield self
    end

    def defaults
      @api_endpoint = ENV['LOLIPOP_MC_API_ENDPOINT'] || 'https://api.mc.lolipop.jp/'
      @username = ENV['LOLIPOP_MC_USERNAME']
      @password = ENV['LOLIPOP_MC_PASSWORD']
      @token = ENV['LOLIPOP_MC_TOKEN']
    end
  end
end
