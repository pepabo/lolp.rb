module Lolp
  class Client
    module Authentication
      def authenticate(username, password)
        res = post('v1/authenticate', username: username, password: password)
        if res.status == 200
          @token = res.body
          connection!
        end
        res
      end
      alias login authenticate
    end
  end
end
