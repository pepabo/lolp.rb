module Lolp
  module Project
    def projects
      connection.get('projects')
    end

    def create_project(type, params = {})
      connection.post('projects', params.merge(haco_type: type))
    end

    def delete_project(name)
      connection.delete("projects/#{name}")
    end

    class Types
      PHP = 'php'.freeze
      WORDPRESS = 'wordpress'.freeze
      RAILS = 'rails'.freeze
    end
  end
end
