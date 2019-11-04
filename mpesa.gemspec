require_relative 'lib/mpesa/version'

Gem::Specification.new do |spec|
  spec.name          = "mpesa"
  spec.version       = Mpesa::VERSION
  spec.authors       = ["Moses Gathuku"]
  spec.email         = ["mosesgathuku95@gmail.com"]

  spec.summary       = %q{a simple gem to integrate ruby with mpesa Apis}
  spec.description   = %q{the gem will allow you to simply integrate eithmpesa api}
  spec.homepage      = "https:://gathuku.tech"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://github.com/gathuku/ruby_mpesa"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/gathuku/ruby_mpesa"
  spec.metadata["changelog_uri"] = "https://github.com/gathuku/ruby_mpesa"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
