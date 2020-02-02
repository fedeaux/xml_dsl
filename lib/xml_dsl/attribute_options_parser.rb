# frozen_string_literal: true

module XmlDsl
  class AttributeOptionsParser
    def initialize(original_options)
      @as = original_options[:as] || original_options[:require] || original_options[:if]
      @options_parser = OptionsParser.new original_options
    end

    def self.parse(options)
      new options
    end

    def each
      @options_parser.each do |parsed_options|
        value = parsed_options[:locals][@as]
        yield value
      end
    end
  end
end
