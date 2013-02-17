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
      end

      def name
        @name ||= @nav.to_string(@current)
      end

      def text
        @text ||= string_from_index @nav.get_text
      end

      private

      def string_from_index(index)
        @nav.to_normalized_string(index) if index != -1
      end
    end
  end
end
