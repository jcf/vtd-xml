module VTD
  module Xml
    class Parser
      def initialize(path)
        @path = path

        @gen = com.ximpleware.VTDGen.new
        @gen.parse_file(@path, false)

        @nav = @gen.get_nav
      end

      def find(xpath)
        VTD::Xml::Finder.new(@nav, xpath).enum_for(:each)
      end
    end
  end
end
