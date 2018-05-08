module Lolp
  class Client
    module Certificate
      def certificate(domain)
        get("v1/certificates/#{domain}")
      end

      def create_certificate(domain)
        post("v1/certificates/#{domain}")
      end
    end
  end
end
