require 'vtd/xml/node/attributes'

module VTD
  module Xml
    class Node
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

      def children(options = {})
        next_element unless child_selected?(options)

        Enumerator.new do |yielder|
          yielder << dup while next_element
        end
      end

      def inspect
        %(#<#{self.class}:#{self.object_id} @current=#{@current} @nav=#{@nav}>)
      end

      private

      def child_selected?(options)
        name = options.fetch(:only, '*')
        @auto_pilot.select_element(name)
        name != '*'
      end

      def next_element
        @auto_pilot.iterate
      end

      def string_from_index(index)
        @nav.to_normalized_string(index) if index != -1
      end
    end
  end
end
