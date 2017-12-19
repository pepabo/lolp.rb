require 'test_helper'

class SSLDomainsTest < Minitest::Test
  def test_update_ssl_domains
    VCR.use_cassette('update_ssl_domains') do
      response = Lolp.update_ssl_domains(1, { meta_tag: "example_tag" } )
      assert_equal 200, response.status
    end
  end
end
