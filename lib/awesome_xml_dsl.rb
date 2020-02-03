# frozen_string_literal: true

require 'awesome_xml_dsl/version'
require 'lib/core_extensions'

require 'awesome_xml_dsl/options_parser'
require 'awesome_xml_dsl/attribute_options_parser'

require 'awesome_xml_dsl/generator'
require 'awesome_xml_dsl/attribute'
require 'awesome_xml_dsl/partial'
require 'awesome_xml_dsl/tag'

module AwesomeXmlDsl
  class RequiredValueNotPresent < StandardError; end

  def self.root
    File.dirname __dir__
  end
end
