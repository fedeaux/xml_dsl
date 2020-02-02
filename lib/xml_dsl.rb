# frozen_string_literal: true

module XmlDsl
  class RequiredValueNotPresent < StandardError; end

  if defined?(Rails)
    require 'engine'
  else
    require 'xml_dsl/version'
    require 'xml_dsl/generator'
    require 'xml_dsl/tag'
    require 'xml_dsl/attribute'
    require 'xml_dsl/partial'
    require 'xml_dsl/options_parser'
    require 'xml_dsl/attribute_options_parser'
    require 'lib/core_extensions'
  end

  def self.root
    File.dirname __dir__
  end
end
