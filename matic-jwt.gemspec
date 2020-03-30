
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'matic-jwt/version'

Gem::Specification.new do |spec|
  spec.name          = 'matic-jwt'
  spec.version       = MaticJWT::VERSION
  spec.authors       = ['Yurii Danyliak']
  spec.email         = ['ydanyliak@getmatic.com']

  spec.summary       = "Matic's JWT implementation"
  spec.description   = 'This gem contains specific implementation of JWT authentication to be used inside of Matic products.'
  spec.homepage      = 'https://github.com/matic-insurance/matic-jwt-wrapper'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'jwt'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
