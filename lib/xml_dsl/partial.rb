module XmlDsl
  class Partial
    def initialize(file_name, context, options = {})
      @context = context
      @file_name = file_name
      @options = options
    end

    def tag(name, options = {}, &block)
      @context.tag name, options.deep_merge(@options), &block
    end

    def a(*args)
      @context.a(*args)
    end

    def eval
      contents = File.read @file_name
      instance_eval contents, @file_name
    end

    def method_missing(m, *args, &block)
      return @options[:locals][m] if @options[:locals] && @options[:locals].key?(m)

      @context.send(m, *args, &block)
    end
  end
end
