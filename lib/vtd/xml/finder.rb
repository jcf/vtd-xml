module VTD
  module Xml
    class Finder
      include Enumerable

      def initialize(nav, xpath)
        @nav = nav
        @xpath = xpath

        @auto_pilot = com.ximpleware.AutoPilot.new(@nav)
        @auto_pilot.select_xpath(@xpath)
      end

      def each
        while (current = @auto_pilot.eval_xpath) != -1
          yield Node.new(@nav, @auto_pilot, current)
        end
      end
    end
  end
end
