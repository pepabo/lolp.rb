$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'lolp'
require 'minitest/autorun'
require 'vcr'

Lolp.configure do |c|
  c.api_endpoint = 'https://api.mc.lolipop.jp'
end

VCR.configure do |config|
  config.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  config.hook_into :faraday
  config.filter_sensitive_data("<PASSWORD>") do |interaction|
    test_password
  end
  config.filter_sensitive_data("<USERNAME>") do |interaction|
    test_username
  end
  config.filter_sensitive_data("<EMAIL>") do |interaction|
    test_email
  end
  config.filter_sensitive_data("Bearer <TOKEN>") do |interaction|
    interaction.request.headers['Authorization'].first
  end
  config.ignore_request do |request|
    URI(request.uri).path == '/v1/authenticate'
  end
end

def test_password
  'x' * 20
end

def test_username
  'x' * 5
end

def test_email
  'test@example.com'
end
