module VTD
  module Xml
    class Node
      module Attributes
        AttributeMissing = Class.new(StandardError)

        def attributes
          attributes = {}

          @auto_pilot.select_attr('*')
          while (i = @auto_pilot.iterate_attr) != -1
            attributes[string_from_index i] = string_from_index i + 1
          end

          attributes
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

        def find_attribute(key)
          string_from_index @nav.get_attr_val(key)
        end
      end
    end
  end
end
