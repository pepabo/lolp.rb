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
  end
end
