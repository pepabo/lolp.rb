module Lolp
  class Client
    module Certificate
      def get_certificate(project_domain)
        get("v1/certificates/#{project_domain}")
      end

      def create_certificate(project_domain)
        post("v1/certificates/#{project_domain}")
      end
    end
  end
end
