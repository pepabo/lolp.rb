module Lolp
  class Client
    module Authentication
      def authenticate(username, password)
        @token = post('v1/authenticate', username: username, password: password)
      end
      alias login authenticate
    end
  end
end
