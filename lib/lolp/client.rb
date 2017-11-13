require 'lolp/connection'
require 'lolp/project'

module Lolp
  class Client
    extend Lolp::Connection
    extend Lolp::Project
  end
end
