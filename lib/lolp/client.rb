require 'lolp/connection'

module Lolp
  class Client
    def projects
      connection.get('projects')
    end

    def create_project(type, params = {})
      connection.post('projects', params.merge(haco_type: type))
    end

    def delete_project(name)
      connection.delete("projects/#{name}")
    end

    private

    def connection
      @connection ||= Connection.new
    end
  end
end
