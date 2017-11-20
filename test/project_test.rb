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

  def test_create_project
    VCR.use_cassette('create_project') do
      response = Lolp.create_project(:rails)
      assert_equal 200, response.status
      refute_nil response.body['project_name']
      refute_nil response.body['domain']
    end
  end

  def test_create_project_faild
    VCR.use_cassette('create_project_faild') do
      response = Lolp.create_project(:invalid_template)
      assert_equal 400, response.status
      assert_equal 'invalid haco_type', response.body['message']
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
end