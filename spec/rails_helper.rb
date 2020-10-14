# frozen_string_literal: true

require 'bundler/setup'

ENV['RAILS_ENV'] = 'test'

require_relative 'dummy/test_application'

require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'system_test_html_screenshots'
require 'capybara/cuprite'

# gem files
require 'capybara/active_admin/rspec'

# Force deprecations to raise an exception.
ActiveSupport::Deprecation.behavior = :raise

# Capybara generic config
Capybara.default_max_wait_time = 5
Capybara.configure do |config|
  config.match = :prefer_exact
end

# Capybara JS driver
cuprite_opts = {
    js_errors: true,
    window_size: [1920, 1080],
    timeout: 10,
    process_timeout: 10,
    url_whitelist: %w[http://127.0.0.1:* http://localhost:* http://lvh.me:*],
    browser_options: {
        'disable-gpu' => nil,
        'no-sandbox' => nil,
        'disable-setuid-sandbox' => nil,
        'start-maximized' => nil
    }
}

Capybara.register_driver :cuprite_headless do |app|
  Capybara::Cuprite::Driver.new(app, cuprite_opts)
end

Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(app, cuprite_opts.merge(headless: false, window_size: [1440, 900]))
end

Capybara.javascript_driver = ENV['JS_DRIVER'].presence&.to_sym || :cuprite_headless

# Capybara server
Capybara.register_server :puma do |app, port, host, options = {}|
  require 'rack/handler/puma'
  puma_opts = { Host: host, Port: port, Threads: '0:1', workers: 0, daemon: false }
  Rack::Handler::Puma.run(app, puma_opts.merge(options))
end

Capybara.server = :puma

RSpec.configure do |config|
  # RSpec generic configuration
  config.disable_monkey_patching!
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.color = true
  config.order = :random
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # RSpec rails configurations
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures = false

  # config.include Devise::Test::ControllerHelpers, type: :controller

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
