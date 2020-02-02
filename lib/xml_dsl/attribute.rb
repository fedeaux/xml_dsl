# frozen_string_literal: true

module XmlDsl
  class Attribute
    def initialize(name, value)
      @name = name
      @value = value
    end

    def to_xml
      return "#{@name}=\"#{@value}\""
    end
  end
end
