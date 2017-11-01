module Lolp
  module Resources
    require 'lolp/resources/base'

    autoload :Project, 'lolp/resources/project'
  end

  def self.const_missing(name)
    new_klass = Lolp::Resources.const_get(name)
    Lolp.const_set(name, new_klass)
  rescue NameError
    super
  end
end
