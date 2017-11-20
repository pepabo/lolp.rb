$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'lolp'
require 'minitest/autorun'
require 'vcr'

ENV['LOLIPOP_MC_API_ENDPOINT'] = 'https://staging.mc.lolipop.jp/api'

VCR.configure do |config|
  config.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  config.hook_into :faraday
  config.filter_sensitive_data("Bearer <TOKEN>") do |interaction|
    interaction.request.headers['Authorization'].first
  end
  config.ignore_request do |request|
    URI(request.uri).path == '/api/login'
  end
end
