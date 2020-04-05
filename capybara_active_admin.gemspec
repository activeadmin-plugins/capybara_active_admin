# frozen_string_literal: true

require_relative 'lib/capybara/active_admin/version'

Gem::Specification.new do |spec|
  spec.name          = 'capybara_active_admin'
  spec.version       = Capybara::ActiveAdmin::VERSION
  spec.authors       = ['Denis Talakevich']
  spec.email         = ['senid231@gmail.com']

  spec.summary       = 'Capybara DSL for fast and easy testing Active Admin applications.'
  spec.description   = 'Capybara DSL for fast and easy testing Active Admin applications.'
  spec.homepage      = 'https://github.com/active_admin_plugins/capybara_active_admin'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activeadmin'
  # spec.add_dependency 'devise'
  spec.add_dependency 'rspec', '~> 3.0'
end
