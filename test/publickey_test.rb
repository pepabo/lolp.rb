require 'test_helper'

class PublicKeyTest < Minitest::Test
  def setup
    Lolp::Client.new
  end
  def test_publickeys
    VCR.use_cassette('publickeys') do
      publickeys = Lolp.publickeys
      assert_equal 200, Lolp.last_response.status
      assert_equal publickeys.class, Array
    end
  end

  def test_create_publickey
    VCR.use_cassette('create_publickey') do
      p = Lolp.create_publickey('foobar', 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZx4lWgqP3VDoypCihYrC7SZRWVuvqejTeo6Jf5MvS4m1U6NDGcdUHoi3S0LuB6IW3x7NkNYrGMvucQxHdIqL9iNbtDvXVMJwE1w77htGCvEl3yYgdqCgIuoK/IwOiQFUaSjmTzX87WC3ZIolGp/nUO1nhOKEM9b6yETEzGAkg4Gx0sSeI7IcBkyXzboS/WiVviEvyt/6KhrpoAiGCt/VhKpZVRa+V+J/WL0nzYcM5u+yQrYddOA6zHcd5xe/+chtg7LzC/rA6anCEP0GVAT9eYHkz9nR9Z+gq4mg/Yoi0MZp7bAfp3RZi4GM5Ey5RZHWUaVhjP0QwdKPLeMHTuAWd')
      assert_equal 201, Lolp.last_response.status
      assert_equal p['name'], 'foobar'
    end
  end

  def test_delete_publickey
    VCR.use_cassette('delete_publickey') do
      p = Lolp.delete_publickey('foobar')
      assert_equal 204, Lolp.last_response.status
      assert_equal '', p
    end
  end
end
