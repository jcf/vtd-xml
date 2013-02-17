# encoding: utf-8
$: << 'lib'
require 'vtd/xml/version'

Gem::Specification.new do |gem|
  gem.name          = 'vtd-xml'
  gem.version       = VTD::Xml::VERSION
  gem.platform =    'java'

  gem.authors       = ['James Conroy-Finn']
  gem.email         = ['james@logi.cl']

  gem.description   = %q{VTD-XML for JRuby}
  gem.summary       = %q{A thin wrapper around the VTD-XML Java library}
  gem.homepage      = 'https://github.com/jcf/vtd-xml'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rake'
end
