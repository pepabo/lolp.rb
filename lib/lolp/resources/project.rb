module Lolp::Resources
  class Project < Base
    class << self
      def show
        client.get 'api/projects'
      end

      def create(type:)
        client.post 'api/projects', haco_type: type
      end

      def delete(name:)
        client.delete "api/projects/#{name}"
      end
    end
  end
end
