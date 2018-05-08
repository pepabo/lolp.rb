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
    end
  end
end
