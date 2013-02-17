#!/usr/bin/env ruby --profile.flat

$: << 'lib'
require 'vtd/xml'

xml = VTD::Xml.open('spec/fixtures/products.xml')

count = odds = 0

xml.find('//outer/inner').each do |node|
  count += 1
  odds  += 1 if node['id'].to_i.odd?
end

puts "That's #{odds} odd IDs in #{count} nodes!"
