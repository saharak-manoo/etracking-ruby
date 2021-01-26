require File.expand_path('../lib/etrackings/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'etrackings'
  s.version     = Etrackings::VERSION
  s.date        = '2020-04-29'
  s.summary     = 'For ETrackings API'
  s.description = 'For ETrackings API'
  s.authors     = ['Saharak Manoo']
  s.email       = 'Saharakmanoo@outlook.com'
  s.files       = ["lib/etrackings.rb", "lib/etrackings/client.rb"]
  s.homepage    = 'https://github.com/Saharak-Dove/etracking-ruby'
  s.license     = 'MIT'
  s.executables << 'etrackings'

  s.add_development_dependency 'addressable', '~> 2.3'
  s.add_development_dependency 'bundler', '~> 1.11'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 3.8'
end