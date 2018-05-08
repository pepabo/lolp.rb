require 'test_helper'

class CertificateTest < Minitest::Test
  def test_get_certificate
    VCR.use_cassette('certificate') do
      certificate = Lolp.get_certificate('aged-kitsuki-1735.lolipop.io')
      assert_equal 200, Lolp.last_response.status
      assert_equal %w(example.com), certificate['issued_domains']
      assert_equal %w(example.com), certificate['issuable_domains']
    end
  end

  def test_create_certificate
    VCR.use_cassette('create_certificate') do
      response = Lolp.create_certificate('aged-kitsuki-1735.lolipop.io')
      assert_equal 201, Lolp.last_response.status
      assert_equal 'Created', response
    end
  end
end
