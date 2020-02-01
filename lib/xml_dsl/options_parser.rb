# frozen_string_literal: true

module XmlDsl
  class OptionsParser
    attr_accessor :options

    def initialize(original_options)
      self.options = original_options.clone
      options[:locals] ||= {}
    end

    def self.parse(options)
      new options
    end

    def each
      if options.key?(:collection) && options.key?(:as)
        return unless options[:collection].respond_to? :each

        as = options[:as]
        collection = options[:collection]
        delete_options :collection, :as

        collection.each do |element|
          options[:locals][as] = element

          yield options
        end
      elsif options.key?(:with) && options.key?(:of)
        return unless can_read? options[:of], options[:with]

        as = options[:as] || options[:with]
        of = options[:of]
        with = options[:with]

        delete_options :with, :of, :as

        options[:locals][as] = read of, with
        yield options
      else
        yield options
      end
    end

    def delete_options(*keys)
      keys.each do |key|
        options.delete key
      end
    end

    def can_read?(object, key)
      return object.key?(key) if object.respond_to?(:key?)

      object.respond_to?(key)
    end

    def read(object, key)
      return object[key] if object.is_a? Hash

      object.send key
    end
  end
end
