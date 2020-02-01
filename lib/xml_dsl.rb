# frozen_string_literal: true

require 'xml_dsl/version'
require 'xml_dsl/generator'
require 'xml_dsl/tag'
require 'xml_dsl/attribute'
require 'xml_dsl/partial'
require 'xml_dsl/options_parser'
require 'lib/core_extensions'
require 'byebug'

module XmlDsl
  class Error < StandardError; end

  def self.root
    File.dirname __dir__
  end
end
