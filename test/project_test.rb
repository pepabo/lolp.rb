require 'test_helper'

class ProjectTest < Minitest::Test
  def test_projects
    VCR.use_cassette('projects') do
      projects = Lolp.projects
      assert_equal 200, Lolp.last_response.status
      assert_equal projects.class, Array
    end
  end

  def test_create_wordpress_project
    VCR.use_cassette('create_wordpress_project') do
      p = Lolp.create_project(
        :wordpress,
        payload: {
          username: 'foobar',
          password: 'FoobarSecretPW123$#',
          email: 'foobar@example.com'
        }
      )
      assert_equal 201, Lolp.last_response.status
      assert_equal p['domain'], 'agile-maebaru-4396.lolipop.io'
      assert_equal p['sub_domain'], 'agile-maebaru-4396'
    end
  end

  def test_create_rails_project
    VCR.use_cassette('create_rails_project') do
      p = Lolp.create_project(
        :rails,
        db_password: 'FoobarSecretPW123$#',
        sub_domain: test_subdomain
      )
      assert_equal 201, Lolp.last_response.status
      assert_equal p['domain'], "#{test_subdomain}.lolipop.io"
      assert_equal p['sub_domain'], test_subdomain
    end
  end

  def test_create_project_faild
    VCR.use_cassette('create_project_faild') do
      assert_raises Lolp::UnprocessableEntity do
        Lolp.create_project(:invalid_template)
      end
      assert_equal 422, Lolp.last_response.status
    end
  end

  def test_create_custom_domain
    VCR.use_cassette('create_custom_domain') do
      Lolp.create_custom_domain("#{test_subdomain}.lolipop.io", 'example.com')
      assert_equal 201, Lolp.last_response.status
    end
  end

  def test_create_custom_domain_faild
    VCR.use_cassette('create_custom_domain_faild') do
      assert_raises Lolp::UnprocessableEntity do
        Lolp.create_custom_domain("#{test_subdomain}.lolipop.io", 'examplecom')
      end
      assert_equal 422, Lolp.last_response.status
    end
  end

  def test_delete_custom_domain
    VCR.use_cassette('delete_custom_domain') do
      Lolp.delete_custom_domain("#{test_subdomain}.lolipop.io", 'example.com')
      assert_equal 204, Lolp.last_response.status
    end
  end

  def test_delete_project
    VCR.use_cassette('delete_project') do
      p = Lolp.delete_project(test_subdomain)
      assert_equal 204, Lolp.last_response.status
      assert_equal '', p
    end
  end

  def test_delete_project_faild
    VCR.use_cassette('delete_project_faild') do
      assert_raises Lolp::NotFound do
        Lolp.delete_project('invalid-name')
      end
      assert_equal 404, Lolp.last_response.status
    end
  end

  def test_project_storage
    VCR.use_cassette('project_storage') do
      Lolp.login(ENV['TEST_USERNAME'], ENV['TEST_PASSWORD'])
      s = Lolp.project_storage('fancy-saga-7437.lolipop.io')
      assert_equal 10485760, s['diskLimit']
      assert_equal 53356, s['diskUsed']
      assert_equal 150000, s['fileLimit']
      assert_equal 2210, s['filesUsed']
    end
  end

  def test_project_storage_faild
    # Occasionally request may fail. In that case, please retry.
    VCR.use_cassette('project_storage_faild') do
      Lolp.login(ENV['TEST_USERNAME'], ENV['TEST_PASSWORD'])
      p = Lolp.create_project(
        :wordpress,
        payload: {
          username: 'foobar',
          password: 'FoobarSecretPW123$#',
          email: 'foobar@example.com'
        }
      )
      assert_raises Lolp::ServiceUnavailable do
        Lolp.project_storage(p['domain'])
      end
    end
  end

  def test_project_environment_variables
    VCR.use_cassette('project_environment_variables') do
      Lolp.project_environment_variables("#{test_subdomain}.lolipop.io")
      assert_equal 200, Lolp.last_response.status
    end
  end

  def test_update_project_environment_variables
    VCR.use_cassette('update_project_environment_variables') do
      Lolp.update_project_environment_variables("#{test_subdomain}.lolipop.io", test_envvar)
      assert_equal 201, Lolp.last_response.status
    end
  end

  def test_update_project_environment_variables_faild
    VCR.use_cassette('update_project_environment_variables_faild') do
      assert_raises Lolp::UnprocessableEntity do
        Lolp.update_project_environment_variables("#{test_subdomain}.lolipop.io", test_envvar + [{"method":"invalid","variable":{"key":"sample2"}}])
      end
      assert_equal 422, Lolp.last_response.status
    end
  end

  def test_create_guest_pubkey
    VCR.use_cassette('create_guest_pubkey') do
      Lolp.delete_project(test_subdomain)
      Lolp.create_project(
        :rails,
        db_password: 'FoobarSecretPW123$#',
        sub_domain: test_subdomain
      )

      Lolp.create_guest_pubkey(
        "#{test_subdomain}.lolipop.io",
        'guest-pubkey',
        'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD2YebYvngk+QDvTbMv7cE6QWJ+M/SNHLD6bdVXQGzrBaI8gU+1fZDqfpwhmy75eGyCMoRynQYv7O3snGwxMllGM9xWZIJbcxKUnXF/hVPulKaxH963Md9L6+lOqEimhCaVgjKE8Mi1EcXRkliefu8sOZVbuEC69sCfxOEFNq+mRVp49l20/zHoXBj7tf5r2hyCBVWK6Mkyut8pDPeEJWNrNlVYKHa7kcAj1PNiBwJIWiMMeYnmAOSZ0/MSOL4U08/MIPCF+kqDOIbvX7b413Aw8K5iovZVWbym9NpGoqyrhD9nXx4mkFcKN/5WMvONt1B4x94bcLZqugXgdLXSMBTuGrV/SLhCieJ1ETSXtqN5xL7Wuu+EQYb3naaWUbeVLjcylnEeejFWFiCGPdY4+BXncNFKqzj8McHU71aqZ59htizVX4X1OMnreyfdjN2Y7nQOtnWB90hfBRhz04tKNnA9S1DhvXcO1fKeE/FgmVu8ocz5UhAW6BCNe7ghGsQJZSWwyXCHa+KLvMFjrAUHPfrzwQt2l5OKTHhXDtL/sA3EkHxWOcT3h4jP3E1s23gb+kUCeys5DnX5DRSSr5SwxvWwDoes5ZaUY7LfbpGXY8ZwmhwOTM9k2FIaIh8uPydvx+GbJyq4rew3fDJ8M2hvAdyoFQaWv1EWiYc6+LWhheERDw=='
      )

      assert_equal 201, Lolp.last_response.status
    end
  end

  def test_guest_pubkeys
    VCR.use_cassette('guest_pubkeys') do
      res = Lolp.guest_pubkeys("#{test_subdomain}.lolipop.io")
      assert_equal 200, Lolp.last_response.status
      assert_equal 'guest-pubkey', res[0]['name']
    end
  end

  def test_delete_guest_pubkey
    VCR.use_cassette('delete_guest_pubkey') do
      res = Lolp.delete_guest_pubkey("#{test_subdomain}.lolipop.io", 'guest-pubkey')
      assert_equal 204, Lolp.last_response.status
      assert_equal "", res

      res = Lolp.guest_pubkeys("#{test_subdomain}.lolipop.io")
      assert_equal [], res
    end
  end
end
