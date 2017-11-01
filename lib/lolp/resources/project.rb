module Lolp::Resources
  class Project < Base
    class << self
      def show
        client.default_client.get 'api/projects'
      end

      def create(type:)
        client.default_client.post 'api/projects', haco_type: type
      end

      def delete(name:)
        client.default_client.delete "api/projects/#{name}"
      end
    end
  end
end
