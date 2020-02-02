# frozen_string_literal: true

module XmlDsl
  class Generator
    def initialize(data_source:, template:, version_tag: '<?xml version="1.0" encoding="utf-8"?>')
      @data_source = data_source
      @template = template
      @version_tag = version_tag

      @template_dir = File.dirname @template
      @tags = []
      @generator = self
      @depth = -1
    end

    def generate
      instance_eval File.read(@template), @template.to_s
      ([@version_tag] + @tags.map(&:to_xml) + ['']).join "\n"
    end

    def tag(name, options = {}, &block)
      OptionsParser.parse(options).each do |parsed_options|
        xml_tag = Tag.new(name, self, 0, parsed_options)
        @tags.push xml_tag
        xml_tag.instance_eval(&block) if block_given?
      end
    end

    def partial(name, options = {}, context = self, context_options = {})
      file_name = File.join(@template_dir, "_#{name}.xml.rb").to_s

      OptionsParser.parse(options, context_options).each do |parsed_options|
        Partial.new(file_name, context, parsed_options).eval
      end
    end

    def method_missing(m, *args, &block)
      return @data_source[m] if @data_source.is_a? Hash

      @data_source.send(m, *args, &block)
    end
  end
end
