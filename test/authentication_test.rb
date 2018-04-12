require 'test_helper'

class AuthenticationTest < Minitest::Test
  def test_authenticate
    VCR.use_cassette('authenticate') do
      token = Lolp.login(ENV['TEST_USERNAME'], ENV['TEST_PASSWORD'])
      assert_equal 200, Lolp.last_response.status
      assert_equal token.length, 253
    end
  end

  def test_authenticate_faild
    VCR.use_cassette('authenticate_faild') do
      assert_raises Lolp::Unauthorized do
        Lolp.login('foo@example.com', 'Secret-Ruby-123@')
      end
      assert_equal 401, Lolp.last_response.status
    end
  end
end
