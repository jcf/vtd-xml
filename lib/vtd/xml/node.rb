require 'vtd/xml/node/attributes'

module VTD
  module Xml
    class Node
      TYPES = {
        first_child: com.ximpleware.VTDNav::FIRST_CHILD,
        parent: com.ximpleware.VTDNav::PARENT
      }

      include Attributes

      attr_reader :name, :text

      def initialize(nav, auto_pilot, current)
        @nav        = nav
        @auto_pilot = auto_pilot
        @current    = current
        super
      end

      def name
        @name ||= @nav.to_string(@current)
      end

      def text
        @text ||= string_from_index @nav.get_text
      end

      def with_first_child(name = nil)
        if move_to(:first_child, name)
          result = yield dup
          move_to(:parent)

          result
        end
      end

      def children(options = {})
        name = options.fetch(:only, '*')
        @auto_pilot.select_element(name)

        @auto_pilot.iterate if name == '*'

        Enumerator.new do |yielder|
          while @auto_pilot.iterate
            yielder << dup
          end
        end
      end

      def inspect
        %(#<#{self.class}:#{self.object_id} @current=#{@current} @nav=#{@nav}>)
      end

      private

      def string_from_index(index)
        @nav.to_normalized_string(index) if index != -1
      end

      def move_to(type, name = nil)
        if name
          @nav.to_element(find_type(type), name)
        else
          @nav.to_element(find_type(type))
        end
      end

      def find_type(type)
        TYPES[type] or raise ArgumentError, "Unknown node type: #{type.inspect}"
      end
    end
  end
end
