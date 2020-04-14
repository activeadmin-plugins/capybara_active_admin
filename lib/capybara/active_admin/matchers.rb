# frozen_string_literal: true

require 'capybara/active_admin/matchers/layout'
require 'capybara/active_admin/matchers/table'
require 'capybara/active_admin/matchers/attributes_table'
require 'capybara/active_admin/matchers/form'

module Capybara
  module ActiveAdmin
    module Matchers
      # RSpec matchers should be putted here.

      include Matchers::Layout
      include Matchers::Table
      include Matchers::AttributesTable
      include Matchers::Form
    end
  end
end
