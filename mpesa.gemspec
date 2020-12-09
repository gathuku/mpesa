# frozen_string_literal: true

require_relative 'lib/mpesa/version'

Gem::Specification.new do |spec|
  spec.name          = 'mpesa'
  spec.version       = Mpesa::VERSION
  spec.authors       = ['Moses Gathuku']
  spec.email         = ['mosesgathuku95@gmail.com']

  spec.summary       = 'a simple gem to integrate ruby with mpesa Apis'
  spec.description   = 'the gem will allow you to simply integrate eithmpesa api'
  spec.homepage      = 'https://github.com/gathuku/ruby_mpesa'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com/gathuku'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/gathuku/ruby_mpesa'
  spec.metadata['changelog_uri'] = 'https://github.com/gathuku/ruby_mpesa'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~>2.1.4'
  spec.add_development_dependency 'rake', '~>12.3'
  # dependancies
  spec.add_runtime_dependency 'faraday', '~> 0.17.0'
  spec.add_runtime_dependency 'json', '~> 2.2'
  spec.add_runtime_dependency 'openssl', '~> 2.1'
  # request
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-reporters', '~> 1.4'
  spec.add_development_dependency 'vcr', '~> 5.0'
  spec.add_development_dependency 'webmock', '~> 3.7', '>= 3.7.6'
  # debugging
  spec.add_development_dependency 'byebug', '~> 11.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.7'
  # code coverage
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'simplecov', '~> 0.16.1'
end
