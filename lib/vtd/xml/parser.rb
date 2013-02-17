module VTD
  module Xml
    class Parser
      def initialize(path)
        @path = path

        @gen = com.ximpleware.VTDGen.new
        @gen.parse_file(@path, false)
      end

      def find(xpath)
        VTD::Xml::Finder.new(@gen.get_nav, xpath).enum_for(:each)
      end
    end
  end
end
