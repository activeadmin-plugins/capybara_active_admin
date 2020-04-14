# frozen_string_literal: true

require 'capybara/active_admin/finders/layout'
require 'capybara/active_admin/finders/table'
require 'capybara/active_admin/finders/attributes_table'
require 'capybara/active_admin/finders/form'

module Capybara
  module ActiveAdmin
    module Finders
      # Finders are methods that find node element(s) or change current scope to node element.

      include Finders::Layout
      include Finders::Table
      include Finders::AttributesTable
      include Finders::Form
    end
  end
end
