# frozen_string_literal: true

RSpec.describe 'Run Dummy app in test environment', js: true do
  before do
    ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
    User.create!(full_name: 'John Doe')
    User.create!(full_name: 'Jane Air')
  end
  it 'running Dummy application' do
    puts '================ Capybara Active Admin ==================='
    visit admin_users_path
    page.driver.pause
  end
end
