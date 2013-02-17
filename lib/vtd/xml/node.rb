module VTD
  module Xml
    class Node
      AttributeMissing = Class.new(StandardError)

      attr_reader :name, :text

      def initialize(nav, auto_pilot, current)
        @nav = nav
        @auto_pilot = auto_pilot
        @current = current

        @name = @nav.to_string(@current)
        @text = nil
        @attributes = nil

        get_text
      end

      def attributes
        @attributes ||=
          begin
            cache = {}
            @auto_pilot.select_attr('*')

            while (i = @auto_pilot.iterate_attr) != -1
              cache[string_from_index i] = string_from_index i + 1
            end

            cache
          end
      end

      def [](key)
        find_attribute(key)
      end

      def slice(*keys)
        Hash[*keys.flat_map { |key| [key, find_attribute(key)] }]
      end

      def fetch(*args)
        if args.length == 2
          key, default = *args
        else
          key = args.first
        end

        if item = find_attribute(key)
          return item
        end

        return yield(key) if block_given?
        return default if defined? default
        raise AttributeMissing, 'attribute not found'
      end

      private

      def string_from_index(index)
        @nav.to_normalized_string(index) if index != -1
      end

      def find_attribute(key)
        string_from_index @nav.get_attr_val(key)
      end

      def get_text
        string_from_index @nav.get_text
      end
    end
  end
end
