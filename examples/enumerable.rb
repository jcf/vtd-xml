#!/usr/bin/env ruby --profile.flat

$: << 'lib'
require 'vtd/xml'

xml = VTD::Xml.open('spec/fixtures/books.xml')

# Make use of the entire attribute list
node = xml.find('//book').max_by { |node| node.attributes['sold'].to_i }
puts "Max sold was #{node.attributes['sold'].inspect}"
