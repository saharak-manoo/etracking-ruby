require File.expand_path('../lib/etracking/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'etracking'
  s.version     = Etracking::VERSION
  s.date        = '2020-04-27'
  s.summary     = 'For eTracking api'
  s.description = 'For eTracking api'
  s.authors     = ['Saharak Manoo']
  s.email       = 'Saharakmanoo@outlook.com'
  s.files       = ["lib/etracking.rb", "lib/etracking/client.rb"]
  s.homepage    = 'https://github.com/Saharak-Dove/etracking-ruby'
  s.license     = 'MIT'
  s.executables << 'etracking'

  s.add_development_dependency 'addressable', '~> 2.3'
  s.add_development_dependency 'bundler', '~> 1.11'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 3.8'
end