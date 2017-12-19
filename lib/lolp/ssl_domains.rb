module Lolp
  module SSLDomains
    def update_ssl_domains(id, params)
      connection.post("ssl_domains/#{id}", params)
    end
  end
end
