# frozen_string_literal: true

module XmlDsl
  class Engine < ::Rails::Engine
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
  end
end
