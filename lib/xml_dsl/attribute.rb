module XmlDsl
  class Attribute
    def initialize(*args)
      @name = args[0]

      if args.length == 2
        @value = args[1]
        @check_render = false
      elsif args.length == 3
        @attribute_data_source = args[1]
        @accessor = args[2]
        @check_render = true
      end
    end

    def render?
      !@check_render || @attribute_data_source.key?(@accessor)
    end

    def value
      @attribute_data_source ? @attribute_data_source[@accessor] : @value
    end

    def to_xml
      return "#{@name}=\"#{value}\"" if render?
    end
  end
end
