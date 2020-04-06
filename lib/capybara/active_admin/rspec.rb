# frozen_string_literal: true

require 'rspec'
require 'capybara/active_admin'

RSpec.configure do |config|
  config.include Capybara::ActiveAdmin::TestHelpers, type: :system
  config.include Capybara::ActiveAdmin::TestHelpers, type: :feature
end
