# encoding: utf-8
module VTD
  module Xml
    class Generator
      GENERATORS = [:products, :books]

      def initialize(root)
        @root = root
      end

      def generate
        GENERATORS.each do |generator_name|
          open(generator_name, &method(generator_name))
        end
      end

      private

      def open(generator_name, &writer)
        File.open(fixture_path(generator_name), 'w', &writer)
      end

      def fixture_path(generator_name)
        File.join(@root, "#{generator_name}.xml")
      end

      def products(f)
        f.puts '<?xml version="1.0" encoding="utf-8"?>'
        f.puts '<container>'

        1_000_000.times do |i|
          f.puts %(  <outer id="#{i + 10}">)
          f.puts %(    <inner id="#{i}" name="Could be random #{i}" />)
          f.puts %(  </outer>)
        end

        f.puts '</container>'
      end

      def books(f)
        f.puts \
          '<?xml version="1.0" encoding="utf-8"?>',
          '<books>',
          '  <book title="A Tale of Two Cities" sold="200000000" firstPublished="1859">',
          '    <author name="Charles Dickens" />',
          '  </book>',
          '  <book title="The Lord of the Rings" sold="150000000" firstPublished="1954">',
          '    <author name="J. R. R. Tolkien" />',
          '  </book>',
          '  <book title="The Little Prince" sold="140000000" firstPublished="1943">',
          '    <author name="Antoine de Saint-Exupéry" />',
          '  </book>',
          '</books>'
      end
    end
  end
end
