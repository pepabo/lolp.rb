module Lolp
  class Client
    module Publickey
      def publickeys
        get('v1/pubkeys')
      end

      def create_publickey(name, key)
        post('v1/pubkeys', { name: name, key: key })
      end

      def delete_publickey(name)
        delete("v1/pubkeys/#{name}")
      end
    end
  end
end
