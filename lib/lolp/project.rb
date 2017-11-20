module Lolp
  module Project
    def projects
      connection.get('projects')
    end

    def create_project(template, params = {})
      connection.post('projects', params.merge(haco_type: template))
    end

    def delete_project(name)
      connection.delete("projects/#{name}")
    end

    def create_custom_domain(domain, custom_domain)
      connection.post("projects/#{domain}/custom-domains", domain: custom_domain)
    end

    def delete_custom_domain(domain, custom_domain)
      connection.delete("projects/#{domain}/custom-domains/#{custom_domain}")
    end
  end
end
