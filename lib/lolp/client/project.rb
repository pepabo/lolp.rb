module Lolp
  class Client
    module Project
      def projects
        get('v1/projects')
      end

      def project(name)
        get("v1/projects/#{name}")
      end

      def create_project(type, params = {})
        post('v1/projects', params.merge(type: type))
      end

      def delete_project(name)
        delete("v1/projects/#{name}")
      end

      def create_custom_domain(project_domain, custom_domain)
        post("v1/projects/#{project_domain}/custom-domains", domain: custom_domain)
      end

      def delete_custom_domain(project_domain, custom_domain)
        delete("v1/projects/#{project_domain}/custom-domains/#{custom_domain}")
      end

      def project_storage(name)
        get("v1/projects/#{name}/storage")
      end

      def project_environment_variables(name)
        get("v1/projects/#{name}/environment-variables")
      end
      alias project_envs project_environment_variables

      def update_project_environment_variables(name, data=[])
        put("v1/projects/#{name}/environment-variables", data)
      end
      alias update_project_envs update_project_environment_variables
    end
  end
end
