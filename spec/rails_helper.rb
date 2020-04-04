# frozen_string_literal: true

require 'spec_helper'

ENV['RAILS_ENV'] = 'test'

require_relative 'dummy/test_application'

require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'system_test_html_screenshots'
require 'capybara/cuprite'

Capybara.server = :puma
Capybara.default_driver = :cuprite
Capybara.javascript_driver = :cuprite

Capybara.default_max_wait_time = 5
Capybara.configure do |config|
  config.match = :prefer_exact
end

Capybara.register_driver :cuprite_headless do |app|
  Capybara::Cuprite::Driver.new(app, {
      logger: nil,
      js_errors: true,
      window_size: [1920, 1080],
      timeout: 5,
      process_timeout: 5,
      url_whitelist: %w(http://127.0.0.1:* http://localhost:* http://lvh.me:*),
      # https://peter.sh/experiments/chromium-command-line-switches/
      browser_options: {
          'disable-gpu' => nil,
          'no-sandbox' => nil,
          'disable-setuid-sandbox' => nil,
          'start-maximized' => nil
      }
  })
end

Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(app, {
      headless: false,
      logger: nil,
      js_errors: true,
      window_size: [1920, 1080],
      timeout: 5,
      process_timeout: 5,
      url_whitelist: %w(http://127.0.0.1:* http://localhost:* http://lvh.me:*),
      # https://peter.sh/experiments/chromium-command-line-switches/
      browser_options: {
          'disable-gpu' => nil,
          'no-sandbox' => nil,
          'disable-setuid-sandbox' => nil,
          'start-maximized' => nil
      }
  })
end

Capybara.javascript_driver = ENV['JS_DRIVER'].presence&.to_sym || :cuprite_headless

Capybara.register_server :puma do |app, port, host, options = {}|
  require 'rack/handler/puma'
  Rack::Handler::Puma.run(app, { Host: host, Port: port, Threads: '0:1', workers: 0, daemon: false }.merge(options))
end

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures = false

  # config.include Devise::Test::ControllerHelpers, type: :controller
  config.include ActiveAdminRspec::SystemTestMatchers, type: :system

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by Capybara.javascript_driver
  end

  config.after(:each, type: :system) do
    Capybara.reset_sessions!
  end

  config.before(:suite) do
    # Clear old screenshots before tests started.
    screenshot_path = Rails.root.join('tmp/screenshots')
    FileUtils.rm_f Dir["#{screenshot_path}/*"]

    # Truncate log file before tests started.
    log_file = Rails.root.join('tmp/log/test.log')
    File.truncate(log_file, 0) if File.exist?(log_file)
  end
end

# Force deprecations to raise an exception.
ActiveSupport::Deprecation.behavior = :raise
