lib = File.expand_path('../lib', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arma-tvt-loadouts/version'

Gem::Specification.new do |spec|
  spec.name          = 'arma-tvt-loadouts'
  spec.version       =  ArmA::TvT::Loadouts::VERSION
  spec.authors       = ['galevsky']
  spec.email         = ['galevsky@gmail.com']
  spec.licenses      = ['WTFPL']

  spec.summary       = %q{insert loadouts in ArmA3 missions}
  spec.description   = %q{This tools aims at loading loadouts in missions thanks to external configuration.}
  spec.homepage      = 'http://ofcrav2.org/forum/index.php'

  
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = Gem::Requirement.new(">= 3.3")

  spec.add_development_dependency 'bundler', '~> 2.4'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.0'
  spec.add_development_dependency 'ocran', '~> 1.3', '>= 1.3.15'

  spec.add_runtime_dependency 'sqm2json', '~> 0.0.4'
  spec.add_runtime_dependency 'thor', '~> 1.3.1'
  spec.add_runtime_dependency 'liquid', '~> 5.5'
  spec.add_runtime_dependency 'super_stack', '~> 1.0'
end
