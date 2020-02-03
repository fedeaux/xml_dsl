# frozen_string_literal: true

require 'xml_dsl/version'
require 'lib/core_extensions'

require 'xml_dsl/options_parser'
require 'xml_dsl/attribute_options_parser'

require 'xml_dsl/generator'
require 'xml_dsl/attribute'
require 'xml_dsl/partial'
require 'xml_dsl/tag'

module AwesomeXmlDsl
  class RequiredValueNotPresent < StandardError; end

  def self.root
    File.dirname __dir__
  end
end