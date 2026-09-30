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
  spec.required_ruby_version = Gem::Requirement.new('>= 3.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  # Whitelist, not a reject list: a new directory in the repo does not
  # reach consumers until it is named here. The reject form needs a new
  # pattern every time the repo grows one, and that is how the VuePress site under docs/
  # ended up published in the first place.
  # `exe/` matches the bindir below; `bin/` is setup/console dev scripts
  # and stays out.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z -- lib exe README.md LICENSE.txt CHANGELOG.md`.split("\x0")
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activeadmin', '>= 3.0', '< 4.0'
  # spec.add_dependency 'devise'
  spec.add_dependency 'rspec', '~> 3.0'
end
