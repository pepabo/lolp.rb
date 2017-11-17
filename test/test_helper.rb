$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'lolp'
require 'minitest/autorun'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  config.hook_into :faraday
end
