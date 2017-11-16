require 'lolp/connection'
require 'lolp/project'

module Lolp
  class Client
    include Lolp::Connection
    include Lolp::Project
  end
end
