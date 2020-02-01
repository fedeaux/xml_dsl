module XmlDsl
  class DataSource
    def initialize(object:)
      @object = object
    end

    def can_read?(object, key)
      return object.key?(key) if object.respond_to?(:key?)

      object.respond_to?(key)
    end

    def read(object, key)
      return object[key] if object.is_a? Hash

      object.send key
    end

    def method_missing(m, *args, &block)
      return @data_source[m] if @data_source.is_a? Hash

      @data_source.send(m, *args, &block)
    end
  end
end
