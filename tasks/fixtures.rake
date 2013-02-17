namespace :fixtures do
  desc 'Generate XML fixtures for tests'
  task :generate do
    require 'vtd/xml/generator'

    root = File.expand_path '../../spec/fixtures', __FILE__
    VTD::Xml::Generator.new(root).generate
  end
end
