require 'test_helper'

class ProjectTest < Minitest::Test
  def test_projects
    VCR.use_cassette('projects') do
      response = Lolp.projects
      assert_equal 200, response.status
      refute_nil response.body.first['domain']
    end
  end

  def test_authenticate_faild
    VCR.use_cassette('authenticate_faild') do
      response = Lolp.projects
      assert_equal 403, response.status
      assert_equal 'Not enough or too many segments', response.body['errors'].first
    end
  end

  def test_create_wordpress_project
    VCR.use_cassette('create_wordpress_project') do
      response = Lolp.create_project(
        :wordpress,
        payload: {
          username: test_username, password: test_password, email: test_email
        }
      )
      assert_equal 201, response.status
      refute_nil response.body['domain']
      refute_nil response.body['sub_domain']
    end
  end

  def test_create_rails_project
    VCR.use_cassette('create_rails_project') do
      response = Lolp.create_project(:rails, db_password: test_password)
      assert_equal 201, response.status
      refute_nil response.body['domain']
      refute_nil response.body['sub_domain']
    end
  end

  def test_create_project_faild
    VCR.use_cassette('create_project_faild') do
      response = Lolp.create_project(:invalid_template)
      assert_equal 400, response.status
      assert_equal 'Bad Request', response.body
    end
  end

  def test_delete_project
    VCR.use_cassette('delete_project') do
      response = Lolp.delete_project('tight-ureshino-5550')
      assert_equal 204, response.status
      assert_equal '', response.body
    end
  end

  def test_delete_project_faild
    VCR.use_cassette('delete_project_faild') do
      response = Lolp.delete_project('invalid-name')
      assert_equal 500, response.status
      assert_equal 'Internal Server Error', response.body
    end
  end

  def test_create_custom_domain
    VCR.use_cassette('create_custom_domain') do
      response = Lolp.create_custom_domain('jolly-hirado-0217.staging.lolipop.io', 'example.com')
      assert_equal 201, response.status
      assert_equal 'Created', response.body
    end
  end

  def test_create_custom_domain_faild
    VCR.use_cassette('create_custom_domain_faild') do
      response = Lolp.create_custom_domain('invalid_domain', 'example.com')
      assert_equal 500, response.status
      assert_equal 'Internal Server Error', response.body
    end
  end

  def test_delete_custom_domain
    VCR.use_cassette('delete_custom_domain') do
      response = Lolp.delete_custom_domain('jolly-hirado-0217.staging.lolipop.io', 'example.com')
      assert_equal 204, response.status
      assert_equal '', response.body
    end
  end

  def test_delete_custom_domain_faild
    VCR.use_cassette('delete_custom_domain_faild') do
      response = Lolp.delete_custom_domain('invalid_domain', 'example.com')
      assert_equal 500, response.status
      assert_equal 'Internal Server Error', response.body
    end
  end
end
