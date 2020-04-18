# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in capybara_active_admin.gemspec
gemspec

gem 'capybara'
gem 'selenium-webdriver'
# https://github.com/mattheworiordan/capybara-screenshot/issues/225#issuecomment-409407825
gem 'cuprite'
gem 'puma'
gem 'rake', '~> 12.0'
gem 'rspec-rails', '~> 4.0'
gem 'rubocop', '~> 0.81.0', require: false
gem 'system_test_html_screenshots', require: false
gem 'yard', require: false

gem 'activeadmin', ENV.fetch('ACTIVE_ADMIN_VERSION', '~> 2.0'), require: false
gem 'rails', ENV.fetch('RAILS_VERSION', '6.0.0')

# responders 3 drops ruby 2.3 support
if RUBY_VERSION =~ /^2\.3/
  gem 'responders', '~> 2.4'
else
  gem 'responders' # rubocop:disable Bundler/DuplicatedGem
end

gem 'sassc-rails', '2.1.2'
gem 'sprockets', '3.7.2'
gem 'sqlite3', '1.4.1'
