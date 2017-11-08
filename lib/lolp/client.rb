require 'lolp/connection'

module Lolp
  class Client

    def initialize
      @connection = Connection.new
    end

    def get_projects
      @connection.get('api/projects')
    end

    def create_project(type, params = {})
      @connection.post('api/projects', params.merge(haco_type: type))
    end

    def delete_project(name)
      @connection.delete("api/projects/#{name}")
    end
  end
end
