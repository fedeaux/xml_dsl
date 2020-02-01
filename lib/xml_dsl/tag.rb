module XmlDsl
  class Tag
    def initialize(name, generator, depth, options = {})
      @name = name
      @generator = generator
      @depth = depth
      @options = options

      @attributes = []
      @tags = []
    end

    # Block evaluation
    def a(*args)
      attribute = Attribute.new(*args)
      @attributes.push attribute
    end

    def tag(name, options = {}, &block)
      OptionsParser.parse(options).each do |parsed_options|
        xml_tag = Tag.new(name, @generator, @depth + 1, parsed_options)
        @tags.push xml_tag
        xml_tag.instance_eval(&block) if block_given?
      end
    end

    def partial(name, options = {})
      @generator.partial(name, options, self)
    end

    # XML Generation
    def to_xml
      spaces = ' ' * @depth * 2
      start = "#{spaces}<#{@name}#{attributes_as_xml(spaces + '  ')}"

      return start + ' />' if @tags.length.zero?

      [start + '>', @tags.map(&:to_xml).join("\n"), "#{spaces}</#{@name}>"].join "\n"
    end

    def attributes_as_xml(spaces)
      return '' unless @attributes.any?
      return " #{@attributes.first.to_xml}" if @attributes.length == 1

      ([''] + @attributes.map(&:to_xml).compact.map { |attribute| "#{spaces}#{attribute}" }).join("\n")
    end

    # Maybe moved to a concern :t
    def can_read?(object, key)
      return object.key?(key) if object.respond_to?(:key?)

      object.respond_to?(key)
    end

    def read(object, key)
      return object[key] if object.is_a? Hash

      object.send key
    end

    def method_missing(m, *args, &block)
      return @options[:locals][m] if @options[:locals] && @options[:locals].key?(m)

      @generator.send(m, *args, &block)
    end
  end
end
