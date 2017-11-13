require 'lolp/connection'

module Lolp
  class Client
    extend Lolp::Connection

    class << self
      def projects
        connection.get('projects')
      end

      def create_project(type, params = {})
        connection.post('projects', params.merge(haco_type: type))
      end

      def delete_project(name)
        connection.delete("projects/#{name}")
      end
    end
  end
end
