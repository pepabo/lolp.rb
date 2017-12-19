require 'test_helper'

class SSLTest < Minitest::Test
  def test_update_ssl
    VCR.use_cassette('update_ssl') do
      response = Lolp.update_ssl(1, { key: "example_key", crt: "example_crt" } )
      assert_equal 200, response.status
    end
  end
end
