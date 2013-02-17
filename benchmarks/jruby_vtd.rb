#!/usr/bin/env ruby --profile.flat
require 'java'

$: << 'lib'
require 'vtd-xml-java.jar'

vg = com.ximpleware.VTDGen.new
vg.parse_file('spec/fixtures/books.xml', false)

nav = vg.get_nav
auto_pilot = com.ximpleware.AutoPilot.new(nav)
auto_pilot.selectXPath('//book/author')

while auto_pilot.eval_xpath != -1
  name = nav.get_attr_val('name')
  if name != -1
    puts nav.to_normalized_string(name)
  end
end
