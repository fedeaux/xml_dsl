# frozen_string_literal: true

require_relative 'lib/awesome_xml_dsl/version'

Gem::Specification.new do |spec|
  spec.name          = 'awesome_xml_dsl'
  spec.version       = AwesomeXmlDsl::VERSION
  spec.authors       = ["Pedro 'Fedeaux' Bernardes"]
  spec.email         = ['phec06@gmail.com']

  spec.summary       = 'A simple yet powerful ruby dsl for generating XML files'
  spec.homepage      = 'https://github.com/fedeaux/xml_dsl'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/fedeaux/xml_dsl'
  spec.metadata['changelog_uri'] = 'https://github.com/fedeaux/xml_dsl'

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(/^(test|spec|features|examples)|as_one_file/)
    end
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
