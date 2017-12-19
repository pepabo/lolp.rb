module Lolp
  module SSL
    def update_ssl(id, params)
      connection.post("ssls/#{id}", params)
    end
  end
end
