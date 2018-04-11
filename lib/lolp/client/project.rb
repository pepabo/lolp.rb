module Lolp
  class Client
    module Project
      def projects
        get('v1/projects')
      end

      def create_project(type, params = {})
        post('v1/projects', params.merge(type: type))
      end

      def delete_project(name)
        delete("v1/projects/#{name}")
      end

      def create_custom_domain(domain, custom_domain)
        post("v1/projects/#{domain}/custom-domains", domain: custom_domain)
      end

      def delete_custom_domain(domain, custom_domain)
        delete("v1/projects/#{domain}/custom-domains/#{custom_domain}")
      end
    end
  end
end
