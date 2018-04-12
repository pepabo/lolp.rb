module Lolp
  class Client
    module Authentication
      def authenticate(username = nil, password = nil)
        @token = post('v1/authenticate',
          username: username || @username,
          password: password || @password)
      end
      alias login authenticate
    end
  end
end
