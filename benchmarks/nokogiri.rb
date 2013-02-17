#!/usr/bin/env ruby --profile.flat
require 'nokogiri'

doc = Nokogiri::XML(File.open('spec/fixtures/products.xml'))

count = odds = 0

doc.xpath('//outer/inner').each do |node|
  count += 1
  odds  += 1 if node['id'].to_i.odd?
end

puts "That's #{odds} odd IDs in #{count} nodes!"
