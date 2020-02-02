# frozen_string_literal: true

module XmlDsl
  class OptionsParser
    attr_accessor :options

    def initialize(original_options, parent_options = {})
      self.options = original_options.clone
      options[:locals] ||= {}

      return unless parent_options.key?(:locals)

      options[:locals] = parent_options[:locals].deep_merge(options[:locals])
    end

    def self.parse(options, parent_options = {})
      new options, parent_options
    end

    def each
      return if options.key?(:if) && !options[:if]

      if options.key?(:collection) && options.key?(:as)
        return unless options[:collection].respond_to? :each

        as = options[:as]
        collection = options[:collection]
        delete_options :collection, :as

        collection.each do |element|
          options[:locals][as] = element

          yield options
        end
      elsif (options.key?(:if) || options.key?(:require)) && options.key?(:of)
        return if options.key?(:if) && !(can_read? options[:of], options[:if])

        if options.key?(:require) && !can_read?(options[:of], options[:require])
          raise RequireValueNotPresent.new("Can't read required key #{options[:require]} of #{options[:of]}")
        end

        accessor = options[:require] || options[:if]
        of = options[:of]
        as = options[:as] || accessor

        delete_options :if, :of, :as, :require

        options[:locals][as] = read of, accessor
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
