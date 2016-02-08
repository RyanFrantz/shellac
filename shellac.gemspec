$LOAD_PATH << File.expand_path("lib/", __FILE__)
require File.dirname(__FILE__) + '/lib/shellac/version'

Gem::Specification.new do |s|
  s.name        = 'shellac'
  s.summary     = "A REPL for Varnish's varnishlog command"
  s.version     = Shellac::VERSION
  s.authors     = ['Ryan Frantz']
  s.email       = ['ryanleefrantz@gmail.com']
  s.homepage    = 'https://github.com/RyanFrantz/shellac'
  s.license     = 'MIT'

  s.files       = Dir.glob(['lib/*.rb', 'lib/**/*.rb', 'bin/*', 'spec/*', 'Rakefile'])
  s.executables = ['shellac']
  s.required_ruby_version = '>=1.9.2'

  s.add_runtime_dependency 'ripl', '>= 0.7.1'
  s.add_development_dependency 'rspec', '>=3.4.0'

  s.description = <<-DESCRIPTION_END
  shellac is a REPL for Varnish's varnishlog command.
  It's a simple tool for interacting with an HTTP request/response 
  and the request/response seen/sent by varnishlog.
  The goal is to help operators dissect activity on very busy Varnish servers.
DESCRIPTION_END

end
