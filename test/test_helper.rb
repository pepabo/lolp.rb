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
    if interaction.request.headers['Authorization']
      interaction.request.headers['Authorization'].first
    end
  end
end

def test_password
  ENV['TEST_PASSWORD']
end

def test_username
  ENV['TEST_USERNAME']
end

def test_email
  'test@example.com'
end

def test_subdomain
  'lolp-rb-test'
end
