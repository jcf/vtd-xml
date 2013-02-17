require 'java'
require 'vtd-xml-java.jar'

require 'vtd/xml/version'
require 'vtd/xml/finder'
require 'vtd/xml/parser'
require 'vtd/xml/node'

module VTD
  module Xml
    def self.open(path)
      Parser.new(path)
    end
  end
end
